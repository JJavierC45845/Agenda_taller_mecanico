<?php
include 'inc/conectar.php';
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

if (!isset($_SESSION['user_id']) || $_SESSION['rol'] !== 'Admin') {
    header('Location: login.php');
    exit();
}

// MODIFICADO: Lógica para leer mensajes de la URL
$mensaje = '';
$tipo_mensaje = '';
if (isset($_GET['msg'])) {
    $mensaje = htmlspecialchars($_GET['msg']);
    $tipo_mensaje = htmlspecialchars($_GET['status'] ?? 'info');
}

// Obtener categorías para el select (se mantiene)
try {
    $stmt = $pdo->query("SELECT id, nombre FROM categorias ORDER BY nombre ASC");
    $categorias = $stmt->fetchAll();
} catch (Exception $e) {
    $categorias = [];
}

// CONSULTA DE INVENTARIO (con filtro y paginación)
// --- Esta sección se mantiene intacta. Es correcta y específica para esta página. ---
$filas_por_pagina = 8; 
$pagina_actual = isset($_GET['pagina']) ? (int)$_GET['pagina'] : 1;
if ($pagina_actual < 1) {
    $pagina_actual = 1;
}
$inicio = ($pagina_actual - 1) * $filas_por_pagina; // OFFSET

// Lógica de filtro (compuesta)
$where = [];
$params = [];
$parametros_url = []; 

if (!empty($_GET['search'])) {
    $where[] = "(LOWER(i.nombre) LIKE LOWER(?) OR LOWER(i.codigo_producto) LIKE LOWER(?))";
    $params[] = '%' . $_GET['search'] . '%';
    $params[] = '%' . $_GET['search'] . '%';
    $parametros_url['search'] = $_GET['search']; 
}
if (!empty($_GET['idcategoria'])) {
    $where[] = "i.categoria_id = ?";
    $params[] = $_GET['idcategoria'];
    $parametros_url['idcategoria'] = $_GET['idcategoria']; 
}
$where_sql = $where ? "WHERE " . implode(" AND ", $where) : "";

