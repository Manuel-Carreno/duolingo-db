<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
require "config.php";
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lecciones</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h1>Listado de Lecciones</h1>

<div class="table-wrapper">
<?php
try {
    $stmt = $pdo->query("SELECT * FROM leccion ORDER BY id_leccion ASC");
    $lecciones = $stmt->fetchAll();
    if ($lecciones) {
        echo "<table>";
        echo "<tr>
                <th>ID</th>
                <th>Nivel</th>
                <th>Dificultad</th>
                <th>Tiempo estimado</th>
                <th>Habilidad enfocada</th>
              </tr>";
        foreach ($lecciones as $l) {
            echo "<tr>
                    <td>{$l['id_leccion']}</td>
                    <td>{$l['nivel']}</td>
                    <td>{$l['dificultad']}</td>
                    <td>{$l['tiempo_estimado']}</td>
                    <td>{$l['habilidad_enfocada']}</td>
                  </tr>";
        }
        echo "</table>";
    } else {
        echo "<p>No hay lecciones registradas.</p>";
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
