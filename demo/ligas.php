<?php
require "config.php";
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Ligas</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<h1>Listado de Ligas</h1>

<div class="table-wrapper">
<?php
try {
    $stmt = $pdo->query("SELECT * FROM liga ORDER BY id_liga ASC");
    $ligas = $stmt->fetchAll();

    if ($ligas) {
        echo "<table>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Nivel</th>
                    <th>Fecha Inicio</th>
                </tr>";
        foreach ($ligas as $l) {
            echo "<tr>
                    <td>{$l['id_liga']}</td>
                    <td>{$l['nombre']}</td>
                    <td>{$l['nivel']}</td>
                    <td>{$l['fecha_inicio']}</td>
                  </tr>";
        }
        echo "</table>";
    } else {
        echo "<p>No hay ligas creadas.</p>";
    }
} catch (PDOException $e) {
    echo "<p>Error: {$e->getMessage()}</p>";
}
?>
</div>

<a href="index.php" class="back-btn">⬅ Volver</a>
</body>
</html>
