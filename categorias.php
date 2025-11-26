<?php
include 'inc/conectar.php';
// MODIFICADO: Incluimos las funciones universales
include 'inc/funciones_busqueda.php'; 
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

if (!isset($_SESSION['user_id']) || $_SESSION['rol'] !== 'Admin') {
    header('Location: login.php');
    exit();
}

// Variables para mensajes (Leen desde la URL)
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
$inicio = ($pagina_actual - 1) * $filas_por_pagina; // OFFSET

// --- MODIFICADO: Lógica de Filtro Universal ---
$campos_busqueda = ['nombre', 'descripcion']; // Campos en esta tabla
$filtro = procesarBusqueda($campos_busqueda);

$where_sql = $filtro['where_sql'];
$params = $filtro['params']; // $params_filtro ahora es $params
$parametros_url = $filtro['url_params'];
// --- Fin Modificación ---


// --- LÓGICA DE LECTURA (R) ---
try {
    // 1. Contar el total de filas filtradas
    $sql_total = "SELECT COUNT(*) FROM categorias $where_sql";
    $stmt_total = $pdo->prepare($sql_total);
    $stmt_total->execute($params);
    $total_filas = $stmt_total->fetchColumn();
    $total_paginas = ceil($total_filas / $filas_por_pagina);

    // 2. Obtener solo la página actual
    $sql_pagina = "SELECT id, nombre, descripcion 
                   FROM categorias 
                   $where_sql
                   ORDER BY nombre ASC
                   LIMIT ? OFFSET ?"; // Sintaxis PostgreSQL
    
    $stmt = $pdo->prepare($sql_pagina);

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
    $categorias = $stmt->fetchAll();

} catch (Exception $e) {
    $mensaje = "Error al cargar categorías: " . $e->getMessage();
    $tipo_mensaje = 'danger';
    $categorias = [];
    $total_paginas = 0;
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Categorias</title>
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
                    <a href="categorias.php" class="nav-link active">
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
                <h1>Gestión de Categorias</h1>
                
                <?php if ($mensaje): ?>
                    <div class="alert alert-<?php echo $tipo_mensaje; ?> alert-dismissible fade show" role="alert">
                        <?php echo $mensaje; ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <?php endif; ?>
                
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Agregar Categoria</h5>
                    </div>
                    <div class="card-body">
                        <form method="POST" action="api/crud_categorias.php" autocomplete="off">
                            <input type="hidden" name="action" value="create">
                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombre de la categoría</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ingrese el nombre de la categoría" required>
                            </div>
                            <div class="mb-3">
                                <label for="descripcion" class="form-label">Descripción</label>
                                <input type="text" class="form-control" id="descripcion" name="descripcion" placeholder="Descripción de la categoría">
                            </div>
                            <button type="submit" class="btn btn-primary">Guardar categoría</button>
                        </form>
                    </div>
                </div>
                
                <div class="card">
                    <?php 
                        renderSearchForm('categorias.php', 'Buscar por categoría o descripción...'); 
                    ?>

                    <div class="card-header">
                        <h5 class="mb-0">Lista de Categorias</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover mb-0" id="tabla-categorias">
                                <thead>
                                    <tr>
                                        <th>Categoría</th>
                                        <th>Descripción</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody id="tablaCategoriasBody">
                                    <?php if ($categorias): ?>
                                        <?php foreach ($categorias as $cat): ?>
                                            <tr>
                                                <td><?php echo htmlspecialchars($cat['nombre']); ?></td>
                                                <td><?php echo htmlspecialchars($cat['descripcion']); ?></td>
                                                <td>
                                                    <button class="btn btn-primary btn-sm me-2" onclick="mostrarEditarModal('<?php echo $cat['id']; ?>','<?php echo htmlspecialchars(addslashes($cat['nombre'])); ?>','<?php echo htmlspecialchars(addslashes($cat['descripcion'])); ?>')">
                                                        <i class="bi bi-pencil"></i> Editar
                                                    </button>
                                                    
                                                    <a href="api/crud_categorias.php?action=delete&id=<?php echo $cat['id']; ?>" class="btn btn-danger btn-sm" 
                                                       onclick="return confirm('¿Seguro que desea eliminar esta categoría? (No se podrá eliminar si está en uso por algún producto)');">
                                                        <i class="bi bi-trash"></i> Eliminar
                                                    </a>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    <?php else: ?>
                                        <tr>
                                            <td colspan="3" class="text-center">
                                                <?php echo isset($_GET['search']) ? 'No se encontraron categorías.' : 'No hay categorías registradas.'; ?>
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
                
                <div class="modal fade" id="editarModal" tabindex="-1" aria-labelledby="editarModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content bg-dark text-light">
                      <form method="POST" action="api/crud_categorias.php" autocomplete="off">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="edit_id" id="edit_id">
                        <div class="modal-header">
                          <h5 class="modal-title" id="editarModalLabel">Editar Categoría</h5>
                          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                          <div class="mb-3">
                            <label for="edit_nombre" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="edit_nombre" name="edit_nombre" required>
                          </div>
                          <div class="mb-3">
                            <label for="edit_descripcion" class="form-label">Descripción</label>
                            <input type="text" class="form-control" id="edit_descripcion" name="edit_descripcion">
                          </div>
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                          <button type="submit" class="btn btn-primary">Guardar Cambios</button>
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
        // JS del Sidebar (se mantiene)
        document.getElementById('sidebar-toggle').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('sidebar-collapsed');
            document.body.classList.toggle('sidebar-expanded');
        });

        // JS del Modal (se mantiene)
        function mostrarEditarModal(id, nombre, descripcion) {
            document.getElementById('edit_id').value = id;
            document.getElementById('edit_nombre').value = nombre;
            document.getElementById('edit_descripcion').value = descripcion;
            var modal = new bootstrap.Modal(document.getElementById('editarModal'));
            modal.show();
        }

        // JS de Alertas (se mantiene)
        setTimeout(function() {
            var alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                if (alert) {
                    var bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }
            });
        }, 5000);
    </script>
</body>
</html>