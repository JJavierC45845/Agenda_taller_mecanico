<?php
include '../inc/conectar.php'; // Usa ../ para subir desde /api/
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Verificar que solo administradores logueados accedan
if (!isset($_SESSION['user_id']) || $_SESSION['rol'] !== 'Admin') {
    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'message' => 'Acceso no autorizado.']);
    exit();
}

// Función auxiliar para enviar respuestas JSON
function response($success, $message, $data = []) {
    header('Content-Type: application/json');
    echo json_encode(['success' => $success, 'message' => $message, 'data' => $data]);
    exit;
}

// Manejar peticiones AJAX
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    
    if (!$pdo) {
        response(false, 'No se pudo conectar a la base de datos.');
    }

    try {
        $pdo->beginTransaction(); // Iniciar transacción

        switch ($_POST['action']) {
            // --- CREAR CLIENTE ---
            case 'create':
                $nombre = filter_input(INPUT_POST, 'nombre', FILTER_SANITIZE_STRING);
                $telefono = filter_input(INPUT_POST, 'telefono', FILTER_SANITIZE_STRING);
                $motos_json = $_POST['motos'] ?? '[]';
                $motos = json_decode($motos_json, true);
                
                if (json_last_error() !== JSON_ERROR_NONE) {
                     throw new Exception('Formato de motos inválido.');
                }
                
                $rol_id = 3; // ID para clientes

                if (empty($nombre) || empty($telefono)) {
                    throw new Exception('Nombre y teléfono del cliente son obligatorios.');
                }
                if (empty($motos)) {
                    throw new Exception('Debe agregar al menos una moto.');
                }

                // Insertar cliente
                $stmt = $pdo->prepare("INSERT INTO clientes (nombre, telefono, rol_id) VALUES (:nombre, :telefono, :rol_id) RETURNING id");
                $stmt->execute(['nombre' => $nombre, 'telefono' => $telefono, 'rol_id' => $rol_id]);
                $cliente_id = $stmt->fetchColumn();

                // Insertar motos
                $stmt_moto = $pdo->prepare("INSERT INTO motos (cliente_id, modelo, placa, ano) VALUES (:cliente_id, :modelo, :placa, :ano)");
                foreach ($motos as $moto) {
                     if (empty($moto['modelo'])) {
                         throw new Exception('El modelo de la moto es obligatorio.');
                     }
                    $stmt_moto->execute([
                        'cliente_id' => $cliente_id,
                        'modelo' => $moto['modelo'],
                        'placa' => !empty($moto['placa']) ? $moto['placa'] : null,
                        'ano' => !empty($moto['ano']) ? (int)$moto['ano'] : null
                    ]);
                }

                $pdo->commit();
                response(true, 'Cliente y motos registrados correctamente.');
                break;

            // --- ACTUALIZAR CLIENTE ---
            case 'update':
                $cliente_id = filter_input(INPUT_POST, 'cliente_id', FILTER_VALIDATE_INT);
                $nombre = filter_input(INPUT_POST, 'nombre', FILTER_SANITIZE_STRING);
                $telefono = filter_input(INPUT_POST, 'telefono', FILTER_SANITIZE_STRING);
                $motos_json = $_POST['motos'] ?? '[]';
                $motos = json_decode($motos_json, true);
                
                 if (json_last_error() !== JSON_ERROR_NONE) {
                     throw new Exception('Formato de motos inválido.');
                 }

                if (!$cliente_id || empty($nombre) || empty($telefono)) {
                     throw new Exception('ID, Nombre y teléfono del cliente son obligatorios.');
                }
                 if (empty($motos)) {
                     throw new Exception('El cliente debe tener al menos una moto.');
                 }

                // Actualizar cliente
                $stmt = $pdo->prepare("UPDATE clientes SET nombre = :nombre, telefono = :telefono WHERE id = :id AND rol_id = 3");
                $stmt->execute(['nombre' => $nombre, 'telefono' => $telefono, 'id' => $cliente_id]);

                // Borrar motos existentes (para reemplazarlas)
                $stmt = $pdo->prepare("DELETE FROM motos WHERE cliente_id = :cliente_id");
                $stmt->execute(['cliente_id' => $cliente_id]);

                // Insertar las motos nuevas/actualizadas
                $stmt_moto = $pdo->prepare("INSERT INTO motos (cliente_id, modelo, placa, ano) VALUES (:cliente_id, :modelo, :placa, :ano)");
                foreach ($motos as $moto) {
                     if (empty($moto['modelo'])) {
                         throw new Exception('El modelo de la moto es obligatorio.');
                     }
                    $stmt_moto->execute([
                        'cliente_id' => $cliente_id,
                        'modelo' => $moto['modelo'],
                        'placa' => !empty($moto['placa']) ? $moto['placa'] : null,
                        'ano' => !empty($moto['ano']) ? (int)$moto['ano'] : null
                    ]);
                }

                $pdo->commit();
                response(true, 'Cliente y motos actualizados correctamente.');
                break;

            // --- ELIMINAR CLIENTE (MODIFICADO: BORRADO EN CASCADA) ---
            case 'delete':
                $cliente_id = filter_input(INPUT_POST, 'cliente_id', FILTER_VALIDATE_INT);
                if (!$cliente_id) {
                    throw new Exception('ID de cliente no válido.');
                }

                // 1. Eliminar DETALLES de FACTURAS del cliente
                // (Borramos los detalles de las facturas que pertenecen a este cliente)
                $stmt = $pdo->prepare("DELETE FROM factura_detalles WHERE factura_id IN (SELECT id FROM facturas WHERE cliente_id = :id)");
                $stmt->execute(['id' => $cliente_id]);

                // 2. Eliminar FACTURAS del cliente
                $stmt = $pdo->prepare("DELETE FROM facturas WHERE cliente_id = :id");
                $stmt->execute(['id' => $cliente_id]);

                // 3. Eliminar SERVICIOS de CITAS del cliente
                $stmt = $pdo->prepare("DELETE FROM cita_servicios WHERE cita_id IN (SELECT id FROM citas WHERE cliente_id = :id)");
                $stmt->execute(['id' => $cliente_id]);

                // 4. Eliminar CITAS del cliente
                $stmt = $pdo->prepare("DELETE FROM citas WHERE cliente_id = :id");
                $stmt->execute(['id' => $cliente_id]);
                
                // 5. Eliminar MOTOS asociadas
                $stmt = $pdo->prepare("DELETE FROM motos WHERE cliente_id = :id");
                $stmt->execute(['id' => $cliente_id]);

                // 6. Finalmente, eliminar al CLIENTE
                $stmt = $pdo->prepare("DELETE FROM clientes WHERE id = :id AND rol_id = 3");
                $stmt->execute(['id' => $cliente_id]);

                if ($stmt->rowCount() == 0) {
                     throw new Exception('No se encontró el cliente o no es válido.');
                }

                $pdo->commit();
                response(true, 'Cliente y TODO su historial (facturas, citas, motos) eliminados correctamente.');
                break;

            // --- ELIMINAR SOLO UNA MOTO ---
            case 'delete_moto':
                $moto_id = filter_input(INPUT_POST, 'moto_id', FILTER_VALIDATE_INT);
                if (!$moto_id) {
                    throw new Exception('ID de moto no válido.');
                }

                 // Verificar que no sea la única moto
                 $stmt = $pdo->prepare("SELECT cliente_id, (SELECT COUNT(*) FROM motos WHERE cliente_id = m.cliente_id) as total_motos FROM motos m WHERE id = :moto_id");
                 $stmt->execute(['moto_id' => $moto_id]);
                 $moto_info = $stmt->fetch();

                 if ($moto_info && $moto_info['total_motos'] <= 1) {
                     throw new Exception('No se puede eliminar la última moto del cliente.');
                 }

                $stmt = $pdo->prepare("DELETE FROM motos WHERE id = :id");
                $stmt->execute(['id' => $moto_id]);

                if ($stmt->rowCount() == 0) {
                    throw new Exception('No se encontró la moto.');
                }

                $pdo->commit();
                response(true, 'Moto eliminada correctamente.');
                break;
            
             // --- OBTENER DATOS (Para el Modal de Editar) ---
             case 'get_cliente':
                 $cliente_id = filter_input(INPUT_POST, 'cliente_id', FILTER_VALIDATE_INT);
                 if (!$cliente_id) {
                     response(false, 'ID de cliente no válido.');
                 }
                 $stmt = $pdo->prepare("
                     SELECT c.id, c.nombre, c.telefono, m.id as moto_id, m.modelo, m.placa, m.ano
                     FROM clientes c
                     LEFT JOIN motos m ON c.id = m.cliente_id
                     WHERE c.id = :cliente_id AND c.rol_id = 3
                     ORDER BY m.id
                 ");
                 $stmt->execute(['cliente_id' => $cliente_id]);
                 $cliente_data = $stmt->fetchAll(PDO::FETCH_ASSOC);
                 
                 if (!$cliente_data) {
                    response(false, 'Cliente no encontrado.');
                 }

                 $cliente_info = [
                     'id' => $cliente_data[0]['id'],
                     'nombre' => $cliente_data[0]['nombre'],
                     'telefono' => $cliente_data[0]['telefono'],
                     'motos' => []
                 ];
                 foreach ($cliente_data as $row) {
                     if ($row['moto_id']) { 
                         $cliente_info['motos'][] = [
                             'moto_id' => $row['moto_id'],
                             'modelo' => $row['modelo'],
                             'placa' => $row['placa'],
                             'ano' => $row['ano']
                         ];
                     }
                 }
                 
                 response(true, 'Datos del cliente obtenidos.', $cliente_info);
                 break;

            default:
                response(false, 'Acción no válida.');
        }
    } catch (Exception $e) {
        $pdo->rollBack(); // Revertir cambios si hay error
        response(false, 'Error: ' . $e->getMessage());
    }
} else {
    response(false, 'Método no permitido.');
}
?>