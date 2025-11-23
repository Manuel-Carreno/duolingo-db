USE duolingo_db;

DROP TRIGGER IF EXISTS trg_usuario_idioma_leccion_ai;
-- Cambiamos delimitador para poder usar BEGIN...END
DELIMITER $$

-- TRIGGER: Después de insertar en usuario_idioma_leccion,
--         suma el xp_obtenido al xp_acumulado del usuario en ese idioma.
CREATE TRIGGER trg_usuario_idioma_leccion_ai
AFTER INSERT ON usuario_idioma_leccion
FOR EACH ROW
BEGIN
  -- Solo actuamos si la nueva fila tiene xp_obtenido definido
  IF NEW.xp_obtenido IS NOT NULL THEN
    UPDATE usuario_idioma
    SET xp_acumulado = xp_acumulado + NEW.xp_obtenido
    WHERE id_usuario = NEW.id_usuario
      AND id_idioma  = NEW.id_idioma;
  END IF;
END$$

DELIMITER ;

-- Ejemplo de prueba:
-- INSERT INTO usuario_idioma_leccion (
--   id_usuario, id_idioma, id_leccion, porcentaje, estado, xp_obtenido, fecha_asignacion, fecha_activacion
-- ) VALUES (1, 1, 3, 50.00, 'activa', 30, CURRENT_DATE, CURRENT_DATE);
--
-- Luego:
-- SELECT xp_acumulado FROM usuario_idioma WHERE id_usuario = 1 AND id_idioma = 1;

-- Completar una lección (esto activará el trigger)
-- CALL sp_completar_leccion(1, 1, 3, 50);