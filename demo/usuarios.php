<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
require "config.php";
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Usuarios</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h1>Listado de Usuarios</h1>

<div class="table-wrapper">
<?php
try {
    $stmt = $pdo->query("SELECT * FROM usuario ORDER BY id_usuario ASC");
    $usuarios = $stmt->fetchAll();
    if ($usuarios) {
        echo "<table>";
        echo "<tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Correo</th>
                <th>Avatar</th>
                <th>Nacionalidad</th>
                <th>Fecha registro</th>
              </tr>";
        foreach ($usuarios as $u) {
            echo "<tr>
                    <td>{$u['id_usuario']}</td>
                    <td>{$u['primer_nombre']} {$u['segundo_nombre']}</td>
                    <td>{$u['primer_apellido']} {$u['segundo_apellido']}</td>
                    <td>{$u['correo']}</td>
                    <td>{$u['avatar']}</td>
                    <td>{$u['nacionalidad']}</td>
                    <td>{$u['fecha_registro']}</td>
                  </tr>";
        }
        echo "</table>";
    } else {
        echo "<p>No hay usuarios registrados.</p>";
    }
} catch (PDOException $e) {
    echo "<p style='color:red;'>Error SQL: " . $e->getMessage() . "</p>";
}
?>
</div>

<a href="index.php" class="visual-btn">⬅ Volver</a>
</body>
</html>
