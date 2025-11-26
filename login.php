<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

session_set_cookie_params([
    'lifetime' => 86400,
    'path' => '/',
    'secure' => false, 
    'httponly' => true,
    'samesite' => 'Lax'
]);
session_start();

require_once "inc/conectar.php";

$error = '';

// Si el usuario ya está logueado, redirige al menú correspondiente
if (isset($_SESSION['user_id'])) {
    if (strtolower($_SESSION['rol']) === 'admin') {
        header('Location: menua.php');
    } else {
        header('Location: menu.php'); // Asumiendo que tienes un menu.php para empleados
    }
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['nombre'], $_POST['contraseña'])) {
    $nombre = trim($_POST['nombre']);
    $contrasena = trim($_POST['contraseña']);

    // Verifica la conexión PDO
    if (!$pdo) {
        $error = 'Error de conexión a la base de datos';
    } else {
        try {
            // Consulta empleados
            $stmt = $pdo->prepare("SELECT e.id, e.nombre, e.contraseña, r.nombre as rol 
                                   FROM empleados e 
                                   JOIN roles r ON e.rol_id = r.id 
                                   WHERE e.nombre = :nombre");
            $stmt->execute(['nombre' => $nombre]);
            $user = $stmt->fetch();

            if ($user) {
                if (password_verify($contrasena, $user['contraseña'])) {
                    $_SESSION['user_id'] = $user['id'];
                    $_SESSION['user_type'] = 'empleado';
                    $_SESSION['user_name'] = $user['nombre'];
                    $_SESSION['rol'] = $user['rol'];
                    
                    // Redirige según el rol
                    if (strtolower($user['rol']) === 'admin') {
                        header('Location: menua.php');
                    } else {
                        header('Location: menu.php'); // Redirige a empleados
                    }
                    exit;
                } else {
                    $error = 'Contraseña incorrecta';
                }
            } else {
                $error = 'Usuario o contraseña incorrectos';
            }
        } catch (Exception $e) {
            $error = 'Error en el sistema: ' . $e->getMessage();
        }
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" 
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
          crossorigin="anonymous">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="style/estandar.css"> 
</head>
<body class="body-login">
    <div class="login-container">
        <i class="bi bi-person-circle"></i>
        <h2>Iniciar Sesión</h2>
        
        <?php if ($error): ?>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <?php echo htmlspecialchars($error); ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php endif; ?>
        
        <form method="POST" action="login.php"> <div class="mb-3" style="margin-bottom: 5px;">
                <input type="text" class="form-control" name="nombre" placeholder="Usuario" required>
            </div>
            <div class="mb-3" style="margin-bottom: 5px;">
                <input type="password" class="form-control" name="contraseña" placeholder="Contraseña" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Entrar</button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
            crossorigin="anonymous"></script>
</body>
</html>