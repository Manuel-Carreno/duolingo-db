<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
require "config.php";
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ejercicios</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h1>Listado de Ejercicios</h1>

<div class="table-wrapper">
<?php
try {
    $stmt = $pdo->query("SELECT * FROM ejercicio ORDER BY id_ejercicio ASC");
    $ejercicios = $stmt->fetchAll();
    if ($ejercicios) {
        echo "<table>";
        echo "<tr>
                <th>ID</th>
                <th>Tipo</th>
                <th>Contenido</th>
                <th>Respuesta correcta</th>
              </tr>";
        foreach ($ejercicios as $e) {
            echo "<tr>
                    <td>{$e['id_ejercicio']}</td>
                    <td>{$e['tipo']}</td>
                    <td>{$e['contenido']}</td>
                    <td>{$e['respuesta_correcta']}</td>
                  </tr>";
        }
        echo "</table>";
    } else {
        echo "<p>No hay ejercicios registrados.</p>";
    }
} catch (PDOException $e) {
    echo "<p style='color:red;'>Error SQL: " . $e->getMessage() . "</p>";
}
?>
</div>

<a href="index.php" class="visual-btn">⬅ Volver</a>
</body>
</html>
