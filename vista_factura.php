<?php
include 'inc/conectar.php';
include 'inc/funciones_busqueda.php'; // Incluimos buscador universal
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Seguridad
if (!isset($_SESSION['user_id']) || $_SESSION['rol'] !== 'Admin') {
    header('Location: login.php');
    exit();
}

// Inicializar variables de mensajes
$mensaje = '';
$tipo_mensaje = '';

// --- LÓGICA DE PAGINACIÓN Y FILTRO ---
$filas_por_pagina = 15; // Más filas para facturas
$pagina_actual = isset($_GET['pagina']) ? (int)$_GET['pagina'] : 1;
if ($pagina_actual < 1) $pagina_actual = 1;
$inicio = ($pagina_actual - 1) * $filas_por_pagina; // OFFSET

// Campos para buscar (usando los nombres de la VISTA)
$campos_busqueda = ['numero_factura', 'nombre_cliente', 'descripcion_item', 'estado_factura'];
$filtro = procesarBusqueda($campos_busqueda);
$where_sql = $filtro['where_sql'];
$params_filtro = $filtro['params'];
$parametros_url = $filtro['url_params'];


// --- LÓGICA DE LECTURA (R) ---
try {
    // 1. Contar el total de filas (consultando la VISTA)
    // Contamos las filas de detalle, no las facturas únicas
    $sql_total = "SELECT COUNT(*) FROM vista_factura_completa $where_sql";
    $stmt_total = $pdo->prepare($sql_total);
    $stmt_total->execute($params_filtro);
    $total_filas = $stmt_total->fetchColumn();
    $total_paginas = ceil($total_filas / $filas_por_pagina);


    // 2. Obtener los detalles de la página actual (consultando la VISTA)
    $sql_pagina = "SELECT *
                   FROM vista_factura_completa
                   $where_sql
                   ORDER BY fecha_emision DESC, factura_id DESC
                   LIMIT ? OFFSET ?";
    
    $stmt = $pdo->prepare($sql_pagina);
    
    // Bindeo de parámetros (filtro + paginación)
    $i = 1;
    foreach ($params_filtro as $param) {
        $stmt->bindValue($i++, $param);
    }
    $stmt->bindValue($i++, $filas_por_pagina, PDO::PARAM_INT);
    $stmt->bindValue($i++, $inicio, PDO::PARAM_INT);
    
    $stmt->execute();
    $facturas = $stmt->fetchAll();

} catch (Exception $e) {
    $facturas = [];
    $mensaje = "Error al cargar la vista de facturas: " . $e->getMessage();
    $tipo_mensaje = 'danger';
    $total_paginas = 0;
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vista de Facturas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
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
                    <a href="inventario.php" class="nav-link">
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
                    <a href="vista_factura.php" class="nav-link active"> <i class="bi bi-file-earmark-text-fill me-2"></i>
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
</div>>
            
            <div class="main-content col">
                <button class="btn toggle-btn mb-3 d-md-none" id="sidebar-toggle">
                    <i class="bi bi-list"></i>
                </button>
                <h1>Vista Detallada de Facturas</h1>
                
                <?php if ($mensaje): ?>
                    <div class="alert alert-<?php echo $tipo_mensaje; ?> alert-dismissible fade show" role="alert">
                        <?php echo $mensaje; ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <?php endif; ?>
                
                <div class="card">
                    <?php 
                        renderSearchForm('vista_factura.php', 'Buscar por N° Factura, cliente, ítem...'); 
                    ?>

                    <div class="card-header">
                        <h5 class="mb-0">Detalle de Facturas (desde la VISTA)</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>Factura #</th>
                                        <th>Fecha</th>
                                        <th>Cliente</th>
                                        <th>Ítem (Servicio/Producto)</th>
                                        <th>Cant.</th>
                                        <th>P. Unitario</th>
                                        <th>Subtotal</th>
                                        <th>Total Factura</th>
                                        <th>Estado</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if ($facturas): ?>
                                        <?php foreach ($facturas as $factura): ?>
                                            <tr>
                                                <td>
                                                    <a href="factura.php?id=<?php echo $factura['factura_id']; ?>" target="_blank">
                                                        <?php echo htmlspecialchars($factura['numero_factura']); ?>
                                                    </a>
                                                </td>
                                                <td><?php echo htmlspecialchars(date('d/m/Y', strtotime($factura['fecha_emision']))); ?></td>
                                                <td><?php echo htmlspecialchars($factura['nombre_cliente']); ?></td>
                                                <td>
                                                    <span class="badge bg-<?php echo ($factura['tipo'] == 'servicio') ? 'primary' : 'secondary'; ?>">
                                                        <?php echo htmlspecialchars($factura['tipo']); ?>
                                                    </span>
                                                    <?php echo htmlspecialchars($factura['descripcion_item']); ?>
                                                </td>
                                                <td><?php echo htmlspecialchars($factura['cantidad']); ?></td>
                                                <td class="text-end">$<?php echo htmlspecialchars(number_format($factura['precio_unitario'], 2)); ?></td>
                                                <td class="text-end">$<?php echo htmlspecialchars(number_format($factura['subtotal'], 2)); ?></td>
                                                <td class="text-end fw-bold">$<?php echo htmlspecialchars(number_format($factura['total'], 2)); ?></td>
                                                <td>
                                                    <?php
                                                        $estado = $factura['estado_factura'];
                                                        $clase_badge = 'bg-secondary'; // Default
                                                        if ($estado === 'pagada' || $estado === 'completada') {
                                                            $clase_badge = 'bg-success';
                                                        } elseif ($estado === 'pendiente') {
                                                            $clase_badge = 'bg-warning text-dark';
                                                        }
                                                    ?>
                                                    <span class="badge <?php echo $clase_badge; ?>">
                                                        <?php echo htmlspecialchars(ucfirst($estado)); ?>
                                                    </span>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    <?php else: ?>
                                        <tr>
                                            <td colspan="9" class="text-center">
                                                <?php echo isset($_GET['search']) ? 'No se encontraron facturas.' : 'No hay detalles de facturas.'; ?>
                                            </td>
                                        </tr>
                                    <?php endif; ?>
                                </tbody>
                            </table>
                        </div>
                        
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // JS del Sidebar
        document.getElementById('sidebar-toggle').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('sidebar-collapsed');
            document.body.classList.toggle('sidebar-expanded');
        });
        
        // JS para auto-ocultar alertas
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