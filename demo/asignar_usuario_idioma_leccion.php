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

<!-- SELECCIÓN DE USUARIO -->
<form method="GET">
    <label>Usuario</label>
    <select name="id_usuario" onchange="this.form.submit()" required>
        <option value="">-- Seleccione un usuario --</option>

        <?php
        $stmt = $pdo->query("SELECT id_usuario, primer_nombre, primer_apellido FROM usuario");
        $usuarios = $stmt->fetchAll();
        $selectedUser = $_GET['id_usuario'] ?? null;

        foreach ($usuarios as $fila) {
            $sel = $fila['id_usuario'] == $selectedUser ? "selected" : "";
            echo "<option value='{$fila['id_usuario']}' $sel>
                    ({$fila['id_usuario']}) {$fila['primer_nombre']} {$fila['primer_apellido']}
                  </option>";
        }
        ?>
    </select>
</form>

<?php if ($selectedUser): ?>

<!-- FORMULARIO ASIGNAR LECCIÓN -->
<form method="POST">
    <input type="hidden" name="id_usuario" value="<?= $selectedUser ?>">

    <label>Idioma</label>
    <select name="id_idioma" required>
        <?php
        $stmt = $pdo->prepare("
            SELECT i.id_idioma, i.nombre
            FROM idioma i
            JOIN usuario_idioma ui ON ui.id_idioma = i.id_idioma
            WHERE ui.id_usuario = ?
        ");
        $stmt->execute([$selectedUser]);
        $idiomas = $stmt->fetchAll();

        foreach ($idiomas as $i) {
            echo "<option value='{$i['id_idioma']}'>
                    ({$i['id_idioma']}) {$i['nombre']}
                  </option>";
        }
        ?>
    </select>

    <label>Lección</label>
    <select name="id_leccion" required>
        <?php
        $stmt = $pdo->query("
            SELECT id_leccion, habilidad_enfocada 
            FROM leccion 
            ORDER BY id_leccion
        ");
        $lecciones = $stmt->fetchAll();

        foreach ($lecciones as $l) {
            echo "<option value='{$l['id_leccion']}'>
                    ({$l['id_leccion']}) {$l['habilidad_enfocada']}
                  </option>";
        }
        ?>
    </select>

    <label>Porcentaje completado</label>
    <input type="number" name="porcentaje" value="0" min="0" max="100">

    <label>Estado</label>
    <select name="estado">
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
<div style="height: 120px;"></div>
</div>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $sql = "INSERT INTO usuario_idioma_leccion
            (id_usuario, id_idioma, id_leccion, porcentaje, estado, xp_obtenido, fecha_asignacion, fecha_activacion)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $pdo->prepare($sql);

    $ok = $stmt->execute([
        $_POST['id_usuario'],
        $_POST['id_idioma'],
        $_POST['id_leccion'],
        $_POST['porcentaje'] ?: 0,
        $_POST['estado'],
        $_POST['xp_obtenido'] ?: 0,
        $_POST['fecha_asignacion'] ?: null,
        $_POST['fecha_activacion'] ?: null
    ]);

    echo "<script>alert('" . ($ok ? "Lección asignada correctamente" : "Error al asignar") . "');</script>";
}
?>
</body>
</html>
