USE duolingo_db;

DROP PROCEDURE IF EXISTS sp_sumar_xp_y_recompensa;
DELIMITER $$

CREATE PROCEDURE sp_sumar_xp_y_recompensa(
    IN p_id_usuario INT,
    IN p_id_idioma INT,
    IN p_xp_a_sumar INT,
    IN p_id_recompensa INT
)
BEGIN
    -- Handler para manejar errores automáticamente
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: transacción revertida automáticamente';
    END;

  START TRANSACTION;

  -- Verificar que exista la relación usuario-idioma
  IF NOT EXISTS (
    SELECT 1 FROM usuario_idioma 
    WHERE id_usuario = p_id_usuario AND id_idioma = p_id_idioma
  ) THEN
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = 'El usuario no está aprendiendo ese idioma';
  END IF;

  -- Sumar XP
  UPDATE usuario_idioma
  SET xp_acumulado = xp_acumulado + p_xp_a_sumar
  WHERE id_usuario = p_id_usuario
    AND id_idioma = p_id_idioma;

  -- Registrar recompensa
  INSERT INTO usuario_recompensa (id_usuario, id_recompensa, cantidad, fecha_obtencion)
  VALUES (p_id_usuario, p_id_recompensa, 1, CURRENT_DATE)
  ON DUPLICATE KEY UPDATE
    cantidad = cantidad + 1,
    fecha_obtencion = VALUES(fecha_obtencion);

  COMMIT;
END$$

DELIMITER ;

-- Ejemplo de uso: Sumar XP y dar recompensa manual
-- CALL sp_sumar_xp_y_recompensa(1, 1, 30, 1);

-- Verificar los cambios
-- SELECT u.primer_nombre, i.nombre AS idioma, ui.xp_acumulado
-- FROM usuario u
-- JOIN usuario_idioma ui ON u.id_usuario = ui.id_usuario
-- JOIN idioma i ON ui.id_idioma = i.id_idioma
-- WHERE u.id_usuario = 1;
