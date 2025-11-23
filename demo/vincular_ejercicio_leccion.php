<?php require "config.php"; ?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Vincular Ejercicio con Lección</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<h1>Vincular Ejercicio con Lección</h1>

<div class="container">
<form method="POST">
    <label>Lección</label>
    <select name="id_leccion" required>
        <?php
        $stmt = $pdo->query("SELECT id_leccion, CONCAT('Lección ', id_leccion, ' - ', dificultad) AS nombre FROM leccion");
        $lecciones = $stmt->fetchAll();
        foreach($lecciones as $fila) {
            echo "<option value='{$fila['id_leccion']}'>{$fila['nombre']}</option>";
        }
        ?>
    </select>

    <label>Ejercicio</label>
    <select name="id_ejercicio" required>
        <?php
        $stmt = $pdo->query("SELECT id_ejercicio, tipo FROM ejercicio");
        $ejercicios = $stmt->fetchAll();
        foreach($ejercicios as $fila) {
            echo "<option value='{$fila['id_ejercicio']}'>Ejercicio {$fila['id_ejercicio']} - {$fila['tipo']}</option>";
        }
        ?>
    </select>

    <label>Puntos asignados</label>
    <input type="number" name="puntos_asignados" value="0" min="0">

    <button type="submit">Vincular</button>
</form>

<a href="index.php" class="back-btn">⬅ Volver</a>
</div>

<?php
if ($_POST) {
    $id_leccion = $_POST['id_leccion'];
    $id_ejercicio = $_POST['id_ejercicio'];
    $puntos = $_POST['puntos_asignados'] ?: 0;

    $sql = "INSERT INTO leccion_ejercicio (id_leccion, id_ejercicio, puntos_asignados)
            VALUES (?, ?, ?)";
    $stmt = $pdo->prepare($sql);
    if ($stmt->execute([$id_leccion, $id_ejercicio, $puntos])) {
        echo "<script>alert('Ejercicio vinculado exitosamente');</script>";
    } else {
        echo "<script>alert('Error al vincular ejercicio');</script>";
    }
}
?>
</body>
</html>
