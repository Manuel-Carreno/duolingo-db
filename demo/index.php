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

<!-- SECCIÓN: VISUALIZACIÓN -->
<div class="section-box panel-section">
    <h3>Visualización de Datos</h3>
    <div class="grid">
        <a href="usuarios.php" class="visual-btn">Usuarios</a>
        <a href="lecciones.php" class="visual-btn">Lecciones</a>
        <a href="ejercicios.php" class="visual-btn">Ejercicios</a>
        <a href="idiomas.php" class="visual-btn">Idiomas</a>
        <a href="ver_resumen_usuario.php" class="visual-btn">Resumen Usuario</a>
        <a href="ranking.php" class="visual-btn">Ranking Global</a>
        <a href="rachas.php" class="visual-btn">Rachas</a>
        <a href="ligas.php" class="visual-btn">Ligas</a>
        <a href="ver_usuario_liga.php" class="visual-btn">Usuarios en Ligas</a>
    </div>
</div>

<!-- SECCIÓN: ACCIONES PRINCIPALES -->
<div class="section-box panel-section">
    <h3>Acciones Principales</h3>
    <div class="grid">
        <a href="registrar_usuario.php" class="action-btn">Registrar Usuario</a>
        <a href="asignar_idioma_usuario.php" class="action-btn">Asignar Idioma</a>
        <a href="completar_leccion.php" class="action-btn">Completar Lección</a>
        <a href="asignar_usuario_idioma_leccion.php" class="secundario">Asignar Lección</a>
        <a href="asignar_usuario_liga.php" class="action-btn">Asignar Usuario a Liga</a>
        <a href="asignar_recompensa_usuario.php" class="secundario">Asignar Recompensa</a>
    </div>
</div>

<!-- SECCIÓN: ADMINISTRACIÓN AVANZADA -->
<div class="section-box panel-section">
    <h3>Administración Avanzada</h3>
    <div class="grid">
        <a href="crear_leccion.php" class="secundario">Nueva Lección</a>
        <a href="crear_ejercicio.php" class="secundario">Nuevo Ejercicio</a>
        <a href="vincular_ejercicio_leccion.php" class="secundario">Vincular Ejercicio</a>
        <a href="crear_racha.php" class="action-btn">Crear Racha</a>
    	<a href="crear_liga.php" class="secundario">Crear Liga</a>
	<a href="eliminar_usuario.php" class="danger-btn">Eliminar Usuario</a>
    </div>
</div>

<div style="height: 120px;"></div>

</body>
</html>
