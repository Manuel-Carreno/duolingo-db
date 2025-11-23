-- 02_seed.sql

-- ==== INSERTAR EN TABLAS ====

USE duolingo_db;

INSERT INTO usuario (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, correo, contrasena, nacionalidad) VALUES
('Ana', 'María', 'Gómez', 'López', 'ana@example.com', '$2y$10$u1JqZRm1d7gkM9XG07sfiOMoytR6wLh9kOeI1P2vKhxJ6gfr9bT4G', 'Colombia'),
('Juan', NULL, 'Pérez', 'Rodríguez', 'juanp@example.com', '$2y$10$w0KxvZr6bJq1zM5yQ9EjuuQ8xZpH0Xy2N6vFy1Pj7F0c/6JYq1t0K', 'México'),
('Laura', 'Sofía', 'Martínez', 'Díaz', 'laura@example.com', '$2y$10$R5u1ZJ9xk8WcK4Yq2N8hKeN3P0vF3zY1H9bS4wV6D7jT1eK6qP0Gq', 'Argentina'),
('Pedro', NULL, 'Ramírez', 'Castillo', 'pedro@example.com', '$2y$10$T1m9YxF2bQ4sW7K8vC2oUuJ5xZpF3aV1D6gH3yJ8N9mB0Q2R7pE6', 'Chile'),
('Camila', 'Andrea', 'Fernández', 'Vega', 'camila@example.com', '$2y$10$N0p8BzK1qR5wL6M7sT9yUvG4xPzH2eK1J6nW9vR4D3bC8Z7qF1eK', 'Perú'),
('Andrés', NULL, 'López', 'Ruiz', 'andres@example.com', '$2y$10$H3xR1D8vJ5nS2K6bW0yQvL9pZsH7tF4X1cJ5mR8N6yT2pK1eV7oQ', 'Colombia'),
('Valentina', 'Isabel', 'Torres', 'Moreno', 'valen@example.com', '$2y$10$F2vQ1H9pZ6kW4L5sT7bYvN3xG0dE1R5M6oJ3yP9K8nV4wC1eZ2xQ', 'Uruguay'),
('Carlos', 'Eduardo', 'Jiménez', 'Rojas', 'carlos@example.com', '$2y$10$K9wV1X6rB7cT2M8sQ3nHyP0vZ5kF4dJ1R6mS9oL2N7yU3eQ8tG1e', 'Ecuador'),
('María', 'Paula', 'Herrera', 'Pérez', 'maria@example.com', '$2y$10$D1jQ4K7sP9wX2R5tN3eYvB0xZ6kF8cH1M5pJ2nV7Q4sL9yT6eW3o', 'Bolivia'),
('David', 'Alejandro', 'Suárez', 'Martínez', 'david@example.com', '$2y$10$G4rH7Y2bQ1sL6T8nW3vKpX5xZ9dF0mJ2E6oN3yV7C1tP4eK9qR5o', 'España'),
('Sofía', 'Lucía', 'Reyes', 'Cano', 'sofia@example.com', '$2y$10$P2vF9K6bT1qM3W5xR8yNzJ0pZ7kL2sH4D9cV6nR1E5yT3wQ8oK4e', 'Colombia'),
('Daniel', NULL, 'Cruz', 'Pineda', 'daniel@example.com', '$2y$10$L3xQ7R2kV5bT8M1nS4yWvN6xZ0jF9cH2P5oJ1yR7K3eT4qC8vN2e', 'Argentina'),
('Gabriela', 'Fernanda', 'Morales', 'Santos', 'gaby@example.com', '$2y$10$M0sT6N3kR1bV8L5xQ2yPwH9zZ4dF7cJ1K5oN2yR8E3qT6wC9pQ4e', 'México'),
('Nicolás', 'Javier', 'Ortiz', 'García', 'nico@example.com', '$2y$10$V5kR2P8bJ1nS3M6tX9yWvN0xZ4dF7hJ2P5oN1yR8C3eT6qQ0vL2e', 'Chile'),
('Lucía', 'Estefanía', 'Rincón', 'Navarro', 'lucia@example.com', '$2y$10$C7pN1M5kR2bT8L3xQ0yWvH6xZ9dF2jJ1K5oN3yR7E4qT9wC6vP1e', 'Colombia'),
('Felipe', 'Andrés', 'Vargas', 'Salazar', 'felipe@example.com', '$2y$10$J2rK6P1bT4nS9M3xQ8yWvH0xZ5dF8cJ1P5oN2yR7E4tT9wC6qL1e', 'Ecuador'),
('Sara', NULL, 'Rojas', 'Pérez', 'sara@example.com', '$2y$10$T6kR1P4bJ9nS2M7tX3yWvN5xZ8dF1hJ2P5oN1yR8C3eT6qQ0vL2e', 'Perú'),
('Emilio', 'Andrés', 'Gómez', 'Luna', 'emilio@example.com', '$2y$10$B1pN5M2kR4bT8L3xQ0yWvH6xZ9dF2jJ1K5oN3yR7E4qT9wC6vP1e', 'Colombia'),
('Paula', 'Andrea', 'Cárdenas', 'Mora', 'paula@example.com', '$2y$10$H3rK7P1bT4nS8M2xQ9yWvH0xZ5dF8cJ1P5oN2yR7E4tT9wC6qL1e', 'Venezuela'),
('Esteban', 'David', 'Ramírez', 'Quintero', 'esteban@example.com', '$2y$10$D2kR6P1bJ3nS9M7tX4yWvN0xZ5dF8hJ2P5oN1yR8C3eT6qQ0vL2e', 'Uruguay');


