<?php require "config.php"; ?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Asignar Recompensa a Usuario</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<h1>Asignar Recompensa a Usuario</h1>

<div class="container">

<!-- SELECT USUARIO -->
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
            echo "<option value='{$fila['id_usuario']}' $selected>
                    ({$fila['id_usuario']}) {$fila['primer_nombre']} {$fila['primer_apellido']}
                  </option>";
        }
        ?>
    </select>
</form>

<?php if ($selectedUser): ?>
<!-- ASIGNAR RECOMPENSA -->
<form method="POST">
    <input type="hidden" name="id_usuario" value="<?= $selectedUser ?>">

    <label>Recompensa</label>
    <select name="id_recompensa" required>
        <?php
        $stmt = $pdo->query("SELECT id_recompensa, tipo, descripcion FROM recompensa ORDER BY id_recompensa ASC");
        $recompensas = $stmt->fetchAll();

        foreach ($recompensas as $fila) {
            echo "<option value='{$fila['id_recompensa']}'>
                    ({$fila['id_recompensa']}) {$fila['tipo']} - {$fila['descripcion']}
                  </option>";
        }
        ?>
    </select>

    <label>Cantidad</label>
    <input type="number" name="cantidad" value="1" min="1">

    <label>Fecha de obtención</label>
    <input type="date" name="fecha_obtencion" value="<?= date('Y-m-d') ?>">

    <button type="submit">Asignar</button>
</form>
<?php endif; ?>

<a href="index.php" class="back-btn">⬅ Volver</a>
<div style="height: 120px;"></div>
</div>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_usuario     = $_POST['id_usuario'];
    $id_recompensa  = $_POST['id_recompensa'];
    $cantidad       = $_POST['cantidad'] ?? 1;
    $fecha          = $_POST['fecha_obtencion'] ?? date('Y-m-d');

    $stmt = $pdo->prepare("
        INSERT INTO usuario_recompensa (id_usuario, id_recompensa, cantidad, fecha_obtencion)
        VALUES (?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE 
            cantidad = cantidad + VALUES(cantidad),
            fecha_obtencion = VALUES(fecha_obtencion)
    ");

    echo $stmt->execute([$id_usuario, $id_recompensa, $cantidad, $fecha])
        ? "<p class='success'>Recompensa asignada correctamente.</p>"
        : "<p class='error'>Error al asignar la recompensa.</p>";
}
?>

</body>
</html>
