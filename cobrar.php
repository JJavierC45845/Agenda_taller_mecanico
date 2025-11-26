<?php
require_once 'inc/conectar.php';
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Verificar si el usuario está logueado
if (!isset($_SESSION['user_id'])) {
     // Si es una petición AJAX, responde con error JSON
    if (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
        echo json_encode(['ok' => false, 'error' => 'Sesión expirada.']);
        exit;
    }
    header('Location: login.php');
    exit();
}

// --- MANEJO DE AJAX (POST) ---
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    $empleado_id_sesion = $_SESSION['user_id'] ?? null;
    $action = $_POST['action'];

    if ($action === 'crear_y_pagar_factura') {
        $cliente_id = intval($_POST['cliente_id']);
        $moto_id = !empty($_POST['moto_id']) ? intval($_POST['moto_id']) : null;
        $cart_json = $_POST['cart'] ?? '[]';
        $cart = json_decode($cart_json, true);

        if (empty($cliente_id) || empty($cart)) {
            echo json_encode(['ok' => false, 'error' => 'Faltan datos (cliente o ítems).']);
            exit;
        }

        // VALIDACIÓN: Si hay un servicio en el carrito, la moto_id es obligatoria
        $hayServicios = false;
        foreach ($cart as $item) {
            if ($item['tipo'] === 'servicio') {
                $hayServicios = true;
                break;
            }
        }
        
        if ($hayServicios && empty($moto_id)) {
            echo json_encode(['ok' => false, 'error' => 'Se incluyó un servicio, pero no se seleccionó ninguna moto.']);
            exit;
        }

        try {
            $pdo->beginTransaction();
            
            $total = 0;
            foreach ($cart as $item) {
                $total += (floatval($item['precio_unitario']) * intval($item['cantidad']));
            }

            // Se inserta el estado 'pagada' y el total calculado
            $numero_factura = 'F' . time();
            $stmt = $pdo->prepare("INSERT INTO facturas (numero_factura, cliente_id, moto_id, total, empleado_id, estado) VALUES (?, ?, ?, ?, ?, 'pagada')");
            $stmt->execute([$numero_factura, $cliente_id, $moto_id, $total, $empleado_id_sesion]);
            $factura_id = $pdo->lastInsertId();

            $stmt_detalle = $pdo->prepare("INSERT INTO factura_detalles (factura_id, tipo, servicio_id, producto_id, descripcion, cantidad, precio_unitario, subtotal) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            
            foreach ($cart as $item) {
                $subtotal = floatval($item['precio_unitario']) * intval($item['cantidad']);
                $stmt_detalle->execute([
                    $factura_id,
                    $item['tipo'],
                    $item['tipo'] === 'servicio' ? $item['id'] : null,
                    $item['tipo'] === 'producto' ? $item['id'] : null,
                    $item['descripcion'],
                    $item['cantidad'],
                    $item['precio_unitario'],
                    $subtotal
                ]);
            }

            $pdo->commit();
            echo json_encode(['ok' => true, 'factura_id' => $factura_id, 'message' => 'Factura creada y pagada.']);
        
        } catch (Exception $e) {
            $pdo->rollBack();
            echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
        }
        exit;
    }
    exit;
}