INSERT INTO idioma (nombre, nivel_maximo, codigo_iso, fecha_adicion)
VALUES
('Inglés', 10, 'EN', CURRENT_DATE),
('Francés', 10, 'FR', CURRENT_DATE),
('Alemán', 10, 'DE', CURRENT_DATE),
('Italiano', 10, 'IT', CURRENT_DATE),
('Portugués', 10, 'PT', CURRENT_DATE),
('Ruso', 10, 'RU', CURRENT_DATE),
('Japonés', 10, 'JP', CURRENT_DATE),
('Coreano', 10, 'KR', CURRENT_DATE),
('Chino', 10, 'ZH', CURRENT_DATE),
('Sueco', 10, 'SE', CURRENT_DATE),
('Noruego', 10, 'NO', CURRENT_DATE),
('Danés', 10, 'DA', CURRENT_DATE),
('Holandés', 10, 'NL', CURRENT_DATE),
('Turco', 10, 'TR', CURRENT_DATE),
('Árabe', 10, 'AR', CURRENT_DATE),
('Hindi', 10, 'HI', CURRENT_DATE),
('Griego', 10, 'GR', CURRENT_DATE),
('Hebreo', 10, 'HE', CURRENT_DATE),
('Polaco', 10, 'PL', CURRENT_DATE),
('Catalán', 10, 'CA', CURRENT_DATE);


INSERT INTO usuario_idioma (id_usuario, id_idioma, estado, ranking, fecha_inicio, fecha_fin, xp_acumulado)
VALUES
(1, 1, 'aprendiendo', 10, '2024-01-10', NULL, 500),
(2, 2, 'aprendiendo', 15, '2024-02-05', NULL, 450),
(3, 3, 'completado', 8, '2024-03-12', '2024-08-01', 1000),
(4, 1, 'aprendiendo', 20, '2024-04-01', NULL, 350),
(5, 4, 'inactivo', NULL, '2024-05-03', NULL, 200),
(6, 5, 'aprendiendo', 25, '2024-05-10', NULL, 600),
(7, 6, 'aprendiendo', 12, '2024-06-02', NULL, 480),
(8, 2, 'completado', 5, '2024-06-15', '2024-09-01', 950),
(9, 3, 'aprendiendo', 18, '2024-07-07', NULL, 520),
(10, 1, 'aprendiendo', 14, '2024-07-10', NULL, 400),
(11, 4, 'abandonado', NULL, '2024-08-01', '2024-08-15', 150),
(12, 5, 'aprendiendo', 22, '2024-08-05', NULL, 700),
(13, 6, 'completado', 7, '2024-08-10', '2024-09-10', 1100),
(14, 7, 'aprendiendo', 30, '2024-09-01', NULL, 800),
(15, 8, 'inactivo', NULL, '2024-09-05', NULL, 250),
(16, 9, 'aprendiendo', 16, '2024-09-10', NULL, 450),
(17, 10, 'aprendiendo', 19, '2024-09-12', NULL, 300),
(18, 1, 'completado', 6, '2024-01-15', '2024-06-15', 1200),
(19, 2, 'aprendiendo', 21, '2024-02-20', NULL, 550),
(20, 3, 'inactivo', NULL, '2024-03-25', NULL, 100);


