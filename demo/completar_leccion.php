<?php
require "config.php";
$mensaje = "";

// Para el primer SELECT
$usuarios = $pdo->query("SELECT id_usuario, primer_nombre FROM usuario")->fetchAll();

// Si el usuario seleccionó uno
$idiomas = [];
$lecciones = [];

if (!empty($_GET["id_usuario"])) {
    $id_usuario = $_GET["id_usuario"];

    // Idiomas que estudia el usuario
    $idiomas = $pdo->prepare("
        SELECT i.id_idioma, i.nombre
        FROM usuario_idioma ui
        JOIN idioma i ON ui.id_idioma = i.id_idioma
        WHERE ui.id_usuario = ?
    ");
    $idiomas->execute([$id_usuario]);
    $idiomas = $idiomas->fetchAll();

    // Lecciones asignadas al usuario
    $lecciones = $pdo->prepare("
        SELECT id_leccion
        FROM usuario_idioma_leccion
        WHERE id_usuario = ?
    ");
    $lecciones->execute([$id_usuario]);
    $lecciones = $lecciones->fetchAll();
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    try {
        $stmt = $pdo->prepare("CALL sp_completar_leccion(?, ?, ?, ?)");
        $stmt->execute([
            $_POST["id_usuario"],
            $_POST["id_idioma"],
            $_POST["id_leccion"],
            $_POST["xp"]
        ]);
        $mensaje = "✔ Lección completada correctamente.";
    } catch (PDOException $e) {
        $mensaje = "❌ Error: " . $e->getMessage();
    }
}
?>

<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8">
    <title>Completar Lección</title>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <h2>Completar una lección</h2>
    <p><strong><?= $mensaje ?></strong></p>
    
    <form method="GET">
      <label>Usuario:
        <select name="id_usuario" onchange="this.form.submit()">
          <option value="">Seleccione...</option>
        <?php foreach ($usuarios as $u): ?>
          <option value="<?= $u['id_usuario'] ?>" <?= (isset($_GET["id_usuario"]) && $_GET["id_usuario"] == $u['id_usuario']) ? 'selected' : '' ?>>
    <?= $u["primer_nombre"] ?>
        </option>
<?php endforeach; ?>
       </select>
     </label>
    </form>
    
    <?php if (!empty($idiomas)): ?>
    <form method="POST">
      <input type="hidden" name="id_usuario" value="<?= $_GET["id_usuario"] ?>">
      
      <label>Idioma:
        <select name="id_idioma" required>
    <?php foreach ($idiomas as $i): ?>
          <option value="<?= $i['id_idioma'] ?>"><?= $i["nombre"] ?></option>
    <?php endforeach; ?>
        </select>
      </label><br>
      
      <label>Lección:
        <select name="id_leccion" required>
    <?php foreach ($lecciones as $l): ?>
          <option value="<?= $l['id_leccion'] ?>"><?= $l['id_leccion'] ?></option>
    <?php endforeach; ?>
        </select>
      </label><br>
      
      <label>XP ganado:
        <input type="number" name="xp" required min="1">
      </label><br>
      
      <button type="submit">Completar</button>
    </form>
<?php endif; ?>

    <a href="index.php">⬅ Volver</a>

  </body>
</html>
