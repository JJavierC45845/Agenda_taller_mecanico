<?php
include 'inc/conectar.php';
include 'inc/funciones_busqueda.php'; // Incluimos buscador universal
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Verificar si el usuario está logueado y es admin
if (!isset($_SESSION['user_id']) || $_SESSION['rol'] !== 'Admin') {
    header('Location: login.php');
    exit();
}

// Manejo de mensajes (leídos desde la URL)
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

$campos_busqueda = ['e.nombre', 'r.nombre']; 
$filtro = procesarBusqueda($campos_busqueda);
$where_sql = $filtro['where_sql'];
$params_filtro = $filtro['params'];
$parametros_url = $filtro['url_params'];

// --- Obtener lista de empleados (para la tabla) ---
try {
    // 1. Contar el total de filas filtradas
    $sql_total = "SELECT COUNT(DISTINCT e.id) 
                  FROM empleados e 
                  INNER JOIN roles r ON e.rol_id = r.id 
                  $where_sql";
    $stmt_total = $pdo->prepare($sql_total);
    $stmt_total->execute($params_filtro);
    $total_filas = $stmt_total->fetchColumn();
    $total_paginas = ceil($total_filas / $filas_por_pagina);

    // 2. Obtener solo la página actual
    $sql_pagina = "
        SELECT e.*, r.nombre as rol_nombre 
        FROM empleados e 
        INNER JOIN roles r ON e.rol_id = r.id 
        $where_sql
        ORDER BY e.nombre
        LIMIT ? OFFSET ?";
    
    $stmt = $pdo->prepare($sql_pagina);

    $i = 1;
    foreach ($params_filtro as $param) {
        $stmt->bindValue($i++, $param);
    }
    $stmt->bindValue($i++, $filas_por_pagina, PDO::PARAM_INT);
    $stmt->bindValue($i++, $inicio, PDO::PARAM_INT);

    $stmt->execute();
    $empleados = $stmt->fetchAll();

} catch (Exception $e) {
    $mensaje = "Error al cargar empleados: " . $e->getMessage();
    $tipo_mensaje = 'danger';
    $empleados = [];
    $total_paginas = 0;
}