try {
    // Contar el TOTAL de filas
    $sql_total = "SELECT COUNT(*)
                  FROM inventario i
                  JOIN categorias c ON i.categoria_id = c.id
                  $where_sql";
    $stmt_total = $pdo->prepare($sql_total);
    $stmt_total->execute($params); 
    $total_filas = $stmt_total->fetchColumn();
    $total_paginas = ceil($total_filas / $filas_por_pagina);

    // --- Consulta principal con LIMIT y OFFSET para PostgreSQL ---
    $sql = "SELECT i.id, i.codigo_producto, i.nombre, c.nombre AS categoria, i.cantidad, i.precio_unitario, i.categoria_id
            FROM inventario i
            JOIN categorias c ON i.categoria_id = c.id
            $where_sql
            ORDER BY i.nombre ASC
            LIMIT ? OFFSET ?";
    
    $stmt = $pdo->prepare($sql);

    // Bindeamos los parámetros del WHERE
    $i = 1;
    foreach ($params as $param) {
        $stmt->bindValue($i, $param);
        $i++;
    }
    
    // Bindeamos los parámetros del LIMIT y OFFSET
    $stmt->bindValue($i, $filas_por_pagina, PDO::PARAM_INT); 
    $i++;
    $stmt->bindValue($i, $inicio, PDO::PARAM_INT);

    $stmt->execute();
    $inventario = $stmt->fetchAll();

} catch (Exception $e) {
    $inventario = [];
    // No sobrescribir el mensaje de éxito/error si ya existe
    if (empty($mensaje)) {
        $mensaje = "Error al cargar inventario: " . $e->getMessage();
        $tipo_mensaje = 'danger';
    }
    $total_paginas = 0; 
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Inventario</title>
    <meta name="description" content="Panel de control del sistema de gestión de taller mecánico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="style/estandar.css"> </head>
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
        <div class="px-3"> <ul class="nav flex-column mt-3">
                <li class="nav-item">
                    <a href="menua.php" class="nav-link">
                        <i class="bi bi-house-fill me-2"></i>
                        <span class="sidebar-text">Inicio</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="gempleados.php" class="nav-link">
                        <i class="bi bi-people-fill me-2"></i>
                        <span class="sidebar-text">Gestión de empleados</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="geclientes.php" class="nav-link">
                        <i class="bi bi-bookmark-check-fill me-2"></i>
                        <span class="sidebar-text">Gestión de clientes</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="servicios.php" class="nav-link">
                        <i class="bi bi-wrench-adjustable-circle-fill me-2"></i>
                        <span class="sidebar-text">Administrar servicios</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="categorias.php" class="nav-link">
                        <i class="bi bi-tags-fill me-2"></i>
                        <span class="sidebar-text">Gestión de categorias</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="inventario.php" class="nav-link active">
                        <i class="bi bi-box-seam-fill me-2"></i>
                        <span class="sidebar-text">Inventario</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="agendara.php" class="nav-link">
                        <i class="bi bi-calendar-plus-fill me-2"></i>
                        <span class="sidebar-text">Agendar cita</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="agendadasa.php" class="nav-link">
                        <i class="bi bi-calendar-check-fill me-2"></i>
                        <span class="sidebar-text">Ver citas</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="eliminara.php" class="nav-link">
                        <i class="bi bi-calendar-x-fill me-2"></i>
                        <span class="sidebar-text">Eliminar cita</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="cobrara.php" class="nav-link">
                        <i class="bi bi-cash-coin"></i>
                        <span class="sidebar-text">Cobrar</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="vista_detallada.php" class="nav-link">
                        <i class="bi bi-eye-fill me-2"></i>
                        <span class="sidebar-text">Vista Citas</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="vista_factura.php" class="nav-link"> <i class="bi bi-file-earmark-text-fill me-2"></i>
                        <span class="sidebar-text">Vista Facturas</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="vista_inventario.php" class="nav-link">
                        <i class="bi bi-clipboard-data-fill me-2"></i> <span class="sidebar-text">Vista Inventario</span>
                    </a>
                </li>
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
                <h1>Gestión de Inventario</h1>
                
                <?php if ($mensaje): ?>
                    <div class="alert alert-<?php echo $tipo_mensaje; ?> alert-dismissible fade show" role="alert">
                        <?php echo $mensaje; ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <?php endif; ?>
                
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Acciones</h5>
                    </div>
                    <div class="card-body">
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addItemModal" onclick="limpiarModal()">Agregar producto</button>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Lista de Inventario</h5>
                    </div>
                    
                    <form action="" method="get" class="card-body pb-0">
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" placeholder="Buscar por nombre o código..." name="search" aria-label="Buscar ítem" value="<?php echo isset($_GET['search']) ? htmlspecialchars($_GET['search']) : ''; ?>">
                            <button class="btn btn-primary" type="submit"><i class="bi bi-search"></i></button>
                            <a href="inventario.php" class="btn btn-secondary">
                                <i class="bi bi-arrow-counterclockwise"></i>
                            </a>
                        </div>
                        <div class="col-md-4 mt-2"> <label for="idcategoria" class="form-label">Filtrar por categoria</label>
                            <select name="idcategoria" class="form-select" onchange="this.form.submit()">
                                <option value="">Todas las categorías</option>
                                <?php foreach ($categorias as $cat): ?>
                                    <option value="<?php echo $cat['id']; ?>" <?php if(isset($_GET['idcategoria']) && $_GET['idcategoria']==$cat['id']) echo 'selected'; ?>>
                                        <?php echo htmlspecialchars($cat['nombre']); ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </form>
                    
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover mb-0" id="tabla-inventario">
                                <thead>
                                    <tr>
                                        <th>Codigo</th>
                                        <th>Nombre del producto</th>
                                        <th>Categoría</th>
                                        <th>Cantidad</th>
                                        <th>Precio Unitario</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if ($inventario): ?>
                                        <?php foreach ($inventario as $item): ?>
                                            <tr>
                                                <td><?php echo htmlspecialchars($item['codigo_producto']); ?></td>
                                                <td><?php echo htmlspecialchars($item['nombre']); ?></td>
                                                <td><?php echo htmlspecialchars($item['categoria']); ?></td>
                                                <td><?php echo htmlspecialchars($item['cantidad']); ?></td>
                                                <td>$<?php echo htmlspecialchars(number_format($item['precio_unitario'],2)); ?></td>
                                                <td>
                                                    <button class="btn btn-primary btn-sm me-2" onclick="editarproducto(
                                                        '<?php echo $item['id']; ?>',
                                                        '<?php echo htmlspecialchars(addslashes($item['codigo_producto'])); ?>',
                                                        '<?php echo htmlspecialchars(addslashes($item['nombre'])); ?>',
                                                        '<?php echo $item['categoria_id']; ?>',
                                                        '<?php echo $item['cantidad']; ?>',
                                                        '<?php echo $item['precio_unitario']; ?>'
                                                    )">
                                                        <i class="bi bi-pencil"></i> Editar
                                                    </button>
                                                    <form method="POST" action="api/crud_inventario.php" style="display:inline;" onsubmit="return confirm('¿Seguro que desea eliminar este producto?');">
                                                        <input type="hidden" name="accion" value="eliminar">
                                                        <input type="hidden" name="delete_id" value="<?php echo $item['id']; ?>">
                                                        <button type="submit" class="btn btn-danger btn-sm">
                                                            <i class="bi bi-trash"></i> Eliminar
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    <?php else: ?>
                                        <tr>
                                            <td colspan="6" class="text-center">
                                                <?php echo (isset($_GET['search']) || isset($_GET['idcategoria'])) ? 'No se encontraron productos con esos filtros.' : 'No hay productos en inventario.'; ?>
                                            </td>
                                        </tr>
                                    <?php endif; ?>
                                </tbody>
                            </table>
                        </div>
                        
                        <nav aria-label="paginador" class="paginador">
                            <ul class="pagination justify-content-center mt-3">
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

    <div class="modal fade" id="addItemModal" tabindex="-1" aria-labelledby="addItemModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content bg-dark text-light">
                <form method="POST" action="api/crud_inventario.php" autocomplete="off" id="itemForm">
                    <input type="hidden" name="accion" id="accion" value="agregar">
                    <input type="hidden" name="edit_id" id="edit_id">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addItemModalLabel">Agregar Nuevo Ítem</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="itemCode" class="form-label">Código del producto</label>
                            <input type="text" class="form-control" id="itemCode" name="codigo_producto" required>
                        </div>
                        <div class="mb-3">
                            <label for="itemName" class="form-label">Nombre del Ítem</label>
                            <input type="text" class="form-control" id="itemName" name="nombre" required>
                        </div>
                        <div class="mb-3">
                            <label for="itemCategory" class="form-label">Categoría</label>
                            <select name="categoria_id" class="form-select" id="itemCategory" required>
                                <option value="">Seleccionar...</option>
                                <?php foreach ($categorias as $cat): ?>
                                    <option value="<?php echo $cat['id']; ?>"><?php echo htmlspecialchars($cat['nombre']); ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="itemQuantity" class="form-label">Cantidad</label>
                            <input type="number" class="form-control" id="itemQuantity" name="cantidad" required>
                        </div>
                        <div class="mb-3">
                            <label for="itemPrice" class="form-label">Precio Unitario</label>
                            <input type="number" step="0.01" class="form-control" id="itemPrice" name="precio_unitario" required>
                        </div>
                        <button type="submit" class="btn btn-primary" id="btnGuardar">Guardar Ítem</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // JS del Sidebar (se mantiene)
        document.getElementById('sidebar-toggle').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('sidebar-collapsed');
            document.body.classList.toggle('sidebar-expanded');
        });

        // JS del Modal (se mantiene)
        function limpiarModal() {
            document.getElementById('addItemModalLabel').innerText = "Agregar Nuevo Ítem";
            document.getElementById('accion').value = "agregar";
            document.getElementById('edit_id').value = "";
            document.getElementById('itemCode').value = "";
            document.getElementById('itemName').value = "";
            document.getElementById('itemCategory').value = "";
            document.getElementById('itemQuantity').value = "";
            document.getElementById('itemPrice').value = "";
        }

        function editarproducto(id, codigo, nombre, categoria_id, cantidad, precio) {
            document.getElementById('addItemModalLabel').innerText = "Editar Ítem";
            document.getElementById('accion').value = "editar";
            document.getElementById('edit_id').value = id;
            document.getElementById('itemCode').value = codigo;
            document.getElementById('itemName').value = nombre;
            document.getElementById('itemCategory').value = categoria_id;
            document.getElementById('itemQuantity').value = cantidad;
            document.getElementById('itemPrice').value = precio;
            var modal = new bootstrap.Modal(document.getElementById('addItemModal'));
            modal.show();
        }

        // JS para auto-ocultar alertas (NUEVO)
        setTimeout(function() {
            var alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                if (alert) {
                    new bootstrap.Alert(alert).close();
                }
            });
        }, 5000);
    </script>
</body>
</html>