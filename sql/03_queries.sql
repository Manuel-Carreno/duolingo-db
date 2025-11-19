-- 03_queries.sql

USE duolingo_db;

-- 1. CONSULTAS REPRESENTATIVAS

SELECT u.primer_nombre, u.primer_apellido, i.nombre AS idioma, ui.xp_acumulado
FROM usuario u
JOIN usuario_idioma ui ON u.id_usuario = ui.id_usuario
JOIN idioma i ON ui.id_idioma = i.id_idioma
WHERE i.nombre = 'Inglés' AND ui.xp_acumulado > 400;

SELECT u.primer_nombre, u.primer_apellido, l.nombre AS liga, ul.ranking, ul.estado
FROM usuario u
JOIN usuario_liga ul ON u.id_usuario = ul.id_usuario
JOIN liga l ON ul.id_liga = l.id_liga
ORDER BY l.nivel, ul.ranking ASC;

SELECT i.nombre AS idioma, AVG(ui.xp_acumulado) AS promedio_xp
FROM usuario_idioma ui
JOIN idioma i ON ui.id_idioma = i.id_idioma
GROUP BY i.nombre
HAVING AVG(ui.xp_acumulado) > 500
ORDER BY promedio_xp DESC;

WITH promedio_rachas AS (
  SELECT AVG(dias_consecutivos) AS promedio FROM racha
)
SELECT u.primer_nombre, u.primer_apellido, r.dias_consecutivos
FROM usuario u
JOIN racha r ON u.id_usuario = r.id_usuario
WHERE r.fecha_fin IS NULL
  AND r.dias_consecutivos > (SELECT promedio FROM promedio_rachas);


-- 2. TRANSACCIÓN BREVE

-- 2. TRANSACCIÓN CON CONTROL BÁSICO Y ROLLBACK OPCIONAL
START TRANSACTION;

-- Verifica existencia antes de insertar
SELECT 'Verificando claves existentes...' AS mensaje;
SELECT id_usuario FROM usuario WHERE id_usuario = 1;
SELECT id_recompensa FROM recompensa WHERE id_recompensa = 2;

-- Inserta la recompensa si las claves existen
INSERT INTO usuario_recompensa (id_usuario, id_recompensa, cantidad, fecha_obtencion)
VALUES (1, 2, 1, CURRENT_DATE);

-- Actualiza la experiencia del usuario
UPDATE usuario_idioma
SET xp_acumulado = xp_acumulado + 50
WHERE id_usuario = 1 AND id_idioma = 1;

COMMIT;

SELECT '✅ Transacción ejecutada correctamente (si existen las claves).' AS mensaje;


-- 3. SEGURIDAD

CREATE USER 'duolingo_readonly'@'%' IDENTIFIED BY 'readonly123';
GRANT SELECT ON duolingo_db.* TO 'duolingo_readonly'@'%';
FLUSH PRIVILEGES;
