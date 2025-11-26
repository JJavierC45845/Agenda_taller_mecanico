<?php
// 1. AÑADIDO: Seguridad de sesión
include 'inc/conectar.php';
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// 2. AÑADIDO: Verificación de Admin
if (!isset($_SESSION['user_id']) || $_SESSION['rol'] !== 'Admin') {
    header('Location: login.php');
    exit();
}

// 3. AÑADIDO: Obtener nombre para bienvenida
$admin_nombre = $_SESSION['user_name'] ?? 'Admin';
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
            <h1>Bienvenido, <?php echo htmlspecialchars($admin_nombre); ?></h1>
            <p class="mb-0">Panel de control del sistema</p>
        </div>
    </header>

    <div class="container">
        <div class="menu-container">
            <a class="menu-block" href="gempleados.php">
                <i class="bi bi-people-fill"></i>
                <span class="menu-title">Empleados</span>
                <span class="menu-desc">Gestión de empleados</span>
            </a>

            <a class="menu-block" href="geclientes.php">
                <i class="bi bi-bookmark-check-fill"></i>
                <span class="menu-title">Clientes</span>
                <span class="menu-desc">Gestión de clientes</span>
            </a>

            <a class="menu-block" href="servicios.php">
                <i class="bi bi-wrench-adjustable-circle-fill"></i>
                <span class="menu-title">Servicios</span>
                <span class="menu-desc">Administrar servicios</span>
            </a>

            <a class="menu-block" href="categorias.php">
                <i class="bi bi-tags-fill"></i>
                <span class="menu-title">Categorías</span>
                <span class="menu-desc">Gestionar categorías</span>
            </a>

            <a class="menu-block" href="inventario.php">
                <i class="bi bi-box-seam-fill"></i>
                <span class="menu-title">Inventario</span>
                <span class="menu-desc">Gestionar inventario</span>
            </a>

            <a class="menu-block" href="agendara.php">
                <i class="bi bi-calendar-plus-fill"></i>
                <span class="menu-title">Agendar Cita</span>
                <span class="menu-desc">Programar nuevas citas</span>
            </a>

            <a class="menu-block" href="agendadasa.php">
                <i class="bi bi-calendar-check-fill"></i>
                <span class="menu-title">Ver Citas</span>
                <span class="menu-desc">Consultar citas agendadas</span>
            </a>

            <a class="menu-block" href="eliminara.php">
                <i class="bi bi-calendar-x-fill"></i>
                <span class="menu-title">Eliminar Cita</span>
                <span class="menu-desc">Cancelar citas existentes</span>
            </a>

            <a class="menu-block" href="cobrara.php">
                <i class="bi bi-cash-coin"></i>
                <span class="menu-title">Cobrar</span>
                <span class="menu-desc">Registrar ventas</span>
            </a>
            
            <a class="menu-block" href="vista_detallada.php">
                <i class="bi bi-eye-fill"></i>
                <span class="menu-title">Vista Citas</span>
                <span class="menu-desc">Ver detalles de citas</span>
            </a>

            <a class="menu-block" href="vista_factura.php">
                <i class="bi bi-file-earmark-text-fill"></i>
                <span class="menu-title">Vista Facturas</span>
                <span class="menu-desc">Ver detalles de facturas</span>
            </a>

            <a class="menu-block" href="vista_inventario.php">
                <i class="bi bi-archive-fill"></i>
                <span class="menu-title">Vista Inventario</span>
                <span class="menu-desc">Ver estado del inventario</span>
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