<?php
require "config.php";
$mensaje = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $segundo_nombre = !empty($_POST["segundo_nombre"]) ? $_POST["segundo_nombre"] : null;
    $segundo_apellido = !empty($_POST["segundo_apellido"]) ? $_POST["segundo_apellido"] : null;

    // Cifrar contraseña antes de guardar
    $contrasena_cifrada = password_hash($_POST["contrasena"], PASSWORD_BCRYPT);

    try {
        $sql = "INSERT INTO usuario 
            (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, nacionalidad, correo, contrasena)
            VALUES (?, ?, ?, ?, ?, ?, ?)";

        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            $_POST["primer_nombre"],
            $segundo_nombre,
            $_POST["primer_apellido"],
            $segundo_apellido,
            $_POST["nacionalidad"],
            $_POST["correo"],
            $contrasena_cifrada
        ]);

        $mensaje = "Usuario registrado correctamente. ID: " . $pdo->lastInsertId();

    } catch (PDOException $e) {
        $mensaje = "Error: " . $e->getMessage();
    }
}
?>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8">
    <title>Registrar Usuario</title>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <h2>Registrar nuevo usuario</h2>
    <p><?= $mensaje ?></p>

    <form method="POST">
      <label>Primer nombre: <input type="text" name="primer_nombre" required></label><br>
      <label>Segundo nombre: <input type="text" name="segundo_nombre"></label><br>
      <label>Primer apellido: <input type="text" name="primer_apellido" required></label><br>
      <label>Segundo apellido: <input type="text" name="segundo_apellido"></label><br>
      <label>Nacionalidad: <input type="text" name="nacionalidad" required></label><br>
      <label>Correo: <input type="email" name="correo" required></label><br>
      <label>Contraseña: <input type="password" name="contrasena" required></label><br>
      <button type="submit">Registrar</button>
    </form>

    <a href="index.php" class="back-btn">⬅ Volver</a>

<div style="height: 120px;"></div>
  </body>
</html>