// --- MANEJO DE AJAX (GET) ---
if (isset($_GET['action'])) {
    if ($_GET['action'] === 'clientes') {
        $res = $pdo->query("SELECT id, nombre FROM clientes WHERE rol_id = 3 ORDER BY nombre");
        echo json_encode($res->fetchAll());
        exit;
    }
    if ($_GET['action'] === 'motos' && isset($_GET['cliente_id'])) {
        $cliente_id = intval($_GET['cliente_id']);
        $stmt = $pdo->prepare("SELECT id, modelo, placa FROM motos WHERE cliente_id = ? ORDER BY modelo");
        $stmt->execute([$cliente_id]);
        echo json_encode($stmt->fetchAll());
        exit;
    }
    if ($_GET['action'] === 'servicios') {
        $res = $pdo->query("SELECT id, nombre, costo_general FROM servicios ORDER BY nombre");
        echo json_encode($res->fetchAll());
        exit;
    }
    if ($_GET['action'] === 'productos') {
        $res = $pdo->query("SELECT id, nombre, precio_unitario FROM inventario WHERE cantidad > 0 ORDER BY nombre");
        echo json_encode($res->fetchAll());
        exit;
    }
    exit;
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cobrar servicio / producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="style/estandar.css"> 
</head>
<body>
    <div class="container-fluid p-0">
        <div class="row">
            <div class="sidebar col-auto col-md-3 col-lg-2 min-vh-100 d-flex flex-column" id="sidebar" style="width: 250px;">
                <div class="px-3">
                    <div class="sidebar-header">
                        <h4>Menú</h4>
                    </div>
                </div>
                <div class="flex-grow-1" style="overflow-y: auto; overflow-x: hidden;">
                    <div class="px-3"> 
                        <ul class="nav flex-column mt-3">
                            <li class="nav-item"><a href="menu.php" class="nav-link"><i class="bi bi-house-fill me-2"></i><span class="sidebar-text">Inicio</span></a></li>
                           <li class="nav-item"><a href="agendar.php" class="nav-link"><i class="bi bi-calendar-plus-fill me-2"></i><span class="sidebar-text">Agendar cita</span></a></li>
                            <li class="nav-item"><a href="agendadas.php" class="nav-link"><i class="bi bi-calendar-check-fill me-2"></i><span class="sidebar-text">Ver citas</span></a></li>
                            <li class="nav-item"><a href="eliminar.php" class="nav-link"><i class="bi bi-calendar-x-fill me-2"></i><span class="sidebar-text">Eliminar cita</span></a></li>
                            <li class="nav-item"><a href="cobrar.php" class="nav-link active"><i class="bi bi-cash-coin"></i><span class="sidebar-text">Cobrar</span></a></li>
                        </ul>
                    </div>
                </div>
                <div class="px-3 py-4" style="border-top: 1px solid var(--color-accent);">
                    <a href="cerrar_sesion.php" class="nav-link">
                        <i class="bi bi-box-arrow-left me-2"></i>
                        <span class="sidebar-text">Cerrar Sesión</span>
                    </a>
                </div>
            </div>
            
            <div class="main-content col">
                <button class="btn toggle-btn mb-3 d-md-none" id="sidebar-toggle">
                    <i class="bi bi-list"></i>
                </button>
                <h1>Cobrar Servicio / Producto</h1>
                
                <div id="alertPlaceholder"></div>

                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Paso 1: Datos del Cliente</h5>
                    </div>
                    <div class="card-body">
                        <form id="customerForm">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="clientName" class="form-label">Nombre del Cliente</label>
                                    <select class="form-select" id="clientName" required></select>
                                </div>
                                <div class="col-md-6" id="motoDiv">
                                    <label for="motocliente" class="form-label">Moto del cliente (Opcional)</label>
                                    <select class="form-select" id="motocliente"></select>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Paso 2: Añadir Ítems</h5>
                    </div>
                    <div class="card-body">
                        <form id="addItemForm">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="tipo" class="form-label">Tipo</label>
                                    <select class="form-select" id="tipo" required>
                                        <option value="servicio" selected>Servicio</option>
                                        <option value="producto">Producto</option>
                                    </select>
                                </div>
                                
                                <div class="col-md-8" id="servicioDiv">
                                    <label for="serviceProduct" class="form-label">Servicio</label>
                                    <select class="form-select" id="serviceProduct"></select>
                                </div>
                                <div class="col-md-8 d-none" id="productoDiv">
                                    <label for="producto" class="form-label">Producto</label>
                                    <select class="form-select" id="producto"></select>
                                </div>
                                
                                <div class="col-md-12">
                                    <label for="descripcion" class="form-label">Descripción</label>
                                    <input type="text" class="form-control" id="descripcion" placeholder="Descripción (se auto-rellena)" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="precio_unitario_manual" class="form-label">Precio Unitario</label>
                                    <input type="number" step="0.01" class="form-control" id="precio_unitario_manual" min="0" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="quantity" class="form-label">Cantidad</label>
                                    <input type="number" class="form-control" id="quantity" min="1" value="1" required>
                                </div>
                            </div>
                            <button type="button" class="btn btn-primary mt-3" id="addItemButton" onclick="addItemToCart()">
                                <i class="bi bi-plus-circle"></i> Añadir a la lista
                            </button>
                        </form>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Paso 3: Lista de Cobro</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover mb-0" id="cartTable">
                                <thead>
                                    <tr>
                                        <th>Tipo</th>
                                        <th>Descripción</th>
                                        <th>Cant.</th>
                                        <th class="text-end">P. Unitario</th>
                                        <th class="text-end">Subtotal</th>
                                        <th>Acción</th>
                                    </tr>
                                </thead>
                                <tbody id="cartItemsBody">
                                    <tr><td colspan="6" class="text-center">Añada ítems para continuar.</td></tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="total-section mt-4">
                            <span class="total-label" style="color: var(--text-light);">Total a Pagar: </span>
                            <span id="totalAmount" style="color: var(--text-light); font-size: 1.5rem; font-weight: 600;">$0.00</span>
                        </div>
                        <button type="button" class="btn btn-primary mt-3" onclick="processPayment()">
                            <i class="bi bi-check-lg"></i> Procesar Pago y Comprobante de Pago
                        </button>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    let cart = []; // Carrito de compras
    
    // Sidebar toggle
    document.getElementById('sidebar-toggle').addEventListener('click', function() {
        document.getElementById('sidebar').classList.toggle('sidebar-collapsed');
        document.body.classList.toggle('sidebar-expanded');
    });

    // Alerta universal
    function showAlert(message, type = 'danger') {
        const alertPlaceholder = document.getElementById('alertPlaceholder');
        const wrapper = document.createElement('div');
        wrapper.innerHTML = [
            `<div class="alert alert-${type} alert-dismissible fade show" role="alert">`,
            `   <div>${message}</div>`,
            '   <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>',
            '</div>'
        ].join('');
        alertPlaceholder.append(wrapper);
        setTimeout(() => {
            if (wrapper.firstChild) {
                new bootstrap.Alert(wrapper.firstChild).close();
            }
        }, 5000);
    }

    // --- Carga de datos ---
    function cargarClientes() {
        fetch('?action=clientes')
            .then(r => r.json())
            .then(clientes => {
                let sel = document.getElementById('clientName');
                sel.innerHTML = '<option value="">Seleccione cliente...</option>';
                clientes.forEach(c => sel.innerHTML += `<option value="${c.id}">${c.nombre}</option>`);
            }).catch(e => console.error('Error cargando clientes:', e));
    }
    
    function cargarMotos(cliente_id) {
        let sel = document.getElementById('motocliente');
        sel.innerHTML = '<option value="">Cargando motos...</option>';
        fetch('?action=motos&cliente_id='+cliente_id)
        .then(r=>r.json())
        .then(motos=>{
            sel.innerHTML = '<option value="">Seleccione la moto (opcional)...</option>';
            if (motos.length === 0) {
                 sel.innerHTML = '<option value="">Este cliente no tiene motos</option>';
            } else {
                 motos.forEach(m=> sel.innerHTML += `<option value="${m.id}">${m.modelo} (${m.placa || 'N/A'})</option>`);
            }
            // MODIFICADO: Llamar a la validación
            checkCanAddService();
        }).catch(e => {
            console.error('Error cargando motos:', e);
            sel.innerHTML = '<option value="">Error al cargar motos</option>';
            checkCanAddService();
        });
    }

    function cargarServicios() {
        fetch('?action=servicios').then(r=>r.json()).then(servicios=>{
            let sel = document.getElementById('serviceProduct');
            sel.innerHTML = '<option value="">Seleccione servicio...</option>';
            servicios.forEach(s=> sel.innerHTML += `<option value="${s.id}" data-precio="${s.costo_general}" data-desc="${s.nombre}">${s.nombre} ($${parseFloat(s.costo_general).toFixed(2)})</option>`);
        }).catch(e => console.error('Error cargando servicios:', e));
    }
    
    function cargarProductos() {
        fetch('?action=productos').then(r=>r.json()).then(productos=>{
            let sel = document.getElementById('producto');
            sel.innerHTML = '<option value="">Seleccione producto...</option>';
            productos.forEach(p=> sel.innerHTML += `<option value="${p.id}" data-precio="${p.precio_unitario}" data-desc="${p.nombre}">${p.nombre} ($${parseFloat(p.precio_unitario).toFixed(2)})</option>`);
        }).catch(e => console.error('Error cargando productos:', e));
    }

    // --- Lógica del formulario de añadir ítem ---
    document.addEventListener('DOMContentLoaded', function() {
        cargarClientes();
        cargarServicios();
        cargarProductos();

        document.getElementById('clientName').addEventListener('change', function() {
            if (this.value) {
                cargarMotos(this.value);
            } else {
                // Limpiar motos si no hay cliente
                document.getElementById('motocliente').innerHTML = '<option value="">Seleccione un cliente primero</option>';
                checkCanAddService();
            }
        });

        document.getElementById('tipo').addEventListener('change', function() {
            if (this.value === 'servicio') {
                document.getElementById('servicioDiv').classList.remove('d-none');
                document.getElementById('productoDiv').classList.add('d-none');
            } else {
                document.getElementById('servicioDiv').classList.add('d-none');
                document.getElementById('productoDiv').classList.remove('d-none');
            }
            // MODIFICADO: Llamar a la validación
            checkCanAddService();
            autofillFields();
        });

        document.getElementById('serviceProduct').addEventListener('change', autofillFields);
        document.getElementById('producto').addEventListener('change', autofillFields);
    });

    function autofillFields() {
        let tipo = document.getElementById('tipo').value;
        let sel = (tipo === 'servicio') ? document.getElementById('serviceProduct') : document.getElementById('producto');
        let descInput = document.getElementById('descripcion');
        let precioInput = document.getElementById('precio_unitario_manual');
        
        let selectedOption = sel.selectedOptions[0];
        if (selectedOption && selectedOption.value) {
            descInput.value = selectedOption.getAttribute('data-desc') || '';
            precioInput.value = selectedOption.getAttribute('data-precio') || '0.00';
        } else {
            descInput.value = '';
            precioInput.value = '0.00';
        }
    }
    
    // --- MODIFICADO: Lógica de Carrito y Validación ---

    /**
     * Verifica si se puede agregar un servicio basado en si el cliente tiene motos.
     * Habilita o deshabilita el botón "Añadir a la lista".
     */
    function checkCanAddService() {
        const tipo = document.getElementById('tipo').value;
        const motoSelect = document.getElementById('motocliente');
        const addButton = document.getElementById('addItemButton');
        
        if (tipo === 'servicio') {
            // Si no hay cliente seleccionado O si el select de motos tiene 1 opción (o menos) Y su valor es ""
            // (esto cubre "Seleccione moto..." y "Este cliente no tiene motos")
            if (!document.getElementById('clientName').value || (motoSelect.options.length <= 1 && motoSelect.value === "")) {
                showAlert('Para agregar un servicio, seleccione un cliente que tenga motos registradas.', 'warning');
                addButton.disabled = true;
            } else {
                addButton.disabled = false;
            }
        } else {
            // Es producto, siempre habilitado
            addButton.disabled = false;
        }
    }

    function addItemToCart() {
        let tipo = document.getElementById('tipo').value;
        let sel = (tipo === 'servicio') ? document.getElementById('serviceProduct') : document.getElementById('producto');
        let motoSelect = document.getElementById('motocliente');
        
        let id = sel.value;
        let descripcion = document.getElementById('descripcion').value;
        let precio_unitario = parseFloat(document.getElementById('precio_unitario_manual').value);
        let cantidad = parseInt(document.getElementById('quantity').value);

        // --- VALIDACIÓN MEJORADA ---
        if (!document.getElementById('clientName').value) {
            showAlert('Debe seleccionar un cliente primero.', 'danger');
            return;
        }
        
        if (tipo === 'servicio' && (!motoSelect.value || motoSelect.options.length <= 1)) {
            showAlert('Debe seleccionar una moto válida para agregar un servicio. (Este cliente podría no tener motos).', 'danger');
            return;
        }

        if (!id || !descripcion || cantidad < 1 || precio_unitario < 0) {
            showAlert('Por favor, seleccione un ítem y verifique la descripción, cantidad y precio.', 'danger');
            return;
        }
        // --- Fin Validación ---

        cart.push({
            id: id,
            tipo: tipo,
            descripcion: descripcion,
            cantidad: cantidad,
            precio_unitario: precio_unitario
        });

        document.getElementById('addItemForm').reset();
        autofillFields();
        checkCanAddService(); // Re-chequear estado del botón
        
        renderCart();
    }

    function renderCart() {
        let tbody = document.getElementById('cartItemsBody');
        tbody.innerHTML = '';
        let granTotal = 0;
        
        if (cart.length === 0) {
            tbody.innerHTML = '<tr><td colspan="6" class="text-center">Añada ítems para continuar.</td></tr>';
            document.getElementById('totalAmount').textContent = '$0.00';
            return;
        }

        cart.forEach((item, index) => {
            let subtotal = item.precio_unitario * item.cantidad;
            granTotal += subtotal;
            let badgeClass = (item.tipo === 'servicio') ? 'bg-primary' : 'bg-secondary';
            
            tbody.innerHTML += `
                <tr>
                    <td><span class="badge ${badgeClass}">${item.tipo}</span></td>
                    <td>${item.descripcion}</td>
                    <td>${item.cantidad}</td>
                    <td class="text-end">$${item.precio_unitario.toFixed(2)}</td>
                    <td class="text-end fw-bold">$${subtotal.toFixed(2)}</td>
                    <td>
                        <button class="btn btn-danger btn-sm" onclick="removeItemFromCart(${index})">
                            <i class="bi bi-trash"></i>
                        </button>
                    </td>
                </tr>
            `;
        });
        
        document.getElementById('totalAmount').textContent = `$${granTotal.toFixed(2)}`;
    }

    function removeItemFromCart(index) {
        cart.splice(index, 1);
        renderCart();
    }


    function processPayment() {
        let cliente_id = document.getElementById('clientName').value;
        let moto_id = document.getElementById('motocliente').value;

        // Validación
        if (!cliente_id) {
            showAlert('Debe seleccionar un cliente (Paso 1).', 'danger');
            return;
        }
        if (cart.length === 0) {
            showAlert('Debe añadir al menos un ítem a la lista (Paso 2).', 'danger');
            return;
        }

        // --- VALIDACIÓN MEJORADA ---
        const hayServicios = cart.some(item => item.tipo === 'servicio');
        if (hayServicios && !moto_id) {
            showAlert('Se incluyó un servicio, pero no se seleccionó una moto. Por favor, seleccione la moto del cliente (Paso 1).', 'danger');
            document.getElementById('motocliente').focus();
            return;
        }
        // --- Fin Validación ---

        let formData = new URLSearchParams({
            action: 'crear_y_pagar_factura',
            cliente_id: cliente_id,
            moto_id: moto_id, // Irá vacío si no se seleccionó (solo productos)
            cart: JSON.stringify(cart)
        });

        fetch('', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: formData
        })
        .then(r=>r.json())
        .then(resp=>{
            if (resp.ok && resp.factura_id) {
                showAlert('Factura creada y pagada con éxito.', 'success');
                
                // 1. Abrir factura en nueva pestaña
                window.open(`factura.php?id=${resp.factura_id}`, '_blank');
                
                // 2. Recargar la página de cobro para limpiar todo
                window.location.reload(); 
            } else {
                showAlert(resp.error || 'Error al procesar el pago.', 'danger');
            }
        }).catch(e => showAlert('Error de conexión: ' + e.message, 'danger'));
    }
    
    </script>
</body>
</html>