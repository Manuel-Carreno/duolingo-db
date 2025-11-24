<?php
require "config.php";

// Traer usuarios y ligas
$usuarios = $pdo->query("
    SELECT id_usuario,
           CONCAT('(', id_usuario, ') ', primer_nombre, ' ', primer_apellido) AS nombre
    FROM usuario
")->fetchAll();

$ligas = $pdo->query("SELECT id_liga, nombre FROM liga")->fetchAll();

$mensaje = "";
$tipoMensaje = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $ranking = !empty($_POST["ranking"]) ? $_POST["ranking"] : null;

    // fecha_inicio por defecto es hoy
    $fecha_inicio = date('Y-m-d');

    // fecha_fin opcional, por defecto NULL
    $fecha_fin = null;

    try {
        $stmt = $pdo->prepare("
            INSERT INTO usuario_liga
            (id_usuario, id_liga, xp_ganado, ranking, fecha_inicio, fecha_fin, estado)
            VALUES (?, ?, 0, ?, ?, ?, 'compitiendo')
        ");

        $stmt->execute([
            $_POST['id_usuario'],
            $_POST['id_liga'],
            $ranking,
            $fecha_inicio,
            $fecha_fin
        ]);

        $mensaje = "Usuario asignado a la liga correctamente.";
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
<title>Asignar Usuario a Liga</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<h1>Asignar Usuario a Liga</h1>

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

    <label>Liga:
        <select name="id_liga" required>
            <option value="">Selecciona...</option>
            <?php foreach ($ligas as $l): ?>
                <option value="<?= $l['id_liga'] ?>"><?= $l['nombre'] ?></option>
            <?php endforeach; ?>
        </select>
    </label>

    <label>Ranking (opcional):
        <input type="number" name="ranking" min="1">
    </label>

    <button type="submit">Asignar</button>
</form>

<a href="index.php" class="back-btn">⬅ Volver</a>
</body>
</html>
