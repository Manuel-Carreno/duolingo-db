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

  -- 1) Buscar en la tabla recompensa la que corresponda a "Lección completada"
  SELECT id_recompensa
  INTO v_recompensa_xp_id
  FROM recompensa
  WHERE tipo = 'xp'
    AND descripcion = 'Lección completada'
  LIMIT 1;

  -- Iniciamos una transacción porque vamos a hacer varios cambios relacionados
  START TRANSACTION;

  -- 2) Actualizar el registro de usuario_idioma_leccion:
  --    ponemos 100% de porcentaje, guardamos el XP de la lección
  UPDATE usuario_idioma_leccion
  SET porcentaje       = 100,                     -- completada
      estado           = 'activa',                -- en tu modelo no existe 'completada', usamos 'activa'
      xp_obtenido      = p_xp_leccion,
      fecha_activacion = IFNULL(fecha_activacion, CURRENT_DATE)
  WHERE id_usuario = p_id_usuario
    AND id_idioma  = p_id_idioma
    AND id_leccion = p_id_leccion;

  -- 3) Sumar el XP de la lección al XP total del idioma del usuario
  UPDATE usuario_idioma
  SET xp_acumulado = xp_acumulado + p_xp_leccion
  WHERE id_usuario = p_id_usuario
    AND id_idioma  = p_id_idioma;

  -- 4) Si existe una recompensa definida como "Lección completada", la asignamos al usuario
  IF v_recompensa_xp_id IS NOT NULL THEN
    INSERT INTO usuario_recompensa (id_usuario, id_recompensa, cantidad, fecha_obtencion)
    VALUES (p_id_usuario, v_recompensa_xp_id, 1, CURRENT_DATE)
    ON DUPLICATE KEY UPDATE
      cantidad        = cantidad + 1,
      fecha_obtencion = VALUES(fecha_obtencion);
  END IF;

  -- Si todo se ejecutó bien, confirmamos
  COMMIT;
END$$

DELIMITER ;

-- Ejemplo de uso:
-- El usuario 1 completa la lección 1 del idioma 1 y gana 50 XP
-- CALL sp_completar_leccion(1, 1, 1, 50);
