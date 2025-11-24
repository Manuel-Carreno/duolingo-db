<?php 
require "config.php"; // Asegúrate de que $pdo está definido aquí
$mensaje = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $tipo = $_POST['tipo'];
    $contenido = $_POST['contenido'] ?: null;
    $respuesta = $_POST['respuesta_correcta'] ?: null;

    try {
        $sql = "INSERT INTO ejercicio (tipo, contenido, respuesta_correcta)
                VALUES (:tipo, :contenido, :respuesta)";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            ':tipo' => $tipo,
            ':contenido' => $contenido,
            ':respuesta' => $respuesta
        ]);

        $mensaje = "Ejercicio creado exitosamente. ID: " . $pdo->lastInsertId();

    } catch (PDOException $e) {
        $mensaje = "Error: " . $e->getMessage();
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Crear Ejercicio</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<h1>Crear Nuevo Ejercicio</h1>
<p><?= $mensaje ?></p>

<div class="container">

<form method="POST">
    <label>Tipo de ejercicio</label>
    <select name="tipo" required>
        <option>selección múltiple</option>
        <option>verdadero/falso</option>
        <option>completar</option>
        <option>relacionar</option>
        <option>escribir</option>
        <option>ordenar</option>
    </select>

    <label>Contenido</label>
    <textarea name="contenido" style="width:95%; height:80px; border-radius:14px; margin-top:8px;"></textarea>

    <label>Respuesta correcta</label>
    <textarea name="respuesta_correcta" style="width:95%; height:80px; border-radius:14px; margin-top:8px;"></textarea>

    <button type="submit">Crear Ejercicio</button>
</form>

<a href="index.php" class="back-btn">⬅ Volver</a>

<div style="height: 120px;"></div>

</div>
</body>
</html>