INSERT INTO leccion (nivel, dificultad, tiempo_estimado, habilidad_enfocada)
VALUES
(1,'baja','00:05:00','vocabulario'),
(2,'baja','00:06:00','lectura'),
(3,'media','00:08:00','gramática'),
(4,'media','00:09:00','vocabulario'),
(5,'alta','00:10:00','escucha'),
(6,'media','00:07:30','lectura'),
(7,'alta','00:10:30','escritura'),
(8,'media','00:08:00','pronunciación'),
(9,'baja','00:05:30','vocabulario'),
(10,'alta','00:09:30','gramática'),
(11,'baja','00:05:00','lectura'),
(12,'media','00:08:15','escritura'),
(13,'alta','00:10:15','pronunciación'),
(14,'media','00:07:45','escucha'),
(15,'alta','00:10:45','vocabulario'),
(16,'media','00:08:30','lectura'),
(17,'baja','00:06:30','vocabulario'),
(18,'media','00:09:00','gramática'),
(19,'alta','00:10:00','escucha'),
(20,'media','00:07:15','escritura');


INSERT INTO usuario_idioma_leccion (id_usuario, id_idioma, id_leccion, porcentaje, estado, xp_obtenido, fecha_asignacion, fecha_activacion)
VALUES
(1, 1, 1, 100.00, 'activa', 50, '2024-01-15', '2024-01-15'),
(1, 1, 2, 90.00, 'activa', 45, '2024-01-16', '2024-01-16'),
(2, 2, 3, 100.00, 'activa', 60, '2024-02-10', '2024-02-10'),
(3, 3, 4, 100.00, 'inactiva', 55, '2024-03-20', '2024-03-21'),
(4, 1, 5, 75.00, 'activa', 35, '2024-04-05', '2024-04-06'),
(5, 4, 6, 80.00, 'activa', 40, '2024-05-05', '2024-05-06'),
(6, 5, 7, 50.00, 'inactiva', 20, '2024-05-15', NULL),
(7, 6, 8, 100.00, 'activa', 65, '2024-06-10', '2024-06-10'),
(8, 2, 9, 95.00, 'activa', 55, '2024-07-01', '2024-07-02'),
(9, 3, 10, 60.00, 'activa', 30, '2024-07-10', '2024-07-11'),
(10, 1, 11, 85.00, 'activa', 40, '2024-07-15', '2024-07-16'),
(11, 4, 12, 70.00, 'inactiva', 25, '2024-08-05', NULL),
(12, 5, 13, 100.00, 'activa', 70, '2024-08-10', '2024-08-10'),
(13, 6, 14, 90.00, 'activa', 60, '2024-08-15', '2024-08-16'),
(14, 7, 15, 80.00, 'activa', 50, '2024-09-01', '2024-09-02'),
(15, 8, 16, 65.00, 'inactiva', 30, '2024-09-05', NULL),
(16, 9, 17, 100.00, 'activa', 55, '2024-09-10', '2024-09-10'),
(17, 10, 18, 75.00, 'activa', 40, '2024-09-12', '2024-09-13'),
(18, 1, 19, 85.00, 'activa', 45, '2024-01-20', '2024-01-20'),
(19, 2, 20, 90.00, 'activa', 50, '2024-02-25', '2024-02-26'),
(20, 3, 1, 60.00, 'inactiva', 30, '2024-03-30', NULL);


