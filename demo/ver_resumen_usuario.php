<?php
require "config.php";

$usuarios = $pdo->query("SELECT id_usuario, primer_nombre FROM usuario")->fetchAll();
$xp_total = null;
$detalle = [];
$recomp = [];

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $id = $_POST["id_usuario"];

    // Total XP
    $stmt = $pdo->prepare("SELECT fn_total_xp_usuario(?) AS total");
    $stmt->execute([$id]);
    $xp_total = $stmt->fetchColumn();

    // XP por idioma
    $detalle = $pdo->prepare("
        SELECT i.nombre, ui.xp_acumulado 
        FROM usuario_idioma ui 
        JOIN idioma i ON ui.id_idioma = i.id_idioma
        WHERE ui.id_usuario = ?
    ");
    $detalle->execute([$id]);
    $detalle = $detalle->fetchAll();

    // Recompensas
    $recomp = $pdo->prepare("
        SELECT r.tipo, r.descripcion, ur.cantidad
        FROM usuario_recompensa ur
        JOIN recompensa r ON ur.id_recompensa = r.id_recompensa
        WHERE ur.id_usuario = ?
    ");
    $recomp->execute([$id]);
    $recomp = $recomp->fetchAll();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Resumen XP</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<h2>Resumen de XP y Recompensas</h2>

<form method="POST">
    <label>Usuario:
        <select name="id_usuario" required>
            <option value="">Selecciona...</option>
            <?php foreach ($usuarios as $u): ?>
                <option value="<?= $u["id_usuario"] ?>"><?= $u["primer_nombre"] ?></option>
            <?php endforeach; ?>
        </select>
    </label>
    <button type="submit"><b>Consultar</b></button>
</form>

<?php if ($xp_total !== null): ?>

<div class="card">
    <h3>Total XP acumulado:</h3>
    <p><strong><?= $xp_total ?></strong></p>
    <?php if ($xp_total == 0): ?>
        <p>No tiene XP registrado aún.</p>
    <?php endif; ?>
</div>

<div class="card">
    <h3>XP por idioma:</h3>
    <?php if (empty($detalle)): ?>
        <p>Este usuario no tiene idiomas asignados.</p>
    <?php else: ?>
        <?php foreach ($detalle as $d): ?>
            <p><strong><?= $d["nombre"] ?>:</strong> <?= $d["xp_acumulado"] ?> XP</p>
        <?php endforeach; ?>
    <?php endif; ?>
</div>

<div class="card">
    <h3>Recompensas obtenidas:</h3>
    <?php if (empty($recomp)): ?>
        <p>No tiene recompensas todavía.</p>
    <?php else: ?>
        <?php foreach ($recomp as $r): ?>
            <p><strong><?= $r["tipo"] ?></strong> – <?= $r["descripcion"] ?> (x<?= $r["cantidad"] ?>)</p>
        <?php endforeach; ?>
    <?php endif; ?>
</div>


<?php endif; ?>

<a href="index.php" class="btn-volver"><b>⬅ Volver</b></a>

</body>
</html>
