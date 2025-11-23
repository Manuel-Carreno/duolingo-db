<?php require "config.php"; ?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Duolingo DB – Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <h1>Panel Principal</h1>
    <h2>Administración del Proyecto Duolingo</h2>
    
    <h3>Visualización de Datos</h3>
    <div class="container">
        <a href="usuarios.php" class="visual-btn">Ver Usuarios</a>
        <a href="lecciones.php" class="visual-btn">Ver Lecciones</a>
        <a href="ejercicios.php" class="visual-btn">Ver Ejercicios</a>
        <a href="idiomas.php" class="visual-btn">Ver Idiomas</a>
    </div>
    
    <h3>Funcionalidades</h3>
    <div class="container">

        <!-- ENLACES PRINCIPALES -->
        <a href="registrar_usuario.php">Registrar usuario</a>
        <a href="asignar_idioma_usuario.php">Asignar idioma a usuario</a>
        <a href="completar_leccion.php">Completar lección</a>
        <a href="ver_resumen_usuario.php">Ver resumen de usuario</a>
        <a href="eliminar_usuario.php" class="danger-btn">Eliminar usuario</a>
        <a href="crear_leccion.php" class="secundario">Crear nueva lección</a>
        <a href="crear_ejercicio.php" class="secundario">Crear nuevo ejercicio</a>
        <a href="vincular_ejercicio_leccion.php" class="secundario">Vincular ejercicio con lección</a>
        <a href="asignar_usuario_idioma_leccion.php" class="secundario">Asignar lección a usuario</a>
	<a href="asignar_recompensa_usuario.php" class="secundario">Asignar recompensa a usuario</a>
    </div>
</body>
</html>
