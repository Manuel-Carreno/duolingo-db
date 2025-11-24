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
    $stmt = $pdo->query("SELECT * FROM vw_usuario_perfil ORDER BY id_usuario ASC");
    $usuarios = $stmt->fetchAll();
    
    if ($usuarios && count($usuarios) > 0) {

	echo "<table>";
	echo "<tr>
		<th>ID</th>
		<th>Nombre</th>
		<th>Correo</th>
		<th>Nacionalidad</th>
		<th>Avatar</th>
		<th>Idioma</th>
		<th>Estado</th>
		<th>XP</th>
	      </tr>";

	foreach ($usuarios as $u) {
	    echo "<tr>
		    <td>{$u['id_usuario']}</td>
		    <td>{$u['nombre_completo']}</td>
		    <td>{$u['correo']}</td>
		    <td>{$u['nacionalidad']}</td>
		    <td>{$u['avatar']}</td>
		    <td>{$u['idioma']}</td>
		    <td>{$u['estado_aprendizaje']}</td>
		    <td>{$u['xp_acumulado']}</td>
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

<a href="index.php" class="back-btn">⬅ Volver</a>

<div style="height: 120px;"></div>
</body>
</html>