// --- Obtener roles disponibles (para el formulario del MODAL) ---
try {
    $stmt = $pdo->query("SELECT * FROM roles WHERE nombre IN ('Admin', 'Empleado')");
    $roles = $stmt->fetchAll();
} catch (Exception $e) {
    $mensaje = "Error al cargar roles: " . $e->getMessage();
    $tipo_mensaje = 'danger';
    $roles = [];
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Empleados</title>
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
                    <div class="px-3"> 
                        <ul class="nav flex-column mt-3">
                            <li class="nav-item"><a href="menua.php" class="nav-link"><i class="bi bi-house-fill me-2"></i><span class="sidebar-text">Inicio</span></a></li>
                            <li class="nav-item"><a href="gempleados.php" class="nav-link active"><i class="bi bi-people-fill me-2"></i><span class="sidebar-text">Gestión de empleados</span></a></li>
                            <li class="nav-item"><a href="geclientes.php" class="nav-link"><i class="bi bi-bookmark-check-fill me-2"></i><span class="sidebar-text">Gestión de clientes</span></a></li>
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
                
                <h1>Gestión de Empleados</h1>
                
                <div id="alertPlaceholder">
                    <?php if ($mensaje): ?>
                        <div class="alert alert-<?php echo $tipo_mensaje; ?> alert-dismissible fade show" role="alert">
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
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#empleadoModal" onclick="prepararModalAgregar()">
                            <i class="bi bi-plus-circle"></i> Agregar Empleado
                        </button>
                    </div>
                </div>

                <div class="card">
                    <?php 
                        renderSearchForm('gempleados.php', 'Buscar empleado por nombre o rol...'); 
                    ?>

                    <div class="card-header">
                        <h5 class="mb-0">Lista de Empleados</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th style="display: none;">ID</th>
                                        <th>Nombre</th>
                                        <th>Rol</th>
                                        <th>Fecha de Creación</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody id="tablaEmpleadosBody"> 
                                    <?php if (empty($empleados)): ?>
                                        <tr>
                                            <td colspan="5" class="text-center">
                                                <?php echo isset($_GET['search']) ? 'No se encontraron empleados.' : 'No hay empleados registrados'; ?>
                                            </td>
                                        </tr>
                                    <?php else: ?>
                                        <?php foreach ($empleados as $empleado): ?>
                                            <tr>
                                                <td style="display: none;"><?php echo $empleado['id']; ?></td>
                                                <td><?php echo htmlspecialchars($empleado['nombre']); ?></td>
                                                <td><?php echo htmlspecialchars($empleado['rol_nombre']); ?></td>
                                                <td><?php echo date('d/m/Y', strtotime($empleado['fecha_creacion'])); ?></td>
                                                <td>
                                                    <button class="btn btn-primary btn-sm me-2" 
                                                            onclick="prepararModalEditar(
                                                                '<?php echo $empleado['id']; ?>',
                                                                '<?php echo htmlspecialchars(addslashes($empleado['nombre'])); ?>',
                                                                '<?php echo $empleado['rol_id']; ?>'
                                                            )">
                                                        <i class="bi bi-pencil"></i> Editar
                                                    </button>
                                                    
                                                    <?php if (isset($_SESSION['user_id']) && $empleado['id'] != $_SESSION['user_id']): ?>
                                                        <a href="api/crud_empleados.php?action=delete&id=<?php echo $empleado['id']; ?>" class="btn btn-danger btn-sm" 
                                                           onclick="return confirm('¿Estás seguro de eliminar a <?php echo htmlspecialchars(addslashes($empleado['nombre'])); ?>?')">
                                                            <i class="bi bi-trash"></i> Eliminar
                                                        </a>
                                                    <?php else: ?>
                                                        <button class="btn btn-danger btn-sm" disabled title="No puedes eliminarte a ti mismo">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    <?php endif; ?>
                                                </td>
                                            </tr>
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

    <div class="modal fade" id="empleadoModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content bg-dark text-light">
          
          <form method="POST" action="api/crud_empleados.php" id="empleadoForm" autocomplete="off">
            <input type="hidden" name="action" id="formAction" value="create">
            <input type="hidden" name="empleado_id" id="formEmpleadoId" value="">
            
            <div class="modal-header">
              <h5 class="modal-title" id="modalLabel">Agregar Empleado</h5>
              <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
                <div class="mb-3">
                    <label for="formNombre" class="form-label">Nombre del Empleado</label>
                    <input type="text" class="form-control" id="formNombre" name="nombre" 
                           placeholder="Ingrese el nombre del empleado" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Rol</label>
                    <div>
                        <?php foreach ($roles as $rol): ?>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="rol_id" 
                                       id="formRol_<?php echo $rol['id']; ?>" 
                                       value="<?php echo $rol['id']; ?>"
                                       required>
                                <label class="form-check-label" for="formRol_<?php echo $rol['id']; ?>">
                                    <?php echo htmlspecialchars($rol['nombre']); ?>
                                </label>
                            </div>
                        <?php endforeach; ?>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="formPassword" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="formPassword" name="password" 
                           placeholder="Ingrese la contraseña">
                    <small class="text-warning" id="passwordHelp">Dejar vacío para no cambiar la contraseña (al editar).</small>
                </div>
            </div>
            
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
              <button type="submit" class="btn btn-primary" id="btnGuardar">Guardar Empleado</button>
            </div>
          </form>
          
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
            // Busca alertas en el contenedor principal y no solo en el placeholder
            var alerts = document.querySelectorAll('.main-content .alert');
            alerts.forEach(function(alert) {
                if (alert) {
                    new bootstrap.Alert(alert).close();
                }
            });
        }, 5000);
        
        // Instancia del modal (para controlarlo con JS)
        var empleadoModal = new bootstrap.Modal(document.getElementById('empleadoModal'));

        /**
         * Prepara el modal para AGREGAR un nuevo empleado.
         * Limpia todos los campos del formulario.
         */
        function prepararModalAgregar() {
            document.getElementById('empleadoForm').reset(); // Resetea el formulario
            document.getElementById('modalLabel').innerText = "Agregar Empleado";
            document.getElementById('formAction').value = "create";
            document.getElementById('formEmpleadoId').value = "";
            document.getElementById('formPassword').required = true; // Contraseña es obligatoria al crear
            document.getElementById('passwordHelp').style.display = "none";
        }

        /**
         * Prepara el modal para EDITAR un empleado existente.
         * Rellena el formulario con los datos del empleado.
         */
        function prepararModalEditar(id, nombre, rol_id) {
            document.getElementById('empleadoForm').reset(); // Limpia validaciones previas
            document.getElementById('modalLabel').innerText = "Editar Empleado";
            document.getElementById('formAction').value = "update";
            document.getElementById('formEmpleadoId').value = id;
            document.getElementById('formNombre').value = nombre;
            
            // Marcar el radio button correcto
            document.getElementById('formRol_' + rol_id).checked = true;
            
            // Contraseña no es obligatoria al editar
            document.getElementById('formPassword').required = false; 
            document.getElementById('passwordHelp').style.display = "block";
            
            // Mostrar el modal
            empleadoModal.show();
        }
    </script>
</body>
</html>