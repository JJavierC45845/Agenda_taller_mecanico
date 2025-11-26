<?php
include 'inc/conectar.php';
include 'inc/funciones_busqueda.php'; 
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

if (!isset($_SESSION['user_id']) || $_SESSION['rol'] !== 'Admin') {
    header('Location: login.php');
    exit();
}

$mensaje = '';
$tipo_mensaje = '';
if (isset($_GET['msg'])) {
    $mensaje = htmlspecialchars($_GET['msg']);
    $tipo_mensaje = htmlspecialchars($_GET['status'] ?? 'info');
}

// --- LÓGICA DE PAGINACIÓN Y FILTRO (Sin cambios, ya es correcta) ---
$filas_por_pagina = 10;
$pagina_actual = isset($_GET['pagina']) ? (int)$_GET['pagina'] : 1;
if ($pagina_actual < 1) $pagina_actual = 1;
$inicio = ($pagina_actual - 1) * $filas_por_pagina;

$campos_busqueda = ['c.nombre', 'c.telefono', 'm.modelo', 'm.placa']; 
$filtro = procesarBusqueda($campos_busqueda);

$where_sql = $filtro['where_sql'];
$params_filtro = $filtro['params'];
$parametros_url = $filtro['url_params'];

if (empty($where_sql)) {
    $where_sql = "WHERE c.rol_id = 3";
} else {
    $where_sql .= " AND c.rol_id = 3";
}

