<?php
include '../inc/conectar.php';
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Verificar si el usuario está logueado y es admin
if (!isset($_SESSION['user_id']) || $_SESSION['rol'] !== 'Admin') {
    header('Location: ../login.php'); // Ruta corregida
    exit();
}

$redirect_url = '../servicios.php';

// Todas las acciones de este formulario vienen por POST
$action = $_POST['accion'] ?? null;

try {
    switch ($action) {
        case 'agregar':
            $nombre = trim($_POST['nombre']);
            $costo_general = $_POST['costo_general'];
            $descripcion = $_POST['descripcion'];
            $duracion_estimada = $_POST['duracion_estimada'];

            if (empty($nombre) || empty($costo_general) || !isset($duracion_estimada)) {
                throw new Exception("Nombre, Costo y Duración son obligatorios.");
            }

            // Verificar si existe un servicio con nombre exacto
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM servicios WHERE LOWER(nombre) = LOWER(?)");
            $stmt->execute([$nombre]);
            if ($stmt->fetchColumn() > 0) {
                throw new Exception("Ya existe un servicio con ese nombre exacto.");
            }

            $stmt = $pdo->prepare("INSERT INTO servicios (nombre, costo_general, descripcion, duracion_estimada) VALUES (?, ?, ?, ?)");
            $stmt->execute([$nombre, $costo_general, $descripcion, $duracion_estimada]);
            $mensaje = "Servicio agregado exitosamente.";
            $tipo_mensaje = 'success';
            break;

        case 'editar':
            // --- MODIFICADO ---
            // Leemos los mismos campos que 'agregar'
            $id = $_POST['edit_id'];
            $nombre = trim($_POST['nombre']);
            $costo_general = $_POST['costo_general'];
            $descripcion = $_POST['descripcion'];
            $duracion_estimada = $_POST['duracion_estimada'];

            if (empty($id) || empty($nombre) || empty($costo_general) || !isset($duracion_estimada)) {
                throw new Exception("Todos los campos son obligatorios para editar.");
            }
            // --- FIN MODIFICACIÓN ---

            // Verificar si existe OTRO servicio con el mismo nombre
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM servicios WHERE LOWER(nombre) = LOWER(?) AND id != ?");
            $stmt->execute([$nombre, $id]);
            if ($stmt->fetchColumn() > 0) {
                throw new Exception("Ya existe OTRO servicio con ese nombre.");
            }

            $stmt = $pdo->prepare("UPDATE servicios SET nombre = ?, costo_general = ?, descripcion = ?, duracion_estimada = ? WHERE id = ?");
            $stmt->execute([$nombre, $costo_general, $descripcion, $duracion_estimada, $id]);
            $mensaje = "Servicio actualizado exitosamente.";
            $tipo_mensaje = 'success';
            break;

        case 'eliminar':
            $id = $_POST['delete_id'];
            if (empty($id)) {
                throw new Exception("No se proporcionó ID para eliminar.");
            }

            $stmt_check = $pdo->prepare("SELECT COUNT(*) FROM cita_servicios WHERE servicio_id = ?");
            $stmt_check->execute([$id]);
            if ($stmt_check->fetchColumn() > 0) {
                throw new Exception("No se puede eliminar el servicio, está siendo usado en citas agendadas.");
            }

            $stmt = $pdo->prepare("DELETE FROM servicios WHERE id = ?");
            $stmt->execute([$id]);
            $mensaje = "Servicio eliminado exitosamente.";
            $tipo_mensaje = 'success';
            break;

        default:
            header("Location: $redirect_url");
            exit;
    }

    // Redirección exitosa
    header("Location: $redirect_url?status=$tipo_mensaje&msg=" . urlencode($mensaje));
    exit;

} catch (Exception $e) {
    // Manejo centralizado de errores
    $error_msg = $e->getMessage();
    header("Location: $redirect_url?status=danger&msg=" . urlencode($error_msg));
    exit;
}
?>