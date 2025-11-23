USE duolingo_db;

DROP PROCEDURE IF EXISTS sp_completar_leccion;
DELIMITER $$

-- PROCEDIMIENTO: Marca una lección como completada,
--                suma XP y entrega una recompensa tipo "Lección completada".
CREATE PROCEDURE sp_completar_leccion(
  IN p_id_usuario INT,   -- Usuario que completó la lección
  IN p_id_idioma  INT,   -- Idioma al que pertenece la lección
  IN p_id_leccion INT,   -- Lección completada
  IN p_xp_leccion INT    -- XP que se debe otorgar por esta lección
)
BEGIN
  -- Variable para guardar la recompensa correspondiente a "Lección completada"
  DECLARE v_recompensa_xp_id INT;
  
  -- Handler para errores
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = 'Error al completar lección: cambios revertidos';
  END;

  -- Buscar recompensa de "Lección completada"
  SELECT id_recompensa
  INTO v_recompensa_xp_id
  FROM recompensa
  WHERE tipo = 'xp'
    AND descripcion = 'Lección completada'
  LIMIT 1;

  -- Iniciamos una transacción porque vamos a hacer varios cambios relacionados
  START TRANSACTION;

  -- Actualizar usuario_idioma_leccion
  UPDATE usuario_idioma_leccion
  SET porcentaje = 100,
      estado = 'activa',
      xp_obtenido = p_xp_leccion,
      fecha_activacion = IFNULL(fecha_activacion, CURRENT_DATE)
  WHERE id_usuario = p_id_usuario
    AND id_idioma = p_id_idioma
    AND id_leccion = p_id_leccion;

  -- Verificar que se actualizó algo
  IF ROW_COUNT() = 0 THEN
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = 'No se encontró la lección para ese usuario';
  END IF;

  -- Sumar XP al idioma (el trigger también sumará, pero esto es por si acaso)
  UPDATE usuario_idioma
  SET xp_acumulado = xp_acumulado + p_xp_leccion
  WHERE id_usuario = p_id_usuario
    AND id_idioma = p_id_idioma;

  -- Asignar recompensa si existe
  IF v_recompensa_xp_id IS NOT NULL THEN
    INSERT INTO usuario_recompensa (id_usuario, id_recompensa, cantidad, fecha_obtencion)
    VALUES (p_id_usuario, v_recompensa_xp_id, 1, CURRENT_DATE)
    ON DUPLICATE KEY UPDATE
      cantidad = cantidad + 1,
      fecha_obtencion = VALUES(fecha_obtencion);
  END IF;

  -- Si todo se ejecutó bien, confirmamos
  COMMIT;
  
  SELECT 'Lección completada exitosamente' AS resultado;
END$$

DELIMITER ;

-- Ejemplo de uso:
-- El usuario 1 completa la lección 1 del idioma 1 y gana 50 XP
-- CALL sp_completar_leccion(1, 1, 1, 50);

-- Ver recompensas del usuario
-- SELECT u.primer_nombre, r.descripcion, ur.cantidad, ur.fecha_obtencion
-- FROM usuario u
-- JOIN usuario_recompensa ur ON u.id_usuario = ur.id_usuario
-- JOIN recompensa r ON ur.id_recompensa = r.id_recompensa
-- WHERE u.id_usuario = 1;