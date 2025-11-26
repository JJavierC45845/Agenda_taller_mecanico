<?php
include 'inc/conectar.php';
include 'inc/funciones_busqueda.php'; // Incluimos buscador universal
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

if (!isset($_SESSION['user_id']) || $_SESSION['rol'] !== 'Admin') {
    header('Location: login.php');
    exit();
}

// Manejo de mensajes de redirección (desde crud_citas.php)
$mensaje = '';
$tipo_mensaje = '';
if (isset($_GET['msg'])) {
    $mensaje = htmlspecialchars($_GET['msg']);
    $tipo_mensaje = htmlspecialchars($_GET['status'] ?? 'info');
}

// --- Lógica de Paginación y Filtro ---
$filas_por_pagina = 10;
$pagina_actual = isset($_GET['pagina']) ? (int)$_GET['pagina'] : 1;
if ($pagina_actual < 1) $pagina_actual = 1;
$inicio = ($pagina_actual - 1) * $filas_por_pagina; // OFFSET

// Campos para buscar (cliente, moto, placa, servicio, teléfono)
$campos_busqueda = ['cl.nombre', 'm.modelo', 'm.placa', 's.nombre', 'c.telefono'];
$filtro = procesarBusqueda($campos_busqueda);
$where_sql = $filtro['where_sql'];
$params_filtro = $filtro['params'];
$parametros_url = $filtro['url_params'];


// Obtener citas agendadas
try {
    // Base de la consulta
    $sql_from_join = "FROM citas c
                      JOIN clientes cl ON c.cliente_id = cl.id
                      JOIN motos m ON c.moto_id = m.id
                      LEFT JOIN cita_servicios cs ON cs.cita_id = c.id
                      LEFT JOIN servicios s ON cs.servicio_id = s.id
                      $where_sql";

    // 1. Contar total de citas (DISTINCT para evitar duplicados si hay muchos servicios)
    $sql_total = "SELECT COUNT(DISTINCT c.id) $sql_from_join";
    $stmt_total = $pdo->prepare($sql_total);
    $stmt_total->execute($params_filtro);
    $total_filas = $stmt_total->fetchColumn();
    $total_paginas = ceil($total_filas / $filas_por_pagina);


    // 2. Obtener las citas de la página actual
    // Usamos STRING_AGG para agrupar servicios si hay más de uno por cita
    $sql_pagina = "SELECT 
                        c.id AS cita_id,
                        cl.nombre AS cliente,
                        m.modelo AS modelo_moto,
                        c.telefono,
                        c.email,
                        c.fecha_cita,
                        c.hora_llegada,
                        STRING_AGG(s.nombre, ', ') AS servicio
                   FROM citas c
                   JOIN clientes cl ON c.cliente_id = cl.id
                   JOIN motos m ON c.moto_id = m.id
                   LEFT JOIN cita_servicios cs ON cs.cita_id = c.id
                   LEFT JOIN servicios s ON cs.servicio_id = s.id
                   " . (empty($where_sql) ? '' : $where_sql) . "
                   GROUP BY c.id, cl.nombre, m.modelo, c.telefono, c.email, c.fecha_cita, c.hora_llegada
                   ORDER BY c.fecha_cita DESC, c.hora_llegada DESC
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
    $citas = $stmt->fetchAll();

} catch (Exception $e) {
    $citas = [];
    if (empty($mensaje)) { // No sobrescribir mensajes de éxito/error de redirección
        $mensaje = "Error al cargar citas: " . $e->getMessage();
        $tipo_mensaje = 'danger';
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar cita</title>
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
                    <a href="eliminara.php" class="nav-link active">
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
                <h1>Eliminar citas agendadas</h1>
                
                <?php if ($mensaje): ?>
                    <div class="alert alert-<?php echo $tipo_mensaje; ?> alert-dismissible fade show" role="alert">
                        <?php echo $mensaje; ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <?php endif; ?>
                
                <div class="card">
                    <?php 
                        renderSearchForm('eliminara.php', 'Buscar por cliente, moto, placa, servicio...'); 
                    ?>

                    <div class="card-header">
                        <h5 class="mb-0">Lista de Citas</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>Cliente</th>
                                        <th>Moto</th>
                                        <th>Teléfono</th>
                                        <th>Email</th>
                                        <th>Servicio(s)</th>
                                        <th>Fecha</th>
                                        <th>Hora</th>
                                        <th>Acción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if ($citas): ?>
                                        <?php foreach ($citas as $cita): ?>
                                            <tr>
                                                <td><?php echo htmlspecialchars($cita['cliente']); ?></td>
                                                <td><?php echo htmlspecialchars($cita['modelo_moto']); ?></td>
                                                <td><?php echo htmlspecialchars($cita['telefono']); ?></td>
                                                <td><?php echo htmlspecialchars($cita['email']); ?></td>
                                                <td><?php echo htmlspecialchars($cita['servicio']); ?></td>
                                                <td><?php echo htmlspecialchars(date('d/m/Y', strtotime($cita['fecha_cita']))); ?></td>
                                                <td><?php echo htmlspecialchars(date('g:i A', strtotime($cita['hora_llegada']))); ?></td>
                                                <td>
                                                    <a href="api/crud_citas.php?action=delete&id=<?php echo $cita['cita_id']; ?>" 
                                                       class="btn btn-danger btn-sm" 
                                                       onclick="return confirm('¿Seguro que desea eliminar esta cita?');">
                                                        <i class="bi bi-trash"></i> Eliminar
                                                    </a>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    <?php else: ?>
                                        <tr>
                                            <td colspan="8" class="text-center">
                                                <?php echo isset($_GET['search']) ? 'No se encontraron citas.' : 'No hay citas agendadas.'; ?>
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