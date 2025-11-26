<?php
include '../inc/conectar.php';
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Verificar si el usuario está logueado y es admin
if (!isset($_SESSION['user_id']) || $_SESSION['rol'] !== 'Admin') {
    // Si no es admin, no debería estar aquí
    header('Location: ../login.php');
    exit();
}

// URL base para redireccionar
$redirect_url = '../gempleados.php';

// Detectar la acción (POST para C/U, GET para D)
$action = $_POST['action'] ?? $_GET['action'] ?? null;

try {
    switch ($action) {
        case 'create':
            // Lógica para Crear (viene de POST)
            $nombre = trim($_POST['nombre']);
            $rol_id = $_POST['rol_id'];
            $password = $_POST['password'];

            if (empty($nombre) || empty($rol_id) || empty($password)) {
                throw new Exception("Todos los campos son obligatorios para crear un empleado");
            }

            $password_hash = password_hash($password, PASSWORD_DEFAULT);
            $stmt = $pdo->prepare("INSERT INTO empleados (nombre, rol_id, contraseña) VALUES (:nombre, :rol_id, :password)");
            $stmt->execute(['nombre' => $nombre, 'rol_id' => $rol_id, 'password' => $password_hash]);
            
            $mensaje = "Empleado agregado correctamente";
            header("Location: $redirect_url?status=success&msg=" . urlencode($mensaje));
            exit;

        case 'update':
            // Lógica para Actualizar (viene de POST)
            $nombre = trim($_POST['nombre']);
            $rol_id = $_POST['rol_id'];
            $password = $_POST['password'];
            $empleado_id = $_POST['empleado_id'] ?? null;

            if (empty($nombre) || empty($rol_id) || !$empleado_id) {
                throw new Exception("Faltan datos para actualizar (ID, Nombre o Rol)");
            }

            if (!empty($password)) {
                // Actualizar con contraseña
                $password_hash = password_hash($password, PASSWORD_DEFAULT);
                $stmt = $pdo->prepare("UPDATE empleados SET nombre = :nombre, rol_id = :rol_id, contraseña = :password WHERE id = :id");
                $stmt->execute(['nombre' => $nombre, 'rol_id' => $rol_id, 'password' => $password_hash, 'id' => $empleado_id]);
            } else {
                // Actualizar sin contraseña
                $stmt = $pdo->prepare("UPDATE empleados SET nombre = :nombre, rol_id = :rol_id WHERE id = :id");
                $stmt->execute(['nombre' => $nombre, 'rol_id' => $rol_id, 'id' => $empleado_id]);
            }
            
            $mensaje = "Empleado actualizado correctamente";
            header("Location: $redirect_url?status=success&msg=" . urlencode($mensaje));
            exit;

        case 'delete':
            // Lógica para Eliminar (viene de GET)
            $id_eliminar = $_GET['id'] ?? null;
            
            if (!$id_eliminar) {
                throw new Exception("No se especificó ID para eliminar");
            }
            
            if (isset($_SESSION['user_id']) && $id_eliminar == $_SESSION['user_id']) {
                throw new Exception("No puedes eliminarte a ti mismo");
            }

            $stmt = $pdo->prepare("DELETE FROM empleados WHERE id = :id");
            $stmt->execute(['id' => $id_eliminar]);
            
            $mensaje = "Empleado eliminado correctamente";
            header("Location: $redirect_url?status=success&msg=" . urlencode($mensaje));
            exit;

        default:
            // Si no hay acción, simplemente redirige
            header("Location: $redirect_url");
            exit;
    }
} catch (Exception $e) {
    // Manejo centralizado de errores
    $error_msg = $e->getMessage();
    header("Location: $redirect_url?status=danger&msg=" . urlencode($error_msg));
    exit;
}
?>