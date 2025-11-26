<?php
include '../inc/conectar.php';
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Verificar si el usuario está logueado y es admin
if (!isset($_SESSION['user_id']) || $_SESSION['rol'] !== 'Admin') {
    header('Location: ../login.php');
    exit();
}

$redirect_url = '..//categorias.php';
$action = $_POST['action'] ?? $_GET['action'] ?? null;

try {
    switch ($action) {
        case 'create': // Acción para 'agregar'
            $nombre = trim($_POST['nombre']);
            $descripcion = trim($_POST['descripcion']);

            if (empty($nombre)) {
                throw new Exception("El nombre de la categoría es obligatorio");
            }

            // Verificar si existe una categoría similar
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM categorias WHERE LOWER(nombre) = LOWER(?)");
            $stmt->execute([$nombre]);
            if ($stmt->fetchColumn() > 0) {
                throw new Exception("Ya existe una categoría con ese nombre exacto.");
            }

            $stmt = $pdo->prepare("INSERT INTO categorias (nombre, descripcion) VALUES (?, ?)");
            $stmt->execute([$nombre, $descripcion]);
            $mensaje = "Categoría agregada exitosamente.";
            break;

        case 'update': // Acción para 'editar'
            $id = $_POST['edit_id'];
            $nombre = trim($_POST['edit_nombre']);
            $descripcion = trim($_POST['edit_descripcion']);

            if (empty($nombre) || empty($id)) {
                throw new Exception("Faltan datos para actualizar (ID o Nombre)");
            }

            // Verificar si existe una categoría similar (excluyendo la actual)
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM categorias WHERE LOWER(nombre) = LOWER(?) AND id != ?");
            $stmt->execute([$nombre, $id]);
            if ($stmt->fetchColumn() > 0) {
                throw new Exception("Ya existe otra categoría con ese nombre.");
            }

            $stmt = $pdo->prepare("UPDATE categorias SET nombre = ?, descripcion = ? WHERE id = ?");
            $stmt->execute([$nombre, $descripcion, $id]);
            $mensaje = "Categoría actualizada exitosamente.";
            break;

        case 'delete': // Acción para 'eliminar'
            $id = $_GET['id'];
            if (empty($id)) {
                throw new Exception("No se proporcionó ID para eliminar");
            }

            // Importante: Verificar si la categoría está en uso antes de eliminar
            $stmt_check = $pdo->prepare("SELECT COUNT(*) FROM inventario WHERE categoria_id = ?");
            $stmt_check->execute([$id]);
            if ($stmt_check->fetchColumn() > 0) {
                throw new Exception("No se puede eliminar la categoría porque está siendo usada por productos en el inventario.");
            }

            $stmt = $pdo->prepare("DELETE FROM categorias WHERE id = ?");
            $stmt->execute([$id]);
            $mensaje = "Categoría eliminada exitosamente.";
            break;

        default:
            // Si no hay acción, simplemente redirige
            header("Location: $redirect_url");
            exit;
    }
    
    // Redirección exitosa
    header("Location: $redirect_url?status=success&msg=" . urlencode($mensaje));
    exit;

} catch (Exception $e) {
    // Manejo centralizado de errores
    $error_msg = $e->getMessage();
    header("Location: $redirect_url?status=danger&msg=" . urlencode($error_msg));
    exit;
}
?>