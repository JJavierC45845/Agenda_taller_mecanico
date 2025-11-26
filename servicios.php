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

// --- LÓGICA DE PAGINACIÓN Y FILTRO ---
$filas_por_pagina = 10;
$pagina_actual = isset($_GET['pagina']) ? (int)$_GET['pagina'] : 1;
if ($pagina_actual < 1) $pagina_actual = 1;
$inicio = ($pagina_actual - 1) * $filas_por_pagina;

$campos_busqueda = ['nombre', 'descripcion']; 
$filtro = procesarBusqueda($campos_busqueda);

$where_sql = $filtro['where_sql'];
$params = $filtro['params'];
$parametros_url = $filtro['url_params'];

// --- LÓGICA DE LECTURA (R) ---
try {
    $sql_total = "SELECT COUNT(*) FROM servicios $where_sql";
    $stmt_total = $pdo->prepare($sql_total);
    $stmt_total->execute($params);
    $total_filas = $stmt_total->fetchColumn();
    $total_paginas = ceil($total_filas / $filas_por_pagina);

    $sql_pagina = "SELECT id, nombre, costo_general, descripcion, duracion_estimada 
                   FROM servicios 
                   $where_sql
                   ORDER BY nombre ASC
                   LIMIT ? OFFSET ?";
    
    $stmt = $pdo->prepare($sql_pagina);

    $i = 1;
    foreach ($params as $param) {
        $stmt->bindValue($i, $param);
        $i++;
    }
    $stmt->bindValue($i, $filas_por_pagina, PDO::PARAM_INT);
    $i++;
    $stmt->bindValue($i, $inicio, PDO::PARAM_INT);

    $stmt->execute();
    $servicios = $stmt->fetchAll();

} catch (Exception $e) {
    $mensaje = "Error al cargar servicios: " . $e->getMessage();
    $tipo_mensaje = 'danger';
    $servicios = [];
    $total_paginas = 0;
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Servicios</title>
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
                            <li class="nav-item"><a href="geclientes.php" class="nav-link"><i class="bi bi-bookmark-check-fill me-2"></i><span class="sidebar-text">Gestión de clientes</span></a></li>
                            <li class="nav-item"><a href="servicios.php" class="nav-link active"><i class="bi bi-wrench-adjustable-circle-fill me-2"></i><span class="sidebar-text">Administrar servicios</span></a></li>
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
                <h1>Gestión de Servicios</h1>
                
                <div id="alertPlaceholder">
                    <?php if ($mensaje): ?>
                        <div class="alert alert-<?php echo $tipo_mensaje; ?> alert-dismissible fade show" role="alert">
                            <?php echo $mensaje; ?>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <?php endif; ?>
                </div>
                
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Acciones</h5>
                    </div>
                    <div class="card-body">
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#servicioModal" onclick="prepararModalAgregar()">
                            <i class="bi bi-plus-circle"></i> Agregar Servicio
                        </button>
                    </div>
                </div>
                
                <div class="card">
                    <?php 
                        renderSearchForm('servicios.php', 'Buscar por nombre o descripción...'); 
                    ?>

                    <div class="card-header">
                        <h5 class="mb-0">Lista de Servicios</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover mb-0" id="tabla-servicios">
                                <thead>
                                    <tr>
                                        <th>Servicio</th>
                                        <th>Costo aproximado</th>
                                        <th>Descripción</th>
                                        <th>Duración (min)</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody id="tablaServiciosBody">
                                    <?php if ($servicios): ?>
                                        <?php foreach ($servicios as $servicio): ?>
                                            <tr>
                                                <td><?php echo htmlspecialchars($servicio['nombre']); ?></td>
                                                <td>$<?php echo htmlspecialchars(number_format($servicio['costo_general'], 2)); ?></td>
                                                <td><?php echo htmlspecialchars($servicio['descripcion']); ?></td>
                                                <td><?php echo htmlspecialchars($servicio['duracion_estimada']); ?></td>
                                                <td>
                                                    <button class="btn btn-sm btn-primary" 
                                                        onclick="prepararModalEditar(
                                                            '<?php echo $servicio['id']; ?>',
                                                            '<?php echo htmlspecialchars(addslashes($servicio['nombre'])); ?>',
                                                            '<?php echo $servicio['costo_general']; ?>',
                                                            '<?php echo htmlspecialchars(addslashes($servicio['descripcion'])); ?>',
                                                            '<?php echo $servicio['duracion_estimada']; ?>'
                                                        )">Editar</button>
                                                    
                                                    <form method="POST" action="api/crud_servicios.php" style="display:inline;" onsubmit="return confirm('¿Seguro que desea eliminar este servicio?');">
                                                        <input type="hidden" name="accion" value="eliminar">
                                                        <input type="hidden" name="delete_id" value="<?php echo $servicio['id']; ?>">
                                                        <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
                                                    </form>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    <?php else: ?>
                                        <tr>
                                            <td colspan="5" class="text-center">
                                                <?php echo isset($_GET['search']) ? 'No se encontraron servicios.' : 'No hay servicios disponibles.'; ?>
                                            </td>
                                        </tr>
                                    <?php endif; ?>
                                </tbody>
                            </table>
                        </div>
                        
                        <nav aria-label="paginador" class="paginador">
                            <ul class="pagination justify-content-center mt-3" id="paginador">
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
                
                <div class="modal fade" id="servicioModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content bg-dark text-light">
                      <form method="POST" action="api/crud_servicios.php" id="servicioForm" autocomplete="off">
                        <input type="hidden" name="accion" id="formAction">
                        <input type="hidden" name="edit_id" id="formEditId">
                        
                        <div class="modal-header">
                          <h5 class="modal-title" id="modalLabel">Agregar Servicio</h5>
                          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        
                        <div class="modal-body">
                          <div class="mb-3">
                            <label for="formNombre" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="formNombre" name="nombre" required>
                          </div>
                          <div class="mb-3">
                            <label for="formCosto" class="form-label">Costo general</label>
                            <input type="number" step="0.01" class="form-control" id="formCosto" name="costo_general" required>
                          </div>
                          <div class="mb-3">
                            <label for="formDescripcion" class="form-label">Descripción</label>
                            <input type="text" class="form-control" id="formDescripcion" name="descripcion" required>
                          </div>
                          <div class="mb-3">
                            <label for="formDuracion" class="form-label">Duración estimada (minutos)</label>
                            <input type="number" class="form-control" id="formDuracion" name="duracion_estimada" min="1" required>
                          </div>
                        </div>
                        
                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                          <button type="submit" class="btn btn-primary">Guardar</button>
                        </div>
                      </form>
                    </div>
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
            var alerts = document.querySelectorAll('#alertPlaceholder .alert');
            alerts.forEach(function(alert) {
                if (alert) {
                    new bootstrap.Alert(alert).close();
                }
            });
        }, 5000);
        
        // Instancia del modal
        var servicioModal = new bootstrap.Modal(document.getElementById('servicioModal'));

        /**
         * Prepara el modal para AGREGAR un nuevo servicio.
         */
        function prepararModalAgregar() {
            document.getElementById('servicioForm').reset();
            document.getElementById('modalLabel').innerText = "Agregar Servicio";
            document.getElementById('formAction').value = "agregar";
            document.getElementById('formEditId').value = "";
        }

        /**
         * Prepara el modal para EDITAR un servicio existente.
         * (Esta función reemplaza la antigua 'mostrarEditarModal')
         */
        function prepararModalEditar(id, nombre, costo, descripcion, duracion) {
            document.getElementById('servicioForm').reset();
            document.getElementById('modalLabel').innerText = "Editar Servicio";
            document.getElementById('formAction').value = "editar";
            document.getElementById('formEditId').value = id;
            
            // Llenar los campos
            document.getElementById('formNombre').value = nombre;
            document.getElementById('formCosto').value = costo;
            document.getElementById('formDescripcion').value = descripcion;
            document.getElementById('formDuracion').value = duracion;
            
            // Mostrar el modal
            servicioModal.show();
        }
    </script>
</body>
</html>