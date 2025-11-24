<?php
require "config.php";

$stmt = $pdo->query("SELECT * FROM vw_ranking_xp_por_idioma ORDER BY idioma, posicion");
$ranking = $stmt->fetchAll();
?>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ranking Global</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<h1>Ranking Global por Idioma</h1>

<div class="table-wrapper">
<table>
<tr>
    <th>Idioma</th>
    <th>Usuario</th>
    <th>XP</th>
    <th>Posición</th>
</tr>
<?php foreach ($ranking as $r): ?>
<tr>
    <td><?= $r["idioma"] ?></td>
    <td><?= $r["usuario"] ?></td>
    <td><?= $r["xp_acumulado"] ?></td>
    <td><?= $r["posicion"] ?></td>
</tr>
<?php endforeach; ?>
</table>
</div>

<a href="index.php" class="back-btn">⬅ Volver</a>

<div style="height: 120px;"></div>

</body>
</html>
