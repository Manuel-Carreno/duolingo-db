<?php
require "config.php";

$usuarios = $pdo->query("SELECT id_usuario, primer_nombre FROM usuario")->fetchAll();
$idiomas  = $pdo->query("SELECT id_idioma, nombre FROM idioma")->fetchAll();
$mensaje = null;

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $id_usuario = $_POST["id_usuario"];
    $id_idioma = $_POST["id_idioma"];

    try {
        $stmt = $pdo->prepare("
            INSERT INTO usuario_idioma (id_usuario, id_idioma, estado, xp_acumulado, fecha_inicio)
            VALUES (?, ?, 'aprendiendo', 0, CURRENT_DATE)
        ");
        $stmt->execute([$id_usuario, $id_idioma]);

        $mensaje = "✅ Idioma asignado correctamente.";

    } catch (PDOException $e) {
        $mensaje = "❌ Error: " . $e->getMessage();
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Asignar Idioma</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<h2>Asignar Idioma a Usuario</h2>

<form method="POST">
    <label>Usuario:
        <select name="id_usuario" required>
            <option value="">Selecciona...</option>
            <?php foreach ($usuarios as $u): ?>
                <option value="<?= $u['id_usuario'] ?>"><?= $u['primer_nombre'] ?></option>
            <?php endforeach; ?>
        </select>
    </label>

    <label>Idioma:
        <select name="id_idioma" required>
            <option value="">Selecciona...</option>
            <?php foreach ($idiomas as $i): ?>
                <option value="<?= $i['id_idioma'] ?>"><?= $i['nombre'] ?></option>
            <?php endforeach; ?>
        </select>
    </label>

    <button type="submit"><b>Asignar</b></button>
</form>

<?php if ($mensaje): ?>
    <div class="card">
        <p><strong><?= $mensaje ?></strong></p>
    </div>
<?php endif; ?>

<a href="index.php" class="back-btn">⬅ Volver</a>

<div style="height: 120px;"></div>

</body>
</html>
