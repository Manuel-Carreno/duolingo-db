<?php
require "config.php";

$mensaje = "";
$tipoMensaje = "";

// Traer lista de usuarios con ID + nombre + apellido
$usuarios = $pdo->query("
    SELECT id_usuario, primer_nombre, primer_apellido 
    FROM usuario
    ORDER BY id_usuario ASC
")->fetchAll();

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $id = $_POST["id_usuario"];

    try {
        $stmt = $pdo->prepare("CALL sp_eliminar_usuario(?)");
        $stmt->execute([$id]);

        $mensaje = "✔ Usuario eliminado correctamente.";
        $tipoMensaje = "success";

    } catch (PDOException $e) {
        $mensaje = "❌ Error: " . $e->getMessage();
        $tipoMensaje = "error";
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

<?php if ($mensaje): ?>
    <div class="message <?= $tipoMensaje ?>"><?= $mensaje ?></div>
<?php endif; ?>

<div class="container">

<form method="POST">

    <label>Usuario:</label>
    <select name="id_usuario" required>
        <option value="">-- Selecciona un usuario --</option>

        <?php foreach ($usuarios as $u): ?>
            <option value="<?= $u['id_usuario'] ?>">
                <?= $u['id_usuario'] ?> — <?= $u['primer_nombre'] . " " . $u['primer_apellido'] ?>
            </option>
        <?php endforeach; ?>

    </select>

    <button type="submit" class="delete-btn"><b>Eliminar</b></button>

</form>

<a href="index.php" class="back-btn">⬅ Volver</a>
</div>

<div style="height: 120px;"></div>
</body>
</html>
