<?php require "config.php"; ?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Asignar Lección a Usuario</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<h1>Asignar Lección a Usuario</h1>

<div class="container">
<!-- Formulario para seleccionar usuario -->
<form method="GET">
    <label>Usuario</label>
    <select name="id_usuario" onchange="this.form.submit()" required>
        <option value="">-- Seleccione un usuario --</option>
        <?php
        $stmt = $pdo->query("SELECT id_usuario, primer_nombre, primer_apellido FROM usuario");
        $usuarios = $stmt->fetchAll();
        $selectedUser = $_GET['id_usuario'] ?? null;

        foreach ($usuarios as $fila) {
            $selected = ($fila['id_usuario'] == $selectedUser) ? "selected" : "";
            echo "<option value='{$fila['id_usuario']}' $selected>{$fila['primer_nombre']} {$fila['primer_apellido']}</option>";
        }
        ?>
    </select>
</form>

<?php if ($selectedUser): ?>
<!-- Formulario de asignación de lección -->
<form method="POST">
    <input type="hidden" name="id_usuario" value="<?= $selectedUser ?>">

    <label>Idioma</label>
    <select name="id_idioma" required>
        <?php
        // Traer solo idiomas asignados al usuario
        $stmt = $pdo->prepare("
            SELECT i.id_idioma, i.nombre 
            FROM idioma i
            INNER JOIN usuario_idioma ui ON ui.id_idioma = i.id_idioma
            WHERE ui.id_usuario = ?
        ");
        $stmt->execute([$selectedUser]);
        $idiomas = $stmt->fetchAll();

        if ($idiomas) {
            foreach ($idiomas as $fila) {
                echo "<option value='{$fila['id_idioma']}'>{$fila['nombre']}</option>";
            }
        } else {
            echo "<option value='' disabled>No hay idiomas asignados</option>";
        }
        ?>
    </select>

    <label>Lección</label>
    <select name="id_leccion" required>
        <?php
        // Traer todas las lecciones (sin filtrar por usuario)
        $stmt = $pdo->query("SELECT id_leccion, CONCAT('Lección ', id_leccion, ' - ', habilidad_enfocada) AS nombre FROM leccion ORDER BY id_leccion ASC");
        $lecciones = $stmt->fetchAll();
        foreach ($lecciones as $fila) {
            echo "<option value='{$fila['id_leccion']}'>{$fila['nombre']}</option>";
        }
        ?>
    </select>

    <label>Porcentaje completado</label>
    <input type="number" name="porcentaje" value="0" min="0" max="100">

    <label>Estado</label>
    <select name="estado" required>
        <option value="activa">activa</option>
        <option value="inactiva">inactiva</option>
        <option value="obsoleta">obsoleta</option>
    </select>

    <label>XP obtenido</label>
    <input type="number" name="xp_obtenido" value="0" min="0">

    <label>Fecha asignación</label>
    <input type="date" name="fecha_asignacion">

    <label>Fecha activación</label>
    <input type="date" name="fecha_activacion">

    <button type="submit">Asignar</button>
</form>
<?php endif; ?>

<a href="index.php" class="back-btn">⬅ Volver</a>
</div>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $usuario = $_POST['id_usuario'];
    $idioma = $_POST['id_idioma'];
    $leccion = $_POST['id_leccion'];
    $porcentaje = $_POST['porcentaje'] ?: 0;
    $estado = $_POST['estado'];
    $xp = $_POST['xp_obtenido'] ?: 0;
    $fecha_asig = $_POST['fecha_asignacion'] ?: null;
    $fecha_act = $_POST['fecha_activacion'] ?: null;

    $sql = "INSERT INTO usuario_idioma_leccion
            (id_usuario, id_idioma, id_leccion, porcentaje, estado, xp_obtenido, fecha_asignacion, fecha_activacion)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $pdo->prepare($sql);
    if ($stmt->execute([$usuario, $idioma, $leccion, $porcentaje, $estado, $xp, $fecha_asig, $fecha_act])) {
        echo "<script>alert('Lección asignada correctamente');</script>";
    } else {
        echo "<script>alert('Error al asignar la lección');</script>";
    }
}
?>
</body>
</html>
