<?php
include 'inc/conectar.php';
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Verificar si el usuario está logueado
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}


// Manejo de mensajes de redirección
$mensaje = '';
$tipo_mensaje = '';
if (isset($_GET['msg'])) {
    $mensaje = htmlspecialchars($_GET['msg']);
    $tipo_mensaje = htmlspecialchars($_GET['status'] ?? 'info');
}

// Obtener servicios para el select (Lógica de LECTURA se mantiene)
try {
    $stmt = $pdo->query("SELECT id, nombre FROM servicios ORDER BY nombre ASC");
    $servicios = $stmt->fetchAll();
} catch (Exception $e) {
    $servicios = [];
    $mensaje = "Error al cargar servicios: " . $e->getMessage();
    $tipo_mensaje = 'danger';
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agendar Cita</title>
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
                    <a href="menu.php" class="nav-link">
                        <i class="bi bi-house-fill me-2"></i>
                        <span class="sidebar-text">Inicio</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="agendar.php" class="nav-link active">
                        <i class="bi bi-calendar-plus-fill me-2"></i>
                        <span class="sidebar-text">Agendar cita</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="agendadas.php" class="nav-link">
                        <i class="bi bi-calendar-check-fill me-2"></i>
                        <span class="sidebar-text">Ver citas</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="eliminar.php" class="nav-link">
                        <i class="bi bi-calendar-x-fill me-2"></i>
                        <span class="sidebar-text">Eliminar cita</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="cobrar.php" class="nav-link">
                        <i class="bi bi-cash-coin"></i>
                        <span class="sidebar-text">Cobrar</span>
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
                <h1>Agendar Nueva Cita</h1> <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Datos de la Cita</h5>
                    </div>
                    <div class="card-body">
                        <?php if ($mensaje): ?>
                            <div class="alert alert-<?php echo $tipo_mensaje; ?> alert-dismissible fade show" role="alert">
                                <?php echo $mensaje; ?>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <?php endif; ?>
                        
                        <form method="POST" action="api/crud_citas.php" autocomplete="off">
                            <input type="hidden" name="action" value="create">
                            
                            <div class="mb-3">
                                <label for="clientName" class="form-label">Nombre del Cliente</label>
                                <input type="text" class="form-control" id="clientName" name="clientName" placeholder="Ingrese el nombre del cliente" required>
                            </div>
                            <div class="mb-3">
                                <label for="numerotelefono" class="form-label">Número telefónico</label>
                                <input type="text" class="form-control" id="numerotelefono" name="numerotelefono" placeholder="Ingrese el número telefónico" required>
                            </div>
                            <hr>
                            <div class="mb-3">
                                <label for="modelomoto" class="form-label">Modelo de la moto</label>
                                <input type="text" class="form-control" id="modelomoto" name="modelomoto" placeholder="Ingrese el modelo de la moto" required>
                            </div>
                            <div class="mb-3">
                                <label for="placa" class="form-label">Placa</label>
                                <input type="text" class="form-control" id="placa" name="placa" placeholder="Ingrese la placa (única)" required>
                            </div>
                            <div class="mb-3">
                                <label for="anio" class="form-label">Año</label>
                                <input type="number" class="form-control" id="anio" name="anio" placeholder="Ingrese el año" min="1900" max="<?php echo date('Y') + 1; ?>" required>
                            </div>
                            <div class="mb-3">
                                <label for="kilometros" class="form-label">Kilometraje</label>
                                <input type="number" class="form-control" id="kilometros" name="kilometros" placeholder="Kilometraje actual (opcional)">
                            </div>
                            <hr>
                             <div class="mb-3">
                                <label for="servicio_id" class="form-label">Servicio Requerido</label>
                                <select name="servicio_id" id="servicio_id" class="form-select" required>
                                    <option value="">Seleccionar...</option>
                                    <?php foreach ($servicios as $serv): ?>
                                        <option value="<?php echo $serv['id']; ?>"><?php echo htmlspecialchars($serv['nombre']); ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="correo" class="form-label">Correo electrónico (Opcional)</label>
                                <input type="email" class="form-control" id="correo" name="correo" placeholder="Ingrese el correo electrónico">
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="fecha" class="form-label">Fecha de Cita</label>
                                    <input type="date" class="form-control" id="fecha" name="fecha" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="hora" class="form-label">Hora de Cita</label>
                                    <input type="time" class="form-control" id="hora" name="hora" required>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">Agendar Cita</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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