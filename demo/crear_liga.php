<?php
require "config.php";

$mensaje = "";
$tipoMensaje = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nombre = $_POST["nombre"];
    $nivel = $_POST["nivel"];
    $inicio = $_POST["fecha_inicio"];

    try {
        $stmt = $pdo->prepare("INSERT INTO liga (nombre, nivel, fecha_inicio)
                               VALUES (?, ?, ?)");
        $stmt->execute([$nombre, $nivel, $inicio]);

        $mensaje = "Liga creada correctamente.";
        $tipoMensaje = "success";

    } catch (PDOException $e) {
        $mensaje = "Error: " . $e->getMessage();
        $tipoMensaje = "error";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Crear Liga</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<h1>Crear Nueva Liga</h1>

<?php if ($mensaje): ?>
    <div class="message <?= $tipoMensaje ?>"><?= $mensaje ?></div>
<?php endif; ?>

<form method="POST">
    <label>Nombre:
        <input type="text" name="nombre" required>
    </label>

    <label>Nivel:
        <input type="text" name="nivel">
    </label>

    <label>Fecha inicio:
        <input type="date" name="fecha_inicio">
    </label>

    <button type="submit">Crear</button>
</form>

<a href="index.php" class="back-btn">⬅ Volver</a>
</body>
</html>