INSERT INTO ejercicio (tipo, contenido, respuesta_correcta, puntos_asignados)
VALUES
('selección múltiple','Traduce: "Hola"','Hello',10),
('verdadero/falso','Madrid es la capital de España','verdadero',5),
('completar','I ___ a teacher','am',8),
('relacionar','Casa - House','House',6),
('escribir','Escribe la palabra "Dog" en inglés','Dog',10),
('ordenar','Palabras: you / how / are','How are you',7),
('selección múltiple','¿Cuál es el plural de "mouse"?','mice',9),
('verdadero/falso','The sun rises in the west','falso',4),
('completar','She ___ running','is',8),
('relacionar','Agua - Water','Water',6),
('escribir','Traduce: "Perro"','Dog',10),
('ordenar','Palabras: name / is / My / Ana','My name is Ana',7),
('selección múltiple','¿Qué significa "book"?','libro',9),
('verdadero/falso','París está en Francia','verdadero',5),
('completar','They ___ playing soccer','are',8),
('relacionar','Gato - Cat','Cat',6),
('escribir','Traduce: "Gracias"','Thank you',10),
('ordenar','Palabras: color / favorite / my / is / blue','My favorite color is blue',7),
('selección múltiple','¿Cuál es el pasado de "go"?','went',9),
('verdadero/falso','Alemania está en Asia','falso',5);

INSERT INTO leccion_ejercicio (id_leccion, id_ejercicio, puntos_asignados)
VALUES
(1,1,10),
(1,2,5),
(2,3,8),
(3,4,6),
(4,5,10),
(5,6,7),
(6,7,9),
(7,8,4),
(8,9,8),
(9,10,6),
(10,11,10),
(11,12,7),
(12,13,9),
(13,14,5),
(14,15,8),
(15,16,6),
(16,17,10),
(17,18,7),
(18,19,9),
(19,20,5),
(20,1,10);


INSERT INTO liga (nombre, nivel, fecha_inicio)
VALUES
('Bronce', 'Inicial', '2024-01-01'),
('Plata', 'Básico', '2024-02-01'),
('Oro', 'Intermedio', '2024-03-01'),
('Zafiro', 'Avanzado', '2024-04-01'),
('Rubí', 'Experto', '2024-05-01'),
('Esmeralda', 'Competitivo', '2024-06-01'),
('Diamante', 'Élite', '2024-07-01'),
('Amatista', 'Avanzado', '2024-08-01'),
('Top 10', 'Élite', '2024-09-01'),
('Leyenda', 'Máximo', '2024-10-01');


INSERT INTO usuario_liga (id_usuario, id_liga, xp_ganado, ranking, fecha_inicio, fecha_fin, estado)
VALUES
(1,1,200,5,'2024-01-01',NULL,'compitiendo'),
(2,1,350,2,'2024-01-01',NULL,'ascendido'),
(3,2,400,3,'2024-02-01',NULL,'mantenido'),
(4,3,150,8,'2024-03-01',NULL,'descendido'),
(5,2,280,4,'2024-02-01',NULL,'compitiendo'),
(6,4,500,1,'2024-04-01',NULL,'ascendido'),
(7,1,100,10,'2024-01-01',NULL,'descendido'),
(8,5,450,2,'2024-05-01',NULL,'compitiendo'),
(9,3,320,5,'2024-03-01',NULL,'mantenido'),
(10,2,200,6,'2024-02-01',NULL,'compitiendo'),
(11,6,700,1,'2024-06-01',NULL,'ascendido'),
(12,1,120,9,'2024-01-01',NULL,'descendido'),
(13,4,380,3,'2024-04-01',NULL,'mantenido'),
(14,2,250,7,'2024-02-01',NULL,'compitiendo'),
(15,3,450,4,'2024-03-01',NULL,'ascendido'),
(16,5,500,2,'2024-05-01',NULL,'compitiendo'),
(17,6,600,1,'2024-06-01',NULL,'mantenido'),
(18,7,750,1,'2024-07-01',NULL,'ascendido'),
(19,8,800,1,'2024-08-01',NULL,'mantenido'),
(20,9,900,1,'2024-09-01',NULL,'ascendido');


INSERT INTO recompensa (tipo, descripcion, cantidad_base)
VALUES
('xp','Bonificación diaria',50),
('moneda','Premio semanal',100),
('insignia','Racha de 7 días',NULL),
('xp','Lección completada',20),
('moneda','Liga ganada',150),
('desbloqueo','Acceso a nueva habilidad',NULL),
('insignia','Lección perfecta',NULL),
('xp','Objetivo diario completado',30),
('moneda','Desafío completado',200),
('xp','Progreso de idioma',40);


