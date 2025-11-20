-- INICIO DE LA TRANSACCIÓN
START TRANSACTION;

-- 1) Sumar XP al usuario en el idioma específico
UPDATE usuario_idioma
SET xp_acumulado = xp_acumulado + 30  -- cantidad de XP a sumar
WHERE id_usuario = 1
  AND id_idioma  = 1;                 -- por ejemplo, inglés

-- 2) Registrar la recompensa en usuario_recompensa
--    Si ya tenía esa recompensa, aumentamos la cantidad
INSERT INTO usuario_recompensa (id_usuario, id_recompensa, cantidad, fecha_obtencion)
VALUES (1, 1, 1, CURRENT_DATE)         -- id_recompensa = 1, por ejemplo "Bonificación diaria"
ON DUPLICATE KEY UPDATE
  cantidad        = cantidad + 1,      -- si ya existe, solo sumamos 1
  fecha_obtencion = VALUES(fecha_obtencion);

-- Si todo salió bien, confirmamos los cambios
COMMIT;

-- Si algo fallara en medio, podrías usar:
-- ROLLBACK;
