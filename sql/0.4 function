USE duolingo;

-- Cambiamos el delimitador porque vamos a definir un bloque BEGIN...END
DELIMITER $$

-- FUNCIÓN: Calcula el XP total que tiene un usuario en todos sus idiomas
CREATE FUNCTION fn_total_xp_usuario(p_id_usuario INT)
RETURNS INT -- La función devuelve un número entero
DETERMINISTIC -- Siempre devuelve lo mismo para el mismo parámetro
READS SQL DATA -- Solo lee datos, no modifica nada
BEGIN
  -- Variable local donde guardaremos el resultado
  DECLARE v_total INT;

  -- Sumamos todo el xp_acumulado del usuario en la tabla usuario_idioma
  SELECT IFNULL(SUM(xp_acumulado), 0)
  INTO v_total
  FROM usuario_idioma
  WHERE id_usuario = p_id_usuario;

  -- Devolvemos el total
  RETURN v_total;
END$$

-- Volvemos el delimitador al punto y coma normal
DELIMITER ;

-- Ejemplo de uso:
-- SELECT fn_total_xp_usuario(1) AS xp_total_usuario_1;