INSERT INTO usuario_recompensa (id_usuario, id_recompensa, cantidad, fecha_obtencion)
VALUES
(1,1,1,CURRENT_DATE),
(2,2,1,CURRENT_DATE),
(3,3,1,CURRENT_DATE),
(4,4,2,CURRENT_DATE),
(5,5,1,CURRENT_DATE),
(6,1,3,CURRENT_DATE),
(7,2,2,CURRENT_DATE),
(8,3,1,CURRENT_DATE),
(9,4,2,CURRENT_DATE),
(10,5,1,CURRENT_DATE),
(11,6,1,CURRENT_DATE),
(12,7,2,CURRENT_DATE),
(13,8,1,CURRENT_DATE),
(14,9,1,CURRENT_DATE),
(15,10,1,CURRENT_DATE),
(16,1,2,CURRENT_DATE),
(17,2,1,CURRENT_DATE),
(18,3,2,CURRENT_DATE),
(19,4,3,CURRENT_DATE),
(20,5,1,CURRENT_DATE);


INSERT INTO racha (id_usuario, dias_consecutivos, fecha_inicio, fecha_fin)
VALUES
(1,10,'2024-09-01',NULL),
(2,5,'2024-09-05',NULL),
(3,15,'2024-08-20',NULL),
(4,7,'2024-09-10',NULL),
(5,12,'2024-09-03',NULL),
(6,9,'2024-09-07',NULL),
(7,20,'2024-08-15',NULL),
(8,4,'2024-09-12',NULL),
(9,6,'2024-09-09',NULL),
(10,3,'2024-09-15',NULL),
(11,11,'2024-09-01',NULL),
(12,14,'2024-08-25',NULL),
(13,18,'2024-08-10',NULL),
(14,2,'2024-09-18',NULL),
(15,1,'2024-09-19',NULL),
(16,16,'2024-08-22',NULL),
(17,8,'2024-09-08',NULL),
(18,5,'2024-09-13',NULL),
(19,9,'2024-09-06',NULL),
(20,13,'2024-08-30',NULL);


INSERT INTO notificacion (tipo, contenido)
VALUES
('recordatorio','¡No olvides tu práctica de hoy!'),
('logro','Has alcanzado una nueva racha'),
('promoción','Desbloquea nuevas lecciones con tus monedas'),
('alerta','Tu cuenta estuvo inactiva por 3 días'),
('mensaje','¡Felicitaciones por tu progreso!'),
('sistema','Actualización de mantenimiento'),
('recordatorio','Completa tu meta diaria'),
('logro','Has subido de liga'),
('promoción','Nuevo reto disponible esta semana'),
('mensaje','Revisa tus recompensas acumuladas');


INSERT INTO usuario_notificacion (id_usuario, id_notificacion, leida, canal, fecha_envio)
VALUES
(1,1,FALSE,'app',CURRENT_DATE),
(2,2,TRUE,'email',CURRENT_DATE),
(3,3,FALSE,'app',CURRENT_DATE),
(4,4,FALSE,'push',CURRENT_DATE),
(5,5,TRUE,'app',CURRENT_DATE),
(6,6,FALSE,'email',CURRENT_DATE),
(7,7,FALSE,'app',CURRENT_DATE),
(8,8,TRUE,'push',CURRENT_DATE),
(9,9,FALSE,'app',CURRENT_DATE),
(10,10,TRUE,'email',CURRENT_DATE),
(11,1,FALSE,'app',CURRENT_DATE),
(12,2,TRUE,'app',CURRENT_DATE),
(13,3,FALSE,'email',CURRENT_DATE),
(14,4,TRUE,'app',CURRENT_DATE),
(15,5,FALSE,'push',CURRENT_DATE),
(16,6,TRUE,'app',CURRENT_DATE),
(17,7,FALSE,'email',CURRENT_DATE),
(18,8,FALSE,'app',CURRENT_DATE),
(19,9,TRUE,'app',CURRENT_DATE),
(20,10,FALSE,'push',CURRENT_DATE);