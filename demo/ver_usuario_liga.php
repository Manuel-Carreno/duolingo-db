<?php require "config.php"; ?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Usuarios en Ligas</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<h1>Usuarios Compitiendo en Ligas</h1>

<div class="table-wrapper">
<?php
try {
    $stmt = $pdo->query("SELECT * FROM vw_competencia_liga ORDER BY id_liga, ranking ASC");
    $rows = $stmt->fetchAll();

    if ($rows) {
        echo "<table>
                <tr>
                    <th>Usuario</th>
                    <th>Liga</th>
                    <th>XP Ganado</th>
                    <th>Ranking</th>
                    <th>Estado</th>
                    <th>Inicio</th>
                    <th>Fin</th>
                </tr>";

        foreach ($rows as $r) {
            echo "<tr>
                    <td>{$r['usuario']}</td>
                    <td>{$r['liga']}</td>
                    <td>{$r['xp_ganado']}</td>
                    <td>{$r['ranking']}</td>
                    <td>{$r['estado']}</td>
                    <td>{$r['fecha_inicio']}</td>
                    <td>{$r['fecha_fin']}</td>
                  </tr>";
        }

        echo "</table>";
    } else {
        echo "<p>No hay usuarios en ligas.</p>";
    }

} catch (PDOException $e) {
    echo "<p>Error: {$e->getMessage()}</p>";
}
?>
</div>

<a href="index.php" class="back-btn">⬅ Volver</a>

<div style="height: 120px;"></div>
</body>
</html>
