<?php
require "config.php";
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Rachas</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<h1>Rachas de Usuarios</h1>

<div class="table-wrapper">
<?php
try {
    $stmt = $pdo->query("SELECT * FROM vw_racha_actual");
    $datos = $stmt->fetchAll();

    if ($datos) {
        echo "<table>
                <tr>
                    <th>ID Usuario</th>
                    <th>Días</th>
                    <th>Inicio</th>
                    <th>Fin</th>
                </tr>";
        foreach ($datos as $r) {
            echo "<tr>
                    <td>{$r['id_usuario']}</td>
                    <td>{$r['dias_consecutivos']}</td>
                    <td>{$r['fecha_inicio']}</td>
                    <td>{$r['fecha_fin']}</td>
                  </tr>";
        }
        echo "</table>";
    } else {
        echo "<p>No hay rachas registradas.</p>";
    }
} catch (PDOException $e) {
    echo "<p>Error: {$e->getMessage()}</p>";
}
?>
</div>

<a href="index.php" class="back-btn">⬅ Volver</a>
</body>
</html>
