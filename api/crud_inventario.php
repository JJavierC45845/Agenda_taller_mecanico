<?php
include '../inc/conectar.php'; // Usa ../ para subir un nivel desde /api/
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Autenticación
if (!isset($_SESSION['user_id']) || $_SESSION['rol'] !== 'Admin') {
    header('Location: ..//login.php');
    exit();
}

$redirect_url = '..//inventario.php';
$mensaje = '';
$tipo_mensaje = 'danger'; // Default a error

// Todas las acciones (Agregar, Editar, Eliminar) vienen por POST
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['accion'])) {
    
    try {
        $accion = $_POST['accion'];

        if ($accion === 'agregar') {
            $codigo = trim($_POST['codigo_producto']);
            $nombre = trim($_POST['nombre']);
            $categoria_id = $_POST['categoria_id'];
            $cantidad = $_POST['cantidad'];
            $precio_unitario = $_POST['precio_unitario'];

            if (empty($codigo) || empty($nombre) || empty($categoria_id) || !isset($cantidad) || !isset($precio_unitario)) {
                 throw new Exception("Todos los campos son obligatorios.");
            }

            // Verificar si existe un producto con nombre o código exacto (case-insensitive)
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM inventario WHERE LOWER(nombre) = LOWER(?) OR codigo_producto = ?");
            $stmt->execute([$nombre, $codigo]);
            
            if ($stmt->fetchColumn() > 0) {
                throw new Exception("Ya existe un producto con ese nombre o código exacto.");
            }

            $stmt = $pdo->prepare("INSERT INTO inventario (codigo_producto, nombre, categoria_id, cantidad, precio_unitario) VALUES (?, ?, ?, ?, ?)");
            $stmt->execute([$codigo, $nombre, $categoria_id, $cantidad, $precio_unitario]);
            $mensaje = "Producto agregado exitosamente.";
            $tipo_mensaje = 'success';

        } elseif ($accion === 'editar') {
            $id = $_POST['edit_id'];
            $codigo = trim($_POST['codigo_producto']);
            $nombre = trim($_POST['nombre']);
            $categoria_id = $_POST['categoria_id'];
            $cantidad = $_POST['cantidad'];
            $precio_unitario = $_POST['precio_unitario'];

             if (empty($id) || empty($codigo) || empty($nombre) || empty($categoria_id) || !isset($cantidad) || !isset($precio_unitario)) {
                 throw new Exception("Todos los campos son obligatorios.");
            }

            // Verificar si existe OTRO producto con ese nombre o código
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM inventario WHERE (LOWER(nombre) = LOWER(?) OR codigo_producto = ?) AND id != ?");
            $stmt->execute([$nombre, $codigo, $id]);
            
            if ($stmt->fetchColumn() > 0) {
                throw new Exception("Ya existe OTRO producto con ese nombre o código.");
            }

            $stmt = $pdo->prepare("UPDATE inventario SET codigo_producto=?, nombre=?, categoria_id=?, cantidad=?, precio_unitario=?, fecha_actualizacion=NOW() WHERE id=?");
            $stmt->execute([$codigo, $nombre, $categoria_id, $cantidad, $precio_unitario, $id]);
            $mensaje = "Producto actualizado exitosamente.";
            $tipo_mensaje = 'success';
        
        } elseif ($accion === 'eliminar') {
            $id = $_POST['delete_id'];
            if (empty($id)) {
                throw new Exception("No se proporcionó ID para eliminar.");
            }

            // (Recomendado) Verificar si el producto está en uso en facturas
            $stmt_check = $pdo->prepare("SELECT COUNT(*) FROM factura_detalles WHERE producto_id = ?");
            $stmt_check->execute([$id]);
            if ($stmt_check->fetchColumn() > 0) {
                throw new Exception("No se puede eliminar el producto, está siendo usado en facturas.");
            }
            
            $stmt = $pdo->prepare("DELETE FROM inventario WHERE id = ?");
            $stmt->execute([$id]);
            $mensaje = "Producto eliminado exitosamente.";
            $tipo_mensaje = 'success';
        }
        
    } catch (Exception $e) {
        $mensaje = $e->getMessage(); // Obtener el mensaje de error real
        $tipo_mensaje = 'danger';
    }

    // Redirigir de vuelta con el mensaje
    header("Location: $redirect_url?status=$tipo_mensaje&msg=" . urlencode($mensaje));
    exit;
}

// Si no es POST, o no hay acción, solo redirige
header("Location: $redirect_url");
exit;
?>