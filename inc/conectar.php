<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
date_default_timezone_set('America/Mexico_City');

// Configuración de conexión PDO para PostgreSQL
$host = "localhost";
$port = "5432";
$dbname = "taller";
$username = "postgres";
$password = "2004";
$charset = "utf8";

$dsn = "pgsql:host=$host;port=$port;dbname=$dbname;options='--client_encoding=$charset'";

try {
    $pdo = new PDO($dsn, $username, $password, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
} catch (PDOException $e) {
    error_log("Error de conexión: " . $e->getMessage());
    $pdo = null;
}

// Función para hashear contraseñas
function hashPassword($password) {
    return password_hash($password, PASSWORD_BCRYPT);
}
?>