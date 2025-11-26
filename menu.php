<?php
// 1. AÑADIDO: Seguridad de sesión
include 'inc/conectar.php';
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

if (!isset($_SESSION['user_id']) || $_SESSION['rol'] !== 'Empleado') {
    header('Location: login.php');
    exit();
}

// 3. AÑADIDO: Obtener nombre para bienvenida
$empleado_nombre = $_SESSION['user_name'] ?? 'Empleado';
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú Principal</title>
    <meta name="description" content="Panel de control del sistema de gestión de taller mecanico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="style/estandar.css">
</head>
<body>
    <header class="welcome-header text-center">
        <div class="container">
            <h1>Bienvenido, <?php echo htmlspecialchars($empleado_nombre); ?></h1>
            <p class="mb-0">Panel de control del sistema</p>
        </div>
    </header>

    <div class="container">
        <div class="menu-container">
            <a class="menu-block" href="agendar.php">
                <i class="bi bi-calendar-plus-fill"></i>
                <span class="menu-title">Agendar Cita</span>
                <span class="menu-desc">Programar nuevas citas</span>
            </a>

            <a class="menu-block" href="agendadas.php">
                <i class="bi bi-calendar-check-fill"></i>
                <span class="menu-title">Ver Citas</span>
                <span class="menu-desc">Consultar citas agendadas</span>
            </a>

            <a class="menu-block" href="eliminar.php">
                <i class="bi bi-calendar-x-fill"></i>
                <span class="menu-title">Eliminar Cita</span>
                <span class="menu-desc">Cancelar citas existentes</span>
            </a>

            <a class="menu-block" href="cobrar.php">
                <i class="bi bi-cash-coin"></i>
                <span class="menu-title">Cobrar</span>
                <span class="menu-desc">Registrar ventas</span>
            </a>

            <a class="menu-block" href="cerrar_sesion.php">
                <i class="bi bi-box-arrow-left"></i>
                <span class="menu-title">Cerrar Sesión</span>
                <span class="menu-desc">Salir del sistema</span>
            </a>
            
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>