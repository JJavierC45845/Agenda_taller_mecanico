<?php
include '../inc/conectar.php'; // Usa ../ para subir un nivel desde /api/
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Verificación de permisos (permite Admin Y Empleado)
// (Esta línea ya es correcta y permite a ambos)
if (!isset($_SESSION['user_id']) || ($_SESSION['rol'] !== 'Admin' && $_SESSION['rol'] !== 'Empleado')) {
    if (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
        header('Content-Type: application/json');
        echo json_encode(['success' => false, 'message' => 'Acceso no autorizado.']);
    } else {
        header('Location: ../login.php');
    }
    exit();
}


// --- MANEJO DE ACCIONES POST ---
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    
    // --- ACCIÓN: CREAR CITA (desde agendara.php o agendar.php) ---
    if ($_POST['action'] === 'create') {
        
        $rol_usuario = strtolower($_SESSION['rol']);
        if ($rol_usuario === 'admin') {
            $redirect_url = '../agendara.php'; // Redirige al admin
        } else {
            $redirect_url = '../agendar.php'; // Redirige al empleado
        }
        
        try {
            // ... (Toda tu lógica de 'create' va aquí, sin cambios) ...
            $cliente_nombre = trim($_POST['clientName']);
            $modelo_moto = trim($_POST['modelomoto']);
            $placa = trim($_POST['placa']);
            $anio = trim($_POST['anio']);
            $telefono = trim($_POST['numerotelefono']);
            $correo = trim($_POST['correo']);
            $servicio_id = $_POST['servicio_id'];
            $kilometros = trim($_POST['kilometros']);
            $fecha = $_POST['fecha'];
            $hora = $_POST['hora'];
            $rol_id_cliente = 3; 

            if (!$cliente_nombre || !$modelo_moto || !$placa || !$anio || !$telefono || !$servicio_id || !$fecha || !$hora) {
                throw new Exception("Por favor, complete todos los campos obligatorios.");
            }

            $pdo->beginTransaction();

            // 1. Buscar o crear cliente
            $stmt = $pdo->prepare("SELECT id FROM clientes WHERE LOWER(nombre) = LOWER(?) AND telefono = ? AND rol_id = ?");
            $stmt->execute([$cliente_nombre, $telefono, $rol_id_cliente]);
            $cliente = $stmt->fetch();
            
            if ($cliente) {
                $cliente_id = $cliente['id'];
            } else {
                $stmt = $pdo->prepare("INSERT INTO clientes (nombre, telefono, rol_id) VALUES (?, ?, ?)");
                $stmt->execute([$cliente_nombre, $telefono, $rol_id_cliente]);
                $cliente_id = $pdo->lastInsertId();
            }

            // 2. Buscar o crear moto
            $stmt = $pdo->prepare("SELECT id, cliente_id FROM motos WHERE placa = ?");
            $stmt->execute([$placa]);
            $moto = $stmt->fetch();
            
            if ($moto) {
                $moto_id = $moto['id'];
                if ($moto['cliente_id'] != $cliente_id) {
                    throw new Exception("La placa '$placa' ya está registrada a otro cliente.");
                }
            } else {
                $stmt = $pdo->prepare("INSERT INTO motos (cliente_id, modelo, placa, ano) VALUES (?, ?, ?, ?)");
                $stmt->execute([$cliente_id, $modelo_moto, $placa, $anio]);
                $moto_id = $pdo->lastInsertId();
            }

            // 3. Insertar la cita
            $stmt = $pdo->prepare("INSERT INTO citas (cliente_id, moto_id, telefono, email, kilometros, fecha_cita, hora_llegada) VALUES (?, ?, ?, ?, ?, ?, ?)");
            $stmt->execute([$cliente_id, $moto_id, $telefono, $correo, $kilometros, $fecha, $hora]);
            $cita_id = $pdo->lastInsertId();

            // 4. Relacionar el servicio
            $stmt = $pdo->prepare("INSERT INTO cita_servicios (cita_id, servicio_id) VALUES (?, ?)");
            $stmt->execute([$cita_id, $servicio_id]);

            $pdo->commit();
            $mensaje = "Cita agendada exitosamente.";
            header("Location: $redirect_url?status=success&msg=" . urlencode($mensaje));
            exit;
        
        } catch (Exception $e) {
            $pdo->rollBack();
            $error_msg = "Error al agendar cita: " . $e->getMessage();
            header("Location: $redirect_url?status=danger&msg=" . urlencode($error_msg));
            exit;
        }
    }
    
    // --- ACCIÓN: ACTUALIZAR ESTADO (desde agendadasa.php) ---
    if ($_POST['action'] === 'update_estado') {
        
        header('Content-Type: application/json');
        
        $cita_id = $_POST['cita_id'] ?? 0;
        $nuevo_estado = $_POST['nuevo_estado'] ?? '';
        
        try {
            if (empty($cita_id) || empty($nuevo_estado)) {
                throw new Exception("Datos incompletos.");
            }
            
            $stmt = $pdo->prepare("UPDATE citas SET estado = ? WHERE id = ?");
            $stmt->execute([$nuevo_estado, $cita_id]);
            
            if ($stmt->rowCount() > 0) {
                echo json_encode(['success' => true, 'message' => 'Estado actualizado.']);
            } else {
                echo json_encode(['success' => true, 'message' => 'Estado sin cambios.']);
            }
            
        } catch (Exception $e) {
            echo json_encode(['success' => false, 'message' => $e->getMessage()]);
        }
        exit; 
    }
}


// --- MANEJO DE ELIMINACIÓN (GET desde eliminara.php o eliminar.php) ---
// --- MODIFICADO ---
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['action']) && $_GET['action'] === 'delete') {
    
    // 1. Definir la URL de redirección (basado en el rol)
    $rol_usuario = strtolower($_SESSION['rol']);
    if ($rol_usuario === 'admin') {
        $redirect_url = '../eliminara.php'; // Redirige al admin
    } else {
        $redirect_url = '../eliminar.php'; // Redirige al empleado
    }

    // 2. Proceder con la lógica de borrado
    // (Ya sabemos que es Admin o Empleado por el check al inicio del script)
    $id = isset($_GET['id']) ? intval($_GET['id']) : 0;
    
    if ($id > 0) {
        try {
            $pdo->beginTransaction();
            $stmt = $pdo->prepare("DELETE FROM cita_servicios WHERE cita_id = ?");
            $stmt->execute([$id]);
            $stmt = $pdo->prepare("DELETE FROM citas WHERE id = ?");
            $stmt->execute([$id]);
            $pdo->commit();
            
            $mensaje = "Cita eliminada correctamente.";
            header("Location: $redirect_url?status=success&msg=" . urlencode($mensaje));
            exit;

        } catch (Exception $e) {
            $pdo->rollBack();
            $error_msg = "Error al eliminar cita: " . $e->getMessage();
            header("Location: $redirect_url?status=danger&msg=" . urlencode($error_msg));
            exit;
        }
    } else {
        // Si no hay ID, redirige con error
        $error_msg = "Error: No se proporcionó un ID de cita válido.";
        header("Location: $redirect_url?status=danger&msg=" . urlencode($error_msg));
        exit;
    }
}
// --- FIN DE LA MODIFICACIÓN ---


// Si no hay acción válida, redirige al menú correspondiente
$redirect_menu = (strtolower($_SESSION['rol']) === 'admin') ? '../menua.php' : '../menu.php';
header("Location: $redirect_menu");
exit;
?>