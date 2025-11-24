-- 09_views.sql
USE duolingo_db;

/* Perfil Público del Usuario: datos básicos + idiomas que estudia + nivel/XP. */
CREATE OR REPLACE VIEW vw_usuario_perfil AS
SELECT 
    u.id_usuario,
    CONCAT(u.primer_nombre, ' ', u.primer_apellido) AS nombre_completo,
    u.correo,
    u.nacionalidad,
    u.avatar,
    ui.id_idioma,
    i.nombre AS idioma,
    ui.estado AS estado_aprendizaje,
    ui.ranking,
    ui.xp_acumulado
FROM usuario u
LEFT JOIN usuario_idioma ui ON u.id_usuario = ui.id_usuario
LEFT JOIN idioma i ON ui.id_idioma = i.id_idioma;

/* Racha Actual del Usuario: obtener solo la racha vigente de cada usuario. */
CREATE OR REPLACE VIEW vw_racha_actual AS
SELECT 
    r.id_usuario,
    r.dias_consecutivos,
    r.fecha_inicio,
    r.fecha_fin
FROM racha r
WHERE r.fecha_fin IS NULL;

/* Ranking Global de XP por Idioma: clasificación del progreso por idioma. */
CREATE OR REPLACE VIEW vw_ranking_xp_por_idioma AS
SELECT
    ui.id_idioma,
    i.nombre AS idioma,
    ui.id_usuario,
    CONCAT(u.primer_nombre, ' ', u.primer_apellido) AS usuario,
    ui.xp_acumulado,
    RANK() OVER (PARTITION BY ui.id_idioma ORDER BY ui.xp_acumulado DESC) AS posicion
FROM usuario_idioma ui
JOIN idioma i ON ui.id_idioma = i.id_idioma
JOIN usuario u ON ui.id_usuario = u.id_usuario;

/* Panel de Actividad del Usuario: combina idiomas activos + rachas + XP total */
CREATE OR REPLACE VIEW vw_usuario_dashboard AS
SELECT
    u.id_usuario,
    CONCAT(u.primer_nombre, ' ', u.primer_apellido) AS nombre,

    -- XP total del usuario
    (SELECT SUM(ui2.xp_acumulado)
     FROM usuario_idioma ui2
     WHERE ui2.id_usuario = u.id_usuario) AS xp_total,

    -- Racha actual
    (SELECT dias_consecutivos
     FROM racha r 
     WHERE r.id_usuario = u.id_usuario AND r.fecha_fin IS NULL
     LIMIT 1) AS racha_actual,

    -- Idiomas activos
    (SELECT COUNT(*)
     FROM usuario_idioma ui3
     WHERE ui3.id_usuario = u.id_usuario AND ui3.estado = 'aprendiendo') AS idiomas_activos,

    -- LIGA ACTUAL (si tiene)
    ul.id_liga,
    l.nombre AS liga_nombre,
    ul.xp_ganado AS liga_xp,
    ul.ranking AS liga_ranking,
    ul.estado AS liga_estado,
    ul.fecha_inicio AS liga_fecha_inicio,
    ul.fecha_fin AS liga_fecha_fin

FROM usuario u
LEFT JOIN usuario_liga ul 
    ON ul.id_usuario = u.id_usuario 
    AND ul.fecha_fin IS NULL
LEFT JOIN liga l 
    ON ul.id_liga = l.id_liga;

/* Progreso de Lecciones por Usuario e Idioma */
CREATE OR REPLACE VIEW vw_progreso_lecciones AS
SELECT
    uil.id_usuario,
    uil.id_idioma,
    i.nombre AS idioma,
    uil.id_leccion,
    l.nivel,
    uil.porcentaje,
    uil.estado,
    uil.xp_obtenido,
    uil.fecha_asignacion,
    uil.fecha_activacion
FROM usuario_idioma_leccion uil
JOIN idioma i ON uil.id_idioma = i.id_idioma
JOIN leccion l ON uil.id_leccion = l.id_leccion;

/* Liga y XP de Competición */
CREATE OR REPLACE VIEW vw_competencia_liga AS
SELECT
    ul.id_usuario,
    CONCAT(u.primer_nombre, ' ', u.primer_apellido) AS usuario,
    ul.id_liga,
    l.nombre AS liga,
    ul.xp_ganado,
    ul.ranking,
    ul.estado,
    ul.fecha_inicio,
    ul.fecha_fin
FROM usuario_liga ul
JOIN usuario u ON ul.id_usuario = u.id_usuario
JOIN liga l ON ul.id_liga = l.id_liga;

/* Resumen General para Administradores */
CREATE OR REPLACE VIEW vw_resumen_admin AS
SELECT
    u.id_usuario,
    CONCAT(u.primer_nombre, ' ', u.primer_apellido) AS nombre,
    
    (SELECT COUNT(*) FROM usuario_idioma ui WHERE ui.id_usuario = u.id_usuario) AS idiomas_totales,
    (SELECT COUNT(*) FROM usuario_idioma ui WHERE ui.id_usuario = u.id_usuario AND ui.estado='aprendiendo') AS idiomas_activos,
    (SELECT SUM(xp_acumulado) FROM usuario_idioma ui WHERE ui.id_usuario = u.id_usuario) AS xp_total,
    (SELECT MAX(dias_consecutivos) FROM racha r WHERE r.id_usuario = u.id_usuario) AS mejor_racha
FROM usuario u;

