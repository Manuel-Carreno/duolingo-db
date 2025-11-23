USE duolingo_db;

DROP PROCEDURE IF EXISTS sp_eliminar_usuario;
DELIMITER $$

CREATE PROCEDURE sp_eliminar_usuario(IN p_id_usuario INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error eliminando usuario. Transacción revertida.';
    END;

    START TRANSACTION;

    -- Primero limpiamos tablas con RESTRICT
    DELETE FROM usuario_notificacion WHERE id_usuario = p_id_usuario;
    DELETE FROM usuario_recompensa WHERE id_usuario = p_id_usuario;

    -- TODO lo demás tiene ON DELETE CASCADE
    DELETE FROM usuario WHERE id_usuario = p_id_usuario;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Usuario no existe, no se pudo eliminar.';
    END IF;

    COMMIT;
END$$

DELIMITER ;
