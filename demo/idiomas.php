<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
require "config.php";
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Idiomas</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h1>Listado de Idiomas</h1>

<div class="table-wrapper">
<?php
try {
    $stmt = $pdo->query("SELECT * FROM idioma ORDER BY id_idioma ASC");
    $idiomas = $stmt->fetchAll();
    if ($idiomas) {
        echo "<table>";
        echo "<tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Nivel máximo</th>
                <th>Código ISO</th>
                <th>Fecha de adición</th>
              </tr>";
        foreach ($idiomas as $i) {
            echo "<tr>
                    <td>{$i['id_idioma']}</td>
                    <td>{$i['nombre']}</td>
                    <td>{$i['nivel_maximo']}</td>
                    <td>{$i['codigo_iso']}</td>
                    <td>{$i['fecha_adicion']}</td>
                  </tr>";
        }
        echo "</table>";
    } else {
        echo "<p>No hay idiomas registrados.</p>";
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
