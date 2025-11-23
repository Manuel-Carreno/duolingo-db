<?php 
require "config.php"; // $pdo
$mensaje = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $nivel = $_POST['nivel'] ?: null;
    $dificultad = $_POST['dificultad'];
    $tiempo_estimado = $_POST['tiempo_estimado'] ?: null;
    $habilidad = $_POST['habilidad_enfocada'];

    try {
        $sql = "INSERT INTO leccion (nivel, dificultad, tiempo_estimado, habilidad_enfocada)
                VALUES (:nivel, :dificultad, :tiempo, :habilidad)";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            ':nivel' => $nivel,
            ':dificultad' => $dificultad,
            ':tiempo' => $tiempo_estimado,
            ':habilidad' => $habilidad
        ]);

        $mensaje = "Lección creada exitosamente. ID: " . $pdo->lastInsertId();

    } catch (PDOException $e) {
        $mensaje = "Error: " . $e->getMessage();
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Crear Lección</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<h1>Crear Nueva Lección</h1>
<p><?= $mensaje ?></p>

<div class="container">

<form method="POST">
    <label>Nivel</label>
    <input type="number" name="nivel">

    <label>Dificultad</label>
    <select name="dificultad" required>
        <option>baja</option>
        <option>media</option>
        <option>alta</option>
    </select>

    <label>Tiempo estimado (HH:MM:SS)</label>
    <input type="time" name="tiempo_estimado">

    <label>Habilidad Enfocada</label>
    <select name="habilidad_enfocada" required>
        <option>gramática</option>
        <option>vocabulario</option>
        <option>escucha</option>
        <option>lectura</option>
        <option>escritura</option>
        <option>pronunciación</option>
    </select>

    <button type="submit">Crear Lección</button>
</form>

<a href="index.php">⬅ Volver</a>

</div>

</body>
</html>