// --- LÓGICA DE LECTURA (R) (Sin cambios, ya es correcta) ---
try {
    // 1. Contar el total
    $sql_total = "SELECT COUNT(DISTINCT c.id) 
                  FROM clientes c 
                  LEFT JOIN motos m ON c.id = m.cliente_id
                  $where_sql";
    $stmt_total = $pdo->prepare($sql_total);
    $stmt_total->execute($params_filtro);
    $total_filas = $stmt_total->fetchColumn();
    $total_paginas = ceil($total_filas / $filas_por_pagina);

    // 2. Obtener IDs de la página
    $sql_ids_pagina = "SELECT DISTINCT c.id, c.nombre 
                       FROM clientes c 
                       LEFT JOIN motos m ON c.id = m.cliente_id
                       $where_sql 
                       ORDER BY c.nombre 
                       LIMIT ? OFFSET ?";
    $stmt_ids = $pdo->prepare($sql_ids_pagina);
    
    $i = 1;
    foreach ($params_filtro as $param) {
        $stmt_ids->bindValue($i++, $param);
    }
    $stmt_ids->bindValue($i++, $filas_por_pagina, PDO::PARAM_INT);
    $stmt_ids->bindValue($i++, $inicio, PDO::PARAM_INT);
    $stmt_ids->execute();
    
    $ids_pagina_assoc = $stmt_ids->fetchAll(PDO::FETCH_ASSOC); 
    $ids_pagina = array_column($ids_pagina_assoc, 'id'); 

    $clientes_pagina = [];
    if (!empty($ids_pagina)) {
        // 3. Obtener datos completos para esos IDs
        $placeholders = implode(',', array_fill(0, count($ids_pagina), '?'));
        
        $sql_data = "SELECT c.id, c.nombre, c.telefono, m.id as moto_id, m.modelo, m.placa, m.ano
                     FROM clientes c
                     LEFT JOIN motos m ON c.id = m.cliente_id
                     WHERE c.id IN ($placeholders) AND c.rol_id = 3
                     ORDER BY c.nombre, m.id"; 
        $stmt_data = $pdo->prepare($sql_data);
        $stmt_data->execute($ids_pagina);
        $result_data = $stmt_data->fetchAll(PDO::FETCH_ASSOC);

        // Agrupar motos por cliente
        $clientes_temp = [];
        foreach ($result_data as $row) {
            $cliente_id = $row['id'];
            if (!isset($clientes_temp[$cliente_id])) {
                $clientes_temp[$cliente_id] = [
                    'id' => $row['id'],
                    'nombre' => $row['nombre'],
                    'telefono' => $row['telefono'],
                    'motos' => []
                ];
            }
            if ($row['moto_id']) { 
                $clientes_temp[$cliente_id]['motos'][] = [
                    'moto_id' => $row['moto_id'],
                    'modelo' => $row['modelo'],
                    'placa' => $row['placa'],
                    'ano' => $row['ano']
                ];
            }
        }
        foreach ($ids_pagina as $id) {
           if (isset($clientes_temp[$id])) {
                $clientes_pagina[] = $clientes_temp[$id];
           }
        }
    }
} catch (Exception $e) {
    $mensaje = "Error al cargar clientes: " . $e->getMessage();
    $tipo_mensaje = 'danger';
    $clientes_pagina = [];
    $total_paginas = 0;
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
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
                            <li class="nav-item"><a href="menua.php" class="nav-link"><i class="bi bi-house-fill me-2"></i><span class="sidebar-text">Inicio</span></a></li>
                            <li class="nav-item"><a href="gempleados.php" class="nav-link"><i class="bi bi-people-fill me-2"></i><span class="sidebar-text">Gestión de empleados</span></a></li>
                            <li class="nav-item"><a href="geclientes.php" class="nav-link active"><i class="bi bi-bookmark-check-fill me-2"></i><span class="sidebar-text">Gestión de clientes</span></a></li>
                            <li class="nav-item"><a href="servicios.php" class="nav-link"><i class="bi bi-wrench-adjustable-circle-fill me-2"></i><span class="sidebar-text">Administrar servicios</span></a></li>
                            <li class="nav-item"><a href="categorias.php" class="nav-link"><i class="bi bi-tags-fill me-2"></i><span class="sidebar-text">Gestión de categorias</span></a></li>
                            <li class="nav-item"><a href="inventario.php" class="nav-link"><i class="bi bi-box-seam-fill me-2"></i><span class="sidebar-text">Inventario</span></a></li>
                            <li class="nav-item"><a href="agendara.php" class="nav-link"><i class="bi bi-calendar-plus-fill me-2"></i><span class="sidebar-text">Agendar cita</span></a></li>
                            <li class="nav-item"><a href="agendadasa.php" class="nav-link"><i class="bi bi-calendar-check-fill me-2"></i><span class="sidebar-text">Ver citas</span></a></li>
                            <li class="nav-item"><a href="eliminara.php" class="nav-link"><i class="bi bi-calendar-x-fill me-2"></i><span class="sidebar-text">Eliminar cita</span></a></li>
                            <li class="nav-item"><a href="cobrara.php" class="nav-link"><i class="bi bi-cash-coin"></i><span class="sidebar-text">Cobrar</span></a></li>
                            <li class="nav-item"><a href="vista_detallada.php" class="nav-link"><i class="bi bi-eye-fill me-2"></i><span class="sidebar-text">Vista Citas</span></a></li>
                            <li class="nav-item"><a href="vista_factura.php" class="nav-link"><i class="bi bi-file-earmark-text-fill me-2"></i><span class="sidebar-text">Vista Facturas</span></a></li>
                            <li class="nav-item"><a href="vista_inventario.php" class="nav-link"><i class="bi bi-clipboard-data-fill me-2"></i><span class="sidebar-text">Vista Inventario</span></a></li>
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
                <h1>Gestión de Clientes y sus motos</h1>

                <div id="alertPlaceholder">
                    <?php if ($mensaje && $tipo_mensaje === 'danger'): ?>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <?php echo $mensaje; ?>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    <?php endif; ?>
                </div>

                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Acciones</h5>
                    </div>
                    <div class="card-body">
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#clientModal" onclick="prepararModalAgregar()">
                            <i class="bi bi-plus-circle"></i> Agregar Cliente
                        </button>
                    </div>
                </div>

                <div class="card">
                    <?php 
                        renderSearchForm('geclientes.php', 'Buscar cliente, tel, moto o placa...'); 
                    ?>

                    <div class="card-header">
                        <h5 class="mb-0">Lista de Clientes</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover mb-0" id="clientTable">
                                <thead>
                                    <tr>
                                        <th>Nombre</th>
                                        <th>Teléfono</th>
                                        <th>Modelo Moto</th>
                                        <th>Placa</th>
                                        <th>Año</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody id="clientTableBody">
                                    <?php if (empty($clientes_pagina)): ?>
                                        <tr>
                                            <td colspan="6" class="text-center">
                                                <?php echo isset($_GET['search']) ? 'No se encontraron clientes.' : 'No hay clientes registrados.'; ?>
                                            </td>
                                        </tr>
                                    <?php else: ?>
                                        <?php foreach ($clientes_pagina as $cliente): ?>
                                            <?php $rowCount = count($cliente['motos']) > 0 ? count($cliente['motos']) : 1; ?>
                                            <?php if (!empty($cliente['motos'])): ?>
                                                <?php foreach ($cliente['motos'] as $index => $moto): ?>
                                                    <tr>
                                                        <?php if ($index === 0): ?>
                                                            <td rowspan="<?php echo $rowCount; ?>"><?php echo htmlspecialchars($cliente['nombre']); ?></td>
                                                            <td rowspan="<?php echo $rowCount; ?>"><?php echo htmlspecialchars($cliente['telefono']); ?></td>
                                                        <?php endif; ?>
                                                        <td><?php echo htmlspecialchars($moto['modelo']); ?></td>
                                                        <td><?php echo htmlspecialchars($moto['placa'] ?? '-'); ?></td>
                                                        <td><?php echo htmlspecialchars($moto['ano'] ?? '-'); ?></td>
                                                        <td>
                                                            <?php if ($index === 0): ?>
                                                                <button class="btn btn-primary btn-sm me-1" onclick="editClient(<?php echo $cliente['id']; ?>)">
                                                                    <i class="bi bi-pencil"></i> <span class="d-none d-md-inline">Editar</span>
                                                                </button>
                                                                <button class="btn btn-danger btn-sm" onclick="deleteClient(<?php echo $cliente['id']; ?>, '<?php echo htmlspecialchars(addslashes($cliente['nombre'])); ?>')">
                                                                    <i class="bi bi-trash"></i> <span class="d-none d-md-inline">Eliminar Cliente</span>
                                                                </button>
                                                            <?php endif; ?>
                                                             <button class="btn btn-warning btn-sm mt-1" onclick="deleteMoto(<?php echo $moto['moto_id']; ?>, <?php echo $cliente['id']; ?>)">
                                                                 <i class="bi bi-bicycle"></i> <span class="d-none d-md-inline">Eliminar Moto</span>
                                                             </button>
                                                        </td>
                                                    </tr>
                                                <?php endforeach; ?>
                                             <?php else: ?>
                                                 <tr>
                                                      <td><?php echo htmlspecialchars($cliente['nombre']); ?></td>
                                                      <td><?php echo htmlspecialchars($cliente['telefono']); ?></td>
                                                      <td colspan="3" class="text-muted fst-italic">Sin motos registradas</td>
                                                      <td>
                                                           <button class="btn btn-primary btn-sm me-1" onclick="editClient(<?php echo $cliente['id']; ?>)">
                                                               <i class="bi bi-pencil"></i> <span class="d-none d-md-inline">Editar</span>
                                                           </button>
                                                           <button class="btn btn-danger btn-sm" onclick="deleteClient(<?php echo $cliente['id']; ?>, '<?php echo htmlspecialchars(addslashes($cliente['nombre'])); ?>')">
                                                               <i class="bi bi-trash"></i> <span class="d-none d-md-inline">Eliminar Cliente</span>
                                                           </button>
                                                      </td>
                                                 </tr>
                                             <?php endif; ?>
                                        <?php endforeach; ?>
                                    <?php endif; ?>
                                </tbody>
                            </table>
                            
                            <nav aria-label="paginador" class="paginador">
                                <ul class="pagination justify-content-center mt-3" id="pagination">
                                    <?php if ($total_paginas > 1): ?>
                                        <li class="page-item <?php echo ($pagina_actual <= 1) ? 'disabled' : ''; ?>">
                                            <a class="page-link" href="?pagina=<?php echo $pagina_actual - 1; ?>&<?php echo http_build_query($parametros_url); ?>">Anterior</a>
                                        </li>
                                        <li class="page-item <?php echo ($pagina_actual >= $total_paginas) ? 'disabled' : ''; ?>">
                                            <a class="page-link" href="?pagina=<?php echo $pagina_actual + 1; ?>&<?php echo http_build_query($parametros_url); ?>">Siguiente</a>
                                        </li>
                                    <?php endif; ?>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="clientModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg"> <div class="modal-content bg-dark text-light">
          
          <form id="clientForm">
            <div class="modal-header">
              <h5 class="modal-title" id="formTitle">Agregar Cliente</h5>
              <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
                <input type="hidden" id="clienteId">
                
                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="clientName" class="form-label">Nombre del Cliente</label>
                        <input type="text" class="form-control" id="clientName" placeholder="Ingrese el nombre del cliente" required>
                    </div>
                    <div class="col-md-6">
                        <label for="clientPhone" class="form-label">Número Telefónico</label>
                        <input type="tel" class="form-control" id="clientPhone" placeholder="Ingrese el número telefónico" >
                    </div>
                </div>
                
                <hr class="my-3" style="border-top: 1px solid var(--color-accent);">
                
                <h6 class="text-light">Motos del Cliente</h6>
                <div id="motoGroups">
                    </div>
                <button type="button" class="btn add-moto-btn mt-2" onclick="addMotoGroup()"><i class="bi bi-plus-circle"></i> Agregar Moto</button>
            </div>
            
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn btn-primary"><span id="saveButtonText">Guardar Cliente</span></button>
            </div>
          </form>
          
        </div>
      </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
    
    <script>
        let motoCount = 0; // Contador global para IDs únicos de grupos de moto
        
        var clientModal = new bootstrap.Modal(document.getElementById('clientModal'));

        $(document).ready(function() {
            // Manejador submit del formulario
            $('#clientForm').on('submit', function(e) {
                e.preventDefault();
                saveClient();
            });

            // Toggle Sidebar
            $('#sidebar-toggle').on('click', function() {
                $('#sidebar').toggleClass('sidebar-collapsed');
                $('body').toggleClass('sidebar-expanded');
            });

            // Auto-ocultar alertas de PHP
            setTimeout(function() {
                var alerts = document.querySelectorAll('#alertPlaceholder .alert');
                alerts.forEach(function(alert) {
                    if (alert) {
                        new bootstrap.Alert(alert).close();
                    }
                });
            }, 5000);
        });

        // Alerta universal para AJAX
        function showAlert(message, type = 'success') {
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
                 if(wrapper.firstChild) {
                    new bootstrap.Alert(wrapper.firstChild).close();
                 }
             }, 5000);
        }

        function addMotoGroup() {
            motoCount++;
            const motoGroupHtml = `
                <div class="moto-group" id="motoGroup${motoCount}">
                     <input type="hidden" class="moto-id-input"> 
                    <div class="row g-3 align-items-end">
                        <div class="col-md-4">
                            <label for="modeloMoto${motoCount}" class="form-label">Modelo</label>
                            <input type="text" class="form-control modelo-moto-input" id="modeloMoto${motoCount}" placeholder="Modelo" >
                        </div>
                        <div class="col-md-3">
                            <label for="placaMoto${motoCount}" class="form-label">Placa</label>
                            <input type="text" class="form-control placa-moto-input" id="placaMoto${motoCount}" placeholder="Placa">
                        </div>
                        <div class="col-md-3">
                            <label for="anoMoto${motoCount}" class="form-label">Año</label>
                            <input type="number" class="form-control ano-moto-input" id="anoMoto${motoCount}" placeholder="Año" min="1900" max="${new Date().getFullYear() + 1}">
                        </div>
                        <div class="col-md-2">
                             <button type="button" class="btn btn-danger btn-sm remove-moto-btn" onclick="removeMotoGroup(${motoCount})"><i class="bi bi-trash"></i></button>
                        </div>
                    </div>
                </div>
            `;
            $('#motoGroups').append(motoGroupHtml);
            updateRemoveButtonsVisibility();
        }

        function removeMotoGroup(index) {
            if ($('#motoGroups .moto-group').length > 1) {
                $(`#motoGroup${index}`).remove();
                updateRemoveButtonsVisibility();
            } else {
                showAlert('Debe haber al menos una moto.', 'warning');
            }
        }

        function updateRemoveButtonsVisibility() {
             const groups = $('#motoGroups .moto-group');
             if (groups.length <= 1) {
                 groups.find('.remove-moto-btn').hide(); 
             } else {
                 groups.find('.remove-moto-btn').show(); 
             }
        }

        // --- MODIFICADO: Esta es la antigua 'resetForm' ---
        function prepararModalAgregar() {
            $('#clientForm')[0].reset();
            $('#clienteId').val('');
            $('#formTitle').text('Agregar Cliente');
            $('#saveButtonText').text('Guardar Cliente');
            
            // Limpiar motos y añadir la primera
            $('#motoGroups').html('');
            motoCount = -1; // Resetear contador
            addMotoGroup(); // Añadir el primer grupo limpio
        }

        function saveClient() {
            const clienteId = $('#clienteId').val();
            const nombre = $('#clientName').val().trim();
            const telefono = $('#clientPhone').val().trim();
            const motos = [];
            let formIsValid = true;

            $('.moto-group').each(function() {
                const modeloInput = $(this).find('.modelo-moto-input');
                const modelo = modeloInput.val().trim();
                const placa = $(this).find('.placa-moto-input').val().trim();
                const ano = $(this).find('.ano-moto-input').val().trim();
                
                if (!modelo) {
                    showAlert('El modelo de cada moto es obligatorio.', 'danger');
                    modeloInput.focus();
                    formIsValid = false;
                    return false;
                }

                motos.push({
                    modelo: modelo,
                    placa: placa,
                    ano: ano
                });
            });

            if (!formIsValid || !nombre || !telefono) {
                 if (!nombre) $('#clientName').focus();
                 else if (!telefono) $('#clientPhone').focus();
                 showAlert('Nombre, teléfono y al menos un modelo de moto son obligatorios.', 'danger');
                return;
            }

            const action = clienteId ? 'update' : 'create';
            const ajaxData = {
                action: action,
                cliente_id: clienteId,
                nombre: nombre,
                telefono: telefono,
                motos: JSON.stringify(motos)
            };

            $.ajax({
                url: 'api/crud_clientes.php', // Apunta al backend
                type: 'POST',
                dataType: 'json',
                data: ajaxData,
                success: function(result) {
                    if (result.success) {
                        // Oculta el modal y recarga la página
                        clientModal.hide();
                        // Recargamos la página para ver los cambios (necesario por la paginación de servidor)
                        window.location.href = `geclientes.php?status=success&msg=${encodeURIComponent(result.message)}`;
                    } else {
                         showAlert(result.message, 'danger');
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error("Error AJAX:", textStatus, errorThrown, jqXHR.responseText);
                    showAlert('Error al conectar con el servidor. Revise la consola.', 'danger');
                }
            });
        }

        // --- MODIFICADO: Ahora también muestra el modal ---
        function editClient(clienteId) {
             $.ajax({
                 url: 'api/crud_clientes.php',
                 type: 'POST',
                 dataType: 'json',
                 data: { action: 'get_cliente', cliente_id: clienteId },
                 success: function(result) {
                     if (result.success && result.data) {
                         const cliente = result.data;
                         
                         // 1. Limpiar el formulario
                         prepararModalAgregar(); 
                         
                         // 2. Llenar los datos
                         $('#clienteId').val(cliente.id);
                         $('#clientName').val(cliente.nombre);
                         $('#clientPhone').val(cliente.telefono);
                         $('#formTitle').text('Editar Cliente');
                         $('#saveButtonText').text('Actualizar Cliente');

                         // 3. Limpiar y rellenar motos
                         $('#motoGroups').html('');
                         motoCount = -1; 
                         
                         if (cliente.motos && cliente.motos.length > 0) {
                             cliente.motos.forEach((moto) => {
                                 motoCount++;
                                 const motoGroupHtml = `
                                     <div class="moto-group" id="motoGroup${motoCount}">
                                         <input type="hidden" class="moto-id-input" value="${moto.moto_id || ''}"> 
                                         <div class="row g-3 align-items-end">
                                             <div class="col-md-4">
                                                 <label for="modeloMoto${motoCount}" class="form-label">Modelo</label>
                                                 <input type="text" class="form-control modelo-moto-input" id="modeloMoto${motoCount}" value="${moto.modelo || ''}" >
                                             </div>
                                             <div class="col-md-3">
                                                 <label for="placaMoto${motoCount}" class="form-label">Placa</label>
                                                 <input type="text" class="form-control placa-moto-input" id="placaMoto${motoCount}" value="${moto.placa || ''}">
                                             </div>
                                             <div class="col-md-3">
                                                 <label for="anoMoto${motoCount}" class="form-label">Año</label>
                                                 <input type="number" class="form-control ano-moto-input" id="anoMoto${motoCount}" value="${moto.ano || ''}" min="1900" max="${new Date().getFullYear() + 1}">
                                             </div>
                                             <div class="col-md-2">
                                                 <button type="button" class="btn btn-danger btn-sm remove-moto-btn" onclick="removeMotoGroup(${motoCount})"><i class="bi bi-trash"></i></button>
                                             </div>
                                         </div>
                                     </div>
                                 `;
                                 $('#motoGroups').append(motoGroupHtml);
                             });
                         } else {
                             addMotoGroup();
                         }
                         updateRemoveButtonsVisibility();
                         
                         // 4. Mostrar el modal
                         clientModal.show();

                     } else {
                         showAlert(result.message || 'No se pudieron cargar los datos del cliente.', 'danger');
                     }
                 },
                 error: function() {
                     showAlert('Error al conectar para obtener datos del cliente.', 'danger');
                 }
             });
        }


        function deleteClient(clienteId, nombreCliente) {
            if (confirm(`¿Estás seguro de eliminar al cliente "${nombreCliente}" y todas sus motos?`)) {
                $.ajax({
                    url: 'api/crud_clientes.php',
                    type: 'POST',
                    dataType: 'json',
                    data: { action: 'delete', cliente_id: clienteId },
                    success: function(result) {
                        if (result.success) {
                            window.location.href = `geclientes.php?status=success&msg=${encodeURIComponent(result.message)}`;
                        } else {
                            showAlert(result.message, 'danger');
                        }
                    },
                    error: function() {
                        showAlert('Error al conectar con el servidor para eliminar.', 'danger');
                    }
                });
            }
        }

        function deleteMoto(motoId, clienteId) {
             if (!motoId) {
                 showAlert('Error: ID de moto no encontrado.', 'danger');
                 return;
             }
            if (confirm('¿Estás seguro de eliminar solo esta moto?')) {
                $.ajax({
                    url: 'api/crud_clientes.php',
                    type: 'POST',
                    dataType: 'json',
                    data: { action: 'delete_moto', moto_id: motoId, cliente_id: clienteId },
                    success: function(result) {
                         if (result.success) {
                            window.location.href = `geclientes.php?status=success&msg=${encodeURIComponent(result.message)}`;
                        } else {
                            showAlert(result.message, 'danger');
                        }
                    },
                    error: function() {
                        showAlert('Error al conectar para eliminar la moto.', 'danger');
                    }
                });
            }
        }
        
        
    </script>
</body>
</html>