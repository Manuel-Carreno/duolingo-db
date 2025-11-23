<?php
require "config.php";

$usuarios = $pdo->query("SELECT id_usuario, primer_nombre FROM usuario")->fetchAll();
$mensaje = null;

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $id = $_POST["id_usuario"];

    try {
        $stmt = $pdo->prepare("CALL sp_eliminar_usuario(?)");
        $stmt->execute([$id]);
        $mensaje = "✅ Usuario eliminado correctamente.";

    } catch (PDOException $e) {
        $mensaje = "❌ Error: " . $e->getMessage();
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Eliminar Usuario</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<h2>Eliminar Usuario</h2>

<form method="POST">
    <label>Usuario:
        <select name="id_usuario" required>
            <option value="">Selecciona...</option>
            <?php foreach ($usuarios as $u): ?>
                <option value="<?= $u['id_usuario'] ?>"><?= $u['primer_nombre'] ?></option>
            <?php endforeach; ?>
        </select>
    </label>
    <button type="submit" style="background-color:#e63946"><b>Eliminar</b></button>
</form>

<?php if ($mensaje): ?>
    <div class="card">
        <p><strong><?= $mensaje ?></strong></p>
    </div>
<?php endif; ?>

<a href="index.php" class="btn-volver"><b>⬅ Volver</b></a>

</body>
</html>
