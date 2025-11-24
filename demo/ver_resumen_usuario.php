<?php
require "config.php";

$usuarios = $pdo->query("SELECT id_usuario, primer_nombre FROM usuario")->fetchAll();

// Variables vacías por defecto
$perfil = [];
$dashboard = null;
$racha = null;
$xp_total = null;
$detalle = [];
$recomp = [];
$liga = null;

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $id = $_POST["id_usuario"];

    /* -----------------------------------------
       PERFIL COMPLETO (varios idiomas)
    ----------------------------------------- */
    $stmt = $pdo->prepare("SELECT * FROM vw_usuario_perfil WHERE id_usuario = ?");
    $stmt->execute([$id]);
    $perfil = $stmt->fetchAll();

    /* -----------------------------------------
       DASHBOARD PRINCIPAL (1 solo registro)
    ----------------------------------------- */
    $stmt = $pdo->prepare("SELECT * FROM vw_usuario_dashboard WHERE id_usuario = ?");
    $stmt->execute([$id]);
    $dashboard = $stmt->fetch();   // 👈 fetch (no fetchAll)

    /* -----------------------------------------
       RACHA
    ----------------------------------------- */
    $stmt = $pdo->prepare("SELECT * FROM vw_racha_actual WHERE id_usuario = ?");
    $stmt->execute([$id]);
    $racha = $stmt->fetch();

    /* -----------------------------------------
       XP TOTAL POR FUNCIÓN
    ----------------------------------------- */
    $stmt = $pdo->prepare("SELECT fn_total_xp_usuario(?) AS total");
    $stmt->execute([$id]);
    $xp_total = $stmt->fetchColumn();

    /* -----------------------------------------
       XP POR IDIOMA
    ----------------------------------------- */
    $detalleStmt = $pdo->prepare("
        SELECT i.nombre, ui.xp_acumulado 
        FROM usuario_idioma ui 
        JOIN idioma i ON ui.id_idioma = i.id_idioma
        WHERE ui.id_usuario = ?
    ");
    $detalleStmt->execute([$id]);
    $detalle = $detalleStmt->fetchAll();

    /* -----------------------------------------
       RECOMPENSAS
    ----------------------------------------- */
    $recompStmt = $pdo->prepare("
        SELECT r.tipo, r.descripcion, ur.cantidad
        FROM usuario_recompensa ur
        JOIN recompensa r ON ur.id_recompensa = r.id_recompensa
        WHERE ur.id_usuario = ?
    ");
    $recompStmt->execute([$id]);
    $recomp = $recompStmt->fetchAll();

    /* -----------------------------------------
       LIGA ACTUAL
    ----------------------------------------- */
    $ligaStmt = $pdo->prepare("
        SELECT * FROM vw_competencia_liga
        WHERE id_usuario = ? AND fecha_fin IS NULL
    ");
    $ligaStmt->execute([$id]);
    $liga = $ligaStmt->fetch();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Dashboard Completo del Usuario</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<h2>Dashboard Completo del Usuario</h2>

<form method="POST" class="form-card">
    <label>Usuario:
        <select name="id_usuario" required>
            <option value="">Seleccione...</option>
            <?php foreach ($usuarios as $u): ?>
                <option value="<?= $u["id_usuario"] ?>"><?= $u["primer_nombre"] ?></option>
            <?php endforeach; ?>
        </select>
    </label>
    <button type="submit"><b>Consultar</b></button>
</form>

<?php if ($dashboard): ?>

<!-- ===============================
     INFORMACIÓN GENERAL
=============================== -->
<div class="card">
    <h3>Información General</h3>
    <p><strong>Nombre:</strong> <?= $dashboard["nombre"] ?></p>
    <p><strong>XP Total:</strong> <?= $xp_total ?></p>
    <p><strong>Idiomas Activos:</strong> <?= $dashboard["idiomas_activos"] ?></p>
</div>

<!-- ===============================
     RACHA
=============================== -->
<div class="card">
    <h3>Racha Actual</h3>
    <?php if ($racha): ?>
        <p><strong>Días consecutivos:</strong> <?= $racha["dias_consecutivos"] ?></p>
        <p><strong>Desde:</strong> <?= $racha["fecha_inicio"] ?></p>
    <?php else: ?>
        <p>No tiene racha activa.</p>
    <?php endif; ?>
</div>

<!-- ===============================
     XP POR IDIOMA
=============================== -->
<div class="card">
    <h3>XP por Idioma</h3>
    <?php if (empty($detalle)): ?>
        <p>No tiene idiomas asignados.</p>
    <?php else: ?>
        <?php foreach ($detalle as $d): ?>
            <p><strong><?= $d["nombre"] ?>:</strong> <?= $d["xp_acumulado"] ?> XP</p>
        <?php endforeach; ?>
    <?php endif; ?>
</div>

<!-- ===============================
     PERFIL COMPLETO (por idioma)
=============================== -->
<div class="card">
    <h3>Perfil por Idioma</h3>
    <?php foreach ($perfil as $p): ?>
        <p>
            <strong><?= $p["idioma"] ?></strong> – 
            <?= $p["xp_acumulado"] ?> XP 
            (<?= $p["estado_aprendizaje"] ?>)
        </p>
    <?php endforeach; ?>
</div>

<!-- ===============================
     RECOMPENSAS
=============================== -->
<div class="card">
    <h3>Recompensas</h3>
    <?php if (empty($recomp)): ?>
        <p>No tiene recompensas aún.</p>
    <?php else: ?>
        <?php foreach ($recomp as $r): ?>
            <p>
                <strong><?= $r["tipo"] ?>:</strong> 
                <?= $r["descripcion"] ?> 
                (x<?= $r["cantidad"] ?>)
            </p>
        <?php endforeach; ?>
    <?php endif; ?>
</div>

<!-- ===============================
     LIGA
=============================== -->
<div class="card">
    <h3>Liga Actual</h3>
    <?php if (!$liga): ?>
        <p>No está participando en una liga actualmente.</p>
    <?php else: ?>
        <p><strong>Liga:</strong> <?= $liga["liga"] ?></p>
        <p><strong>XP Ganado:</strong> <?= $liga["xp_ganado"] ?></p>
        <p><strong>Posición:</strong> <?= $liga["ranking"] ?></p>
        <p><strong>Estado:</strong> <?= $liga["estado"] ?></p>
        <p><strong>Inicio:</strong> <?= $liga["fecha_inicio"] ?></p>
    <?php endif; ?>
</div>

<?php endif; ?>

<a href="index.php" class="back-btn">⬅ Volver</a>

<div style="height: 130px;"></div>

</body>
</html>
