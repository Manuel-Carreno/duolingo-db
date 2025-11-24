<?php
require "config.php";

$usuarios = $pdo->query("
    SELECT id_usuario,
           CONCAT('(', id_usuario, ') ', primer_nombre, ' ', primer_apellido) AS nombre
    FROM usuario
")->fetchAll();

$mensaje = "";
$tipoMensaje = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $id = $_POST["id_usuario"];
    $dias = $_POST["dias"];
    $inicio = $_POST["fecha_inicio"];

    // Fecha fin opcional
    $fin = !empty($_POST["fecha_fin"]) ? $_POST["fecha_fin"] : null;

    try {
        $stmt = $pdo->prepare("
            INSERT INTO racha (id_usuario, dias_consecutivos, fecha_inicio, fecha_fin)
            VALUES (?, ?, ?, ?)
        ");
        $stmt->execute([$id, $dias, $inicio, $fin]);

        $mensaje = "Racha creada correctamente.";
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
<title>Crear Racha</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<h1>Crear Racha para Usuario</h1>

<?php if ($mensaje): ?>
    <div class="message <?= $tipoMensaje ?>">
        <b><?= $mensaje ?></b>
    </div>
<?php endif; ?>

<form method="POST">
    <label>Usuario:
        <select name="id_usuario" required>
            <option value="">Selecciona...</option>
            <?php foreach ($usuarios as $u): ?>
                <option value="<?= $u['id_usuario'] ?>"><?= $u['nombre'] ?></option>
            <?php endforeach; ?>
        </select>
    </label>

    <label>Días consecutivos:
        <input type="number" name="dias" min="0" required>
    </label>

    <label>Fecha de inicio:
        <input type="date" name="fecha_inicio" required>
    </label>

    <label>Fecha fin (opcional):
        <input type="date" name="fecha_fin">
    </label>

    <button type="submit">Guardar</button>
</form>

<a href="index.php" class="back-btn">⬅ Volver</a>
</body>
</html>
