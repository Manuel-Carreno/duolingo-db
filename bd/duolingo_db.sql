-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 24-11-2025 a las 19:35:23
-- Versión del servidor: 10.11.13-MariaDB-0ubuntu0.24.04.1
-- Versión de PHP: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `duolingo_db`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`duolingo_user`@`localhost` PROCEDURE `sp_completar_leccion` (IN `p_id_usuario` INT, IN `p_id_idioma` INT, IN `p_id_leccion` INT, IN `p_xp_leccion` INT)   BEGIN
  
  DECLARE v_recompensa_xp_id INT$$

CREATE DEFINER=`duolingo_user`@`localhost` PROCEDURE `sp_eliminar_usuario` (IN `p_id_usuario` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK$$

CREATE DEFINER=`duolingo_user`@`localhost` PROCEDURE `sp_sumar_xp_y_recompensa` (IN `p_id_usuario` INT, IN `p_id_idioma` INT, IN `p_xp_a_sumar` INT, IN `p_id_recompensa` INT)   BEGIN
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK$$

--
-- Funciones
--
CREATE DEFINER=`duolingo_user`@`localhost` FUNCTION `fn_total_xp_usuario` (`p_id_usuario` INT) RETURNS INT(11) DETERMINISTIC READS SQL DATA BEGIN
  
  DECLARE v_total INT$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ejercicio`
--

CREATE TABLE `ejercicio` (
  `id_ejercicio` int(11) NOT NULL,
  `tipo` enum('selección múltiple','verdadero/falso','completar','relacionar','escribir','ordenar') NOT NULL,
  `contenido` text DEFAULT NULL,
  `respuesta_correcta` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ejercicio`
--

INSERT INTO `ejercicio` (`id_ejercicio`, `tipo`, `contenido`, `respuesta_correcta`) VALUES
(1, 'selección múltiple', 'Traduce: \"Hola\"', 'Hello'),
(2, 'verdadero/falso', 'Madrid es la capital de España', 'verdadero'),
(3, 'completar', 'I ___ a teacher', 'am'),
(4, 'relacionar', 'Casa - House', 'House'),
(5, 'escribir', 'Escribe la palabra \"Dog\" en inglés', 'Dog'),
(6, 'ordenar', 'Palabras: you / how / are', 'How are you'),
(7, 'selección múltiple', '¿Cuál es el plural de \"mouse\"?', 'mice'),
(8, 'verdadero/falso', 'The sun rises in the west', 'falso'),
(9, 'completar', 'She ___ running', 'is'),
(10, 'relacionar', 'Agua - Water', 'Water'),
(11, 'escribir', 'Traduce: \"Perro\"', 'Dog'),
(12, 'ordenar', 'Palabras: name / is / My / Ana', 'My name is Ana'),
(13, 'selección múltiple', '¿Qué significa \"book\"?', 'libro'),
(14, 'verdadero/falso', 'París está en Francia', 'verdadero'),
(15, 'completar', 'They ___ playing soccer', 'are'),
(16, 'relacionar', 'Gato - Cat', 'Cat'),
(17, 'escribir', 'Traduce: \"Gracias\"', 'Thank you'),
(18, 'ordenar', 'Palabras: color / favorite / my / is / blue', 'My favorite color is blue'),
(19, 'selección múltiple', '¿Cuál es el pasado de \"go\"?', 'went'),
(20, 'verdadero/falso', 'Alemania está en Asia', 'falso'),
(21, 'selección múltiple', '¿Cómo se dice “La casa es grande” en holandés?\r\n\r\n1. Het huis is groot\r\n2. De huis is groot\r\n3. Het huis zijn groot\r\n4. Het huizen is groot', 'Het huis is groot '),
(22, 'verdadero/falso', 'María tiene un perro llamado Max. Cada mañana, Max corre en el parque mientras María lee un libro. ¿Qué hace María en el parque? \r\n1. Corre con Max\r\n2. Lee un libro\r\n3. Juega fútbol\r\n4. Compra comida', 'Lee un libro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `idioma`
--

CREATE TABLE `idioma` (
  `id_idioma` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `nivel_maximo` int(11) DEFAULT NULL,
  `codigo_iso` varchar(10) DEFAULT NULL,
  `fecha_adicion` date NOT NULL
) ;

--
-- Volcado de datos para la tabla `idioma`
--

INSERT INTO `idioma` (`id_idioma`, `nombre`, `nivel_maximo`, `codigo_iso`, `fecha_adicion`) VALUES
(1, 'Inglés', 10, 'EN', '2025-11-23'),
(2, 'Francés', 10, 'FR', '2025-11-23'),
(3, 'Alemán', 10, 'DE', '2025-11-23'),
(4, 'Italiano', 10, 'IT', '2025-11-23'),
(5, 'Portugués', 10, 'PT', '2025-11-23'),
(6, 'Ruso', 10, 'RU', '2025-11-23'),
(7, 'Japonés', 10, 'JP', '2025-11-23'),
(8, 'Coreano', 10, 'KR', '2025-11-23'),
(9, 'Chino', 10, 'ZH', '2025-11-23'),
(10, 'Sueco', 10, 'SE', '2025-11-23'),
(11, 'Noruego', 10, 'NO', '2025-11-23'),
(12, 'Danés', 10, 'DA', '2025-11-23'),
(13, 'Holandés', 10, 'NL', '2025-11-23'),
(14, 'Turco', 10, 'TR', '2025-11-23'),
(15, 'Árabe', 10, 'AR', '2025-11-23'),
(16, 'Hindi', 10, 'HI', '2025-11-23'),
(17, 'Griego', 10, 'GR', '2025-11-23'),
(18, 'Hebreo', 10, 'HE', '2025-11-23'),
(19, 'Polaco', 10, 'PL', '2025-11-23'),
(20, 'Catalán', 10, 'CA', '2025-11-23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `leccion`
--

CREATE TABLE `leccion` (
  `id_leccion` int(11) NOT NULL,
  `nivel` int(11) DEFAULT NULL,
  `dificultad` enum('baja','media','alta') NOT NULL,
  `tiempo_estimado` time DEFAULT NULL,
  `habilidad_enfocada` enum('gramática','vocabulario','escucha','lectura','escritura','pronunciación') NOT NULL
) ;

--
-- Volcado de datos para la tabla `leccion`
--

INSERT INTO `leccion` (`id_leccion`, `nivel`, `dificultad`, `tiempo_estimado`, `habilidad_enfocada`) VALUES
(1, 1, 'baja', '00:05:00', 'vocabulario'),
(2, 2, 'baja', '00:06:00', 'lectura'),
(3, 3, 'media', '00:08:00', 'gramática'),
(4, 4, 'media', '00:09:00', 'vocabulario'),
(5, 5, 'alta', '00:10:00', 'escucha'),
(6, 6, 'media', '00:07:30', 'lectura'),
(7, 7, 'alta', '00:10:30', 'escritura'),
(8, 8, 'media', '00:08:00', 'pronunciación'),
(9, 9, 'baja', '00:05:30', 'vocabulario'),
(10, 10, 'alta', '00:09:30', 'gramática'),
(11, 11, 'baja', '00:05:00', 'lectura'),
(12, 12, 'media', '00:08:15', 'escritura'),
(13, 13, 'alta', '00:10:15', 'pronunciación'),
(14, 14, 'media', '00:07:45', 'escucha'),
(15, 15, 'alta', '00:10:45', 'vocabulario'),
(16, 16, 'media', '00:08:30', 'lectura'),
(17, 17, 'baja', '00:06:30', 'vocabulario'),
(18, 18, 'media', '00:09:00', 'gramática'),
(19, 19, 'alta', '00:10:00', 'escucha'),
(20, 20, 'media', '00:07:15', 'escritura'),
(21, 3, 'media', '00:10:00', 'gramática'),
(22, 4, 'media', '09:00:00', 'lectura');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `leccion_ejercicio`
--

CREATE TABLE `leccion_ejercicio` (
  `id_leccion` int(11) NOT NULL,
  `id_ejercicio` int(11) NOT NULL,
  `puntos_asignados` int(11) NOT NULL
) ;

--
-- Volcado de datos para la tabla `leccion_ejercicio`
--

INSERT INTO `leccion_ejercicio` (`id_leccion`, `id_ejercicio`, `puntos_asignados`) VALUES
(1, 1, 10),
(1, 2, 5),
(2, 3, 8),
(3, 4, 6),
(4, 5, 10),
(5, 6, 7),
(6, 7, 9),
(7, 8, 4),
(8, 9, 8),
(9, 10, 6),
(10, 11, 10),
(11, 12, 7),
(12, 13, 9),
(13, 14, 5),
(14, 15, 8),
(15, 16, 6),
(16, 17, 10),
(17, 18, 7),
(18, 19, 9),
(19, 20, 5),
(20, 1, 10),
(21, 21, 30),
(22, 22, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `liga`
--

CREATE TABLE `liga` (
  `id_liga` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `nivel` varchar(20) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `liga`
--

INSERT INTO `liga` (`id_liga`, `nombre`, `nivel`, `fecha_inicio`) VALUES
(1, 'Bronce', 'Inicial', '2024-01-01'),
(2, 'Plata', 'Básico', '2024-02-01'),
(3, 'Oro', 'Intermedio', '2024-03-01'),
(4, 'Zafiro', 'Avanzado', '2024-04-01'),
(5, 'Rubí', 'Experto', '2024-05-01'),
(6, 'Esmeralda', 'Competitivo', '2024-06-01'),
(7, 'Diamante', 'Élite', '2024-07-01'),
(8, 'Amatista', 'Avanzado', '2024-08-01'),
(9, 'Top 10', 'Élite', '2024-09-01'),
(10, 'Leyenda', 'Máximo', '2024-10-01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacion`
--

CREATE TABLE `notificacion` (
  `id_notificacion` int(11) NOT NULL,
  `tipo` enum('sistema','recordatorio','logro','promoción','alerta','mensaje') NOT NULL,
  `contenido` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `notificacion`
--

INSERT INTO `notificacion` (`id_notificacion`, `tipo`, `contenido`) VALUES
(1, 'recordatorio', '¡No olvides tu práctica de hoy!'),
(2, 'logro', 'Has alcanzado una nueva racha'),
(3, 'promoción', 'Desbloquea nuevas lecciones con tus monedas'),
(4, 'alerta', 'Tu cuenta estuvo inactiva por 3 días'),
(5, 'mensaje', '¡Felicitaciones por tu progreso!'),
(6, 'sistema', 'Actualización de mantenimiento'),
(7, 'recordatorio', 'Completa tu meta diaria'),
(8, 'logro', 'Has subido de liga'),
(9, 'promoción', 'Nuevo reto disponible esta semana'),
(10, 'mensaje', 'Revisa tus recompensas acumuladas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `racha`
--

CREATE TABLE `racha` (
  `id_racha` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `dias_consecutivos` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `racha`
--

INSERT INTO `racha` (`id_racha`, `id_usuario`, `dias_consecutivos`, `fecha_inicio`, `fecha_fin`) VALUES
(1, 1, 10, '2024-09-01', NULL),
(2, 2, 5, '2024-09-05', NULL),
(3, 3, 15, '2024-08-20', NULL),
(4, 4, 7, '2024-09-10', NULL),
(5, 5, 12, '2024-09-03', NULL),
(6, 6, 9, '2024-09-07', NULL),
(7, 7, 20, '2024-08-15', NULL),
(8, 8, 4, '2024-09-12', NULL),
(9, 9, 6, '2024-09-09', NULL),
(10, 10, 3, '2024-09-15', NULL),
(11, 11, 11, '2024-09-01', NULL),
(12, 12, 14, '2024-08-25', NULL),
(13, 13, 18, '2024-08-10', NULL),
(14, 14, 2, '2024-09-18', NULL),
(15, 15, 1, '2024-09-19', NULL),
(16, 16, 16, '2024-08-22', NULL),
(17, 17, 8, '2024-09-08', NULL),
(18, 18, 5, '2024-09-13', NULL),
(19, 19, 9, '2024-09-06', NULL),
(20, 20, 13, '2024-08-30', NULL),
(21, 24, 30, '2025-11-04', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recompensa`
--

CREATE TABLE `recompensa` (
  `id_recompensa` int(11) NOT NULL,
  `tipo` enum('moneda','xp','insignia','desbloqueo') NOT NULL,
  `descripcion` text DEFAULT NULL,
  `cantidad_base` int(11) DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `recompensa`
--

INSERT INTO `recompensa` (`id_recompensa`, `tipo`, `descripcion`, `cantidad_base`) VALUES
(1, 'xp', 'Bonificación diaria', 50),
(2, 'moneda', 'Premio semanal', 100),
(3, 'insignia', 'Racha de 7 días', NULL),
(4, 'xp', 'Lección completada', 20),
(5, 'moneda', 'Liga ganada', 150),
(6, 'desbloqueo', 'Acceso a nueva habilidad', NULL),
(7, 'insignia', 'Lección perfecta', NULL),
(8, 'xp', 'Objetivo diario completado', 30),
(9, 'moneda', 'Desafío completado', 200),
(10, 'xp', 'Progreso de idioma', 40);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `primer_nombre` varchar(30) NOT NULL,
  `segundo_nombre` varchar(30) DEFAULT NULL,
  `primer_apellido` varchar(30) NOT NULL,
  `segundo_apellido` varchar(30) DEFAULT NULL,
  `correo` varchar(50) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `nacionalidad` varchar(50) DEFAULT NULL,
  `fecha_registro` date NOT NULL DEFAULT curdate()
) ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `correo`, `contrasena`, `avatar`, `nacionalidad`, `fecha_registro`) VALUES
(1, 'Ana', 'María', 'Gómez', 'López', 'ana@example.com', '$2y$10$u1JqZRm1d7gkM9XG07sfiOMoytR6wLh9kOeI1P2vKhxJ6gfr9bT4G', NULL, 'Colombia', '2025-11-23'),
(2, 'Juan', NULL, 'Pérez', 'Rodríguez', 'juanp@example.com', '$2y$10$w0KxvZr6bJq1zM5yQ9EjuuQ8xZpH0Xy2N6vFy1Pj7F0c/6JYq1t0K', NULL, 'México', '2025-11-23'),
(3, 'Laura', 'Sofía', 'Martínez', 'Díaz', 'laura@example.com', '$2y$10$R5u1ZJ9xk8WcK4Yq2N8hKeN3P0vF3zY1H9bS4wV6D7jT1eK6qP0Gq', NULL, 'Argentina', '2025-11-23'),
(4, 'Pedro', NULL, 'Ramírez', 'Castillo', 'pedro@example.com', '$2y$10$T1m9YxF2bQ4sW7K8vC2oUuJ5xZpF3aV1D6gH3yJ8N9mB0Q2R7pE6', NULL, 'Chile', '2025-11-23'),
(5, 'Camila', 'Andrea', 'Fernández', 'Vega', 'camila@example.com', '$2y$10$N0p8BzK1qR5wL6M7sT9yUvG4xPzH2eK1J6nW9vR4D3bC8Z7qF1eK', NULL, 'Perú', '2025-11-23'),
(6, 'Andrés', NULL, 'López', 'Ruiz', 'andres@example.com', '$2y$10$H3xR1D8vJ5nS2K6bW0yQvL9pZsH7tF4X1cJ5mR8N6yT2pK1eV7oQ', NULL, 'Colombia', '2025-11-23'),
(7, 'Valentina', 'Isabel', 'Torres', 'Moreno', 'valen@example.com', '$2y$10$F2vQ1H9pZ6kW4L5sT7bYvN3xG0dE1R5M6oJ3yP9K8nV4wC1eZ2xQ', NULL, 'Uruguay', '2025-11-23'),
(8, 'Carlos', 'Eduardo', 'Jiménez', 'Rojas', 'carlos@example.com', '$2y$10$K9wV1X6rB7cT2M8sQ3nHyP0vZ5kF4dJ1R6mS9oL2N7yU3eQ8tG1e', NULL, 'Ecuador', '2025-11-23'),
(9, 'María', 'Paula', 'Herrera', 'Pérez', 'maria@example.com', '$2y$10$D1jQ4K7sP9wX2R5tN3eYvB0xZ6kF8cH1M5pJ2nV7Q4sL9yT6eW3o', NULL, 'Bolivia', '2025-11-23'),
(10, 'David', 'Alejandro', 'Suárez', 'Martínez', 'david@example.com', '$2y$10$G4rH7Y2bQ1sL6T8nW3vKpX5xZ9dF0mJ2E6oN3yV7C1tP4eK9qR5o', NULL, 'España', '2025-11-23'),
(11, 'Sofía', 'Lucía', 'Reyes', 'Cano', 'sofia@example.com', '$2y$10$P2vF9K6bT1qM3W5xR8yNzJ0pZ7kL2sH4D9cV6nR1E5yT3wQ8oK4e', NULL, 'Colombia', '2025-11-23'),
(12, 'Daniel', NULL, 'Cruz', 'Pineda', 'daniel@example.com', '$2y$10$L3xQ7R2kV5bT8M1nS4yWvN6xZ0jF9cH2P5oJ1yR7K3eT4qC8vN2e', NULL, 'Argentina', '2025-11-23'),
(13, 'Gabriela', 'Fernanda', 'Morales', 'Santos', 'gaby@example.com', '$2y$10$M0sT6N3kR1bV8L5xQ2yPwH9zZ4dF7cJ1K5oN2yR8E3qT6wC9pQ4e', NULL, 'México', '2025-11-23'),
(14, 'Nicolás', 'Javier', 'Ortiz', 'García', 'nico@example.com', '$2y$10$V5kR2P8bJ1nS3M6tX9yWvN0xZ4dF7hJ2P5oN1yR8C3eT6qQ0vL2e', NULL, 'Chile', '2025-11-23'),
(15, 'Lucía', 'Estefanía', 'Rincón', 'Navarro', 'lucia@example.com', '$2y$10$C7pN1M5kR2bT8L3xQ0yWvH6xZ9dF2jJ1K5oN3yR7E4qT9wC6vP1e', NULL, 'Colombia', '2025-11-23'),
(16, 'Felipe', 'Andrés', 'Vargas', 'Salazar', 'felipe@example.com', '$2y$10$J2rK6P1bT4nS9M3xQ8yWvH0xZ5dF8cJ1P5oN2yR7E4tT9wC6qL1e', NULL, 'Ecuador', '2025-11-23'),
(17, 'Sara', NULL, 'Rojas', 'Pérez', 'sara@example.com', '$2y$10$T6kR1P4bJ9nS2M7tX3yWvN5xZ8dF1hJ2P5oN1yR8C3eT6qQ0vL2e', NULL, 'Perú', '2025-11-23'),
(18, 'Emilio', 'Andrés', 'Gómez', 'Luna', 'emilio@example.com', '$2y$10$B1pN5M2kR4bT8L3xQ0yWvH6xZ9dF2jJ1K5oN3yR7E4qT9wC6vP1e', NULL, 'Colombia', '2025-11-23'),
(19, 'Paula', 'Andrea', 'Cárdenas', 'Mora', 'paula@example.com', '$2y$10$H3rK7P1bT4nS8M2xQ9yWvH0xZ5dF8cJ1P5oN2yR7E4tT9wC6qL1e', NULL, 'Venezuela', '2025-11-23'),
(20, 'Esteban', 'David', 'Ramírez', 'Quintero', 'esteban@example.com', '$2y$10$D2kR6P1bJ3nS9M7tX4yWvN0xZ5dF8hJ2P5oN1yR8C3eT6qQ0vL2e', NULL, 'Uruguay', '2025-11-23'),
(21, 'Juanita', NULL, 'Paez', NULL, 'juani@email.com', '$2y$10$LWG9C0oGA8WyW1J4w0wJN.cFk.TFPU1zX9wwcm.4JQjgV5jRUUjsi', NULL, 'Chile', '2025-11-23'),
(23, 'Mia', NULL, 'Ruiz', NULL, 'krish@email.com', '$2y$10$PbcfX4D/Yz6aLF/ZBsfhPOtzBYXP441UqYsCBTe2N5ectonOqxegi', NULL, 'Argentina', '2025-11-24'),
(24, 'Marisol', NULL, 'Jaime', NULL, 'kris@email.com', '$2y$10$vhHRLHWaKGMPZfqBxIqhTe/H75GmR.x3l22x2p8PeC4mH7yiQew2.', NULL, 'Argentina', '2025-11-24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_idioma`
--

CREATE TABLE `usuario_idioma` (
  `id_usuario` int(11) NOT NULL,
  `id_idioma` int(11) NOT NULL,
  `estado` enum('aprendiendo','completado','inactivo','abandonado') NOT NULL,
  `ranking` int(11) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `xp_acumulado` int(11) NOT NULL
) ;

--
-- Volcado de datos para la tabla `usuario_idioma`
--

INSERT INTO `usuario_idioma` (`id_usuario`, `id_idioma`, `estado`, `ranking`, `fecha_inicio`, `fecha_fin`, `xp_acumulado`) VALUES
(1, 1, 'aprendiendo', 10, '2024-01-10', NULL, 550),
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
(12, 7, 'aprendiendo', NULL, '2025-11-24', NULL, 0),
(13, 6, 'completado', 7, '2024-08-10', '2024-09-10', 1100),
(14, 7, 'aprendiendo', 30, '2024-09-01', NULL, 800),
(15, 8, 'inactivo', NULL, '2024-09-05', NULL, 250),
(16, 9, 'aprendiendo', 16, '2024-09-10', NULL, 450),
(17, 10, 'aprendiendo', 19, '2024-09-12', NULL, 300),
(18, 1, 'completado', 6, '2024-01-15', '2024-06-15', 1200),
(19, 2, 'aprendiendo', 21, '2024-02-20', NULL, 550),
(20, 3, 'inactivo', NULL, '2024-03-25', NULL, 100),
(21, 13, 'aprendiendo', NULL, '2025-11-23', NULL, 65),
(23, 10, 'aprendiendo', NULL, '2025-11-24', NULL, 0),
(24, 18, 'aprendiendo', NULL, '2025-11-24', NULL, 60);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_idioma_leccion`
--

CREATE TABLE `usuario_idioma_leccion` (
  `id_usuario` int(11) NOT NULL,
  `id_idioma` int(11) NOT NULL,
  `id_leccion` int(11) NOT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL,
  `estado` enum('activa','inactiva','obsoleta') NOT NULL,
  `xp_obtenido` int(11) DEFAULT NULL,
  `fecha_asignacion` date DEFAULT NULL,
  `fecha_activacion` date DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `usuario_idioma_leccion`
--

INSERT INTO `usuario_idioma_leccion` (`id_usuario`, `id_idioma`, `id_leccion`, `porcentaje`, `estado`, `xp_obtenido`, `fecha_asignacion`, `fecha_activacion`) VALUES
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
(20, 3, 1, 60.00, 'inactiva', 30, '2024-03-30', NULL),
(21, 13, 21, 100.00, 'activa', 60, '2025-11-11', '2025-11-06'),
(24, 18, 5, 60.00, 'activa', 20, '2025-11-01', '2025-11-02'),
(24, 18, 22, 30.00, 'activa', 40, '2025-11-06', '2025-11-02');

--
-- Disparadores `usuario_idioma_leccion`
--
DELIMITER $$
CREATE TRIGGER `trg_usuario_idioma_leccion_ai` AFTER INSERT ON `usuario_idioma_leccion` FOR EACH ROW BEGIN
  
  IF NEW.xp_obtenido IS NOT NULL THEN
    UPDATE usuario_idioma
    SET xp_acumulado = xp_acumulado + NEW.xp_obtenido
    WHERE id_usuario = NEW.id_usuario
      AND id_idioma  = NEW.id_idioma$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_liga`
--

CREATE TABLE `usuario_liga` (
  `id_usuario` int(11) NOT NULL,
  `id_liga` int(11) NOT NULL,
  `xp_ganado` int(11) NOT NULL,
  `ranking` int(11) DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `estado` enum('compitiendo','ascendido','descendido','mantenido') DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `usuario_liga`
--

INSERT INTO `usuario_liga` (`id_usuario`, `id_liga`, `xp_ganado`, `ranking`, `fecha_inicio`, `fecha_fin`, `estado`) VALUES
(1, 1, 200, 5, '2024-01-01', NULL, 'compitiendo'),
(2, 1, 350, 2, '2024-01-01', NULL, 'ascendido'),
(3, 2, 400, 3, '2024-02-01', NULL, 'mantenido'),
(4, 3, 150, 8, '2024-03-01', NULL, 'descendido'),
(5, 2, 280, 4, '2024-02-01', NULL, 'compitiendo'),
(6, 4, 500, 1, '2024-04-01', NULL, 'ascendido'),
(7, 1, 100, 10, '2024-01-01', NULL, 'descendido'),
(8, 5, 450, 2, '2024-05-01', NULL, 'compitiendo'),
(9, 3, 320, 5, '2024-03-01', NULL, 'mantenido'),
(10, 2, 200, 6, '2024-02-01', NULL, 'compitiendo'),
(11, 6, 700, 1, '2024-06-01', NULL, 'ascendido'),
(12, 1, 120, 9, '2024-01-01', NULL, 'descendido'),
(13, 4, 380, 3, '2024-04-01', NULL, 'mantenido'),
(14, 2, 250, 7, '2024-02-01', NULL, 'compitiendo'),
(15, 3, 450, 4, '2024-03-01', NULL, 'ascendido'),
(16, 5, 500, 2, '2024-05-01', NULL, 'compitiendo'),
(17, 6, 600, 1, '2024-06-01', NULL, 'mantenido'),
(18, 7, 750, 1, '2024-07-01', NULL, 'ascendido'),
(19, 8, 800, 1, '2024-08-01', NULL, 'mantenido'),
(20, 9, 900, 1, '2024-09-01', NULL, 'ascendido'),
(21, 3, 0, 21, '2025-11-24', NULL, 'compitiendo'),
(24, 4, 0, NULL, '2025-11-24', NULL, 'compitiendo'),
(24, 9, 0, 6, '2025-11-04', '2025-11-09', 'compitiendo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_notificacion`
--

CREATE TABLE `usuario_notificacion` (
  `id_usuario` int(11) NOT NULL,
  `id_notificacion` int(11) NOT NULL,
  `leida` tinyint(1) NOT NULL DEFAULT 0,
  `canal` enum('email','app','push') DEFAULT NULL,
  `fecha_envio` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario_notificacion`
--

INSERT INTO `usuario_notificacion` (`id_usuario`, `id_notificacion`, `leida`, `canal`, `fecha_envio`) VALUES
(1, 1, 0, 'app', '2025-11-23'),
(2, 2, 1, 'email', '2025-11-23'),
(3, 3, 0, 'app', '2025-11-23'),
(4, 4, 0, 'push', '2025-11-23'),
(5, 5, 1, 'app', '2025-11-23'),
(6, 6, 0, 'email', '2025-11-23'),
(7, 7, 0, 'app', '2025-11-23'),
(8, 8, 1, 'push', '2025-11-23'),
(9, 9, 0, 'app', '2025-11-23'),
(10, 10, 1, 'email', '2025-11-23'),
(11, 1, 0, 'app', '2025-11-23'),
(12, 2, 1, 'app', '2025-11-23'),
(13, 3, 0, 'email', '2025-11-23'),
(14, 4, 1, 'app', '2025-11-23'),
(15, 5, 0, 'push', '2025-11-23'),
(16, 6, 1, 'app', '2025-11-23'),
(17, 7, 0, 'email', '2025-11-23'),
(18, 8, 0, 'app', '2025-11-23'),
(19, 9, 1, 'app', '2025-11-23'),
(20, 10, 0, 'push', '2025-11-23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_recompensa`
--

CREATE TABLE `usuario_recompensa` (
  `id_usuario` int(11) NOT NULL,
  `id_recompensa` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT 0,
  `fecha_obtencion` date NOT NULL
) ;

--
-- Volcado de datos para la tabla `usuario_recompensa`
--

INSERT INTO `usuario_recompensa` (`id_usuario`, `id_recompensa`, `cantidad`, `fecha_obtencion`) VALUES
(1, 1, 1, '2025-11-23'),
(1, 2, 1, '2025-11-23'),
(2, 2, 1, '2025-11-23'),
(3, 3, 1, '2025-11-23'),
(4, 4, 2, '2025-11-23'),
(5, 5, 1, '2025-11-23'),
(6, 1, 3, '2025-11-23'),
(7, 2, 2, '2025-11-23'),
(8, 3, 1, '2025-11-23'),
(9, 4, 2, '2025-11-23'),
(10, 5, 1, '2025-11-23'),
(11, 6, 1, '2025-11-23'),
(12, 7, 2, '2025-11-23'),
(13, 8, 1, '2025-11-23'),
(14, 9, 1, '2025-11-23'),
(15, 10, 1, '2025-11-23'),
(16, 1, 2, '2025-11-23'),
(17, 2, 1, '2025-11-23'),
(18, 3, 2, '2025-11-23'),
(19, 4, 3, '2025-11-23'),
(20, 5, 1, '2025-11-23'),
(21, 3, 1, '2025-11-23'),
(21, 4, 1, '2025-11-23'),
(24, 2, 2, '2025-11-03'),
(24, 3, 1, '2025-11-06');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_competencia_liga`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_competencia_liga` (
`id_usuario` int(11)
,`usuario` varchar(61)
,`id_liga` int(11)
,`liga` varchar(30)
,`xp_ganado` int(11)
,`ranking` int(11)
,`estado` enum('compitiendo','ascendido','descendido','mantenido')
,`fecha_inicio` date
,`fecha_fin` date
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_progreso_lecciones`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_progreso_lecciones` (
`id_usuario` int(11)
,`id_idioma` int(11)
,`idioma` varchar(30)
,`id_leccion` int(11)
,`nivel` int(11)
,`porcentaje` decimal(5,2)
,`estado` enum('activa','inactiva','obsoleta')
,`xp_obtenido` int(11)
,`fecha_asignacion` date
,`fecha_activacion` date
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_racha_actual`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_racha_actual` (
`id_usuario` int(11)
,`dias_consecutivos` int(11)
,`fecha_inicio` date
,`fecha_fin` date
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_ranking_xp_por_idioma`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_ranking_xp_por_idioma` (
`id_idioma` int(11)
,`idioma` varchar(30)
,`id_usuario` int(11)
,`usuario` varchar(61)
,`xp_acumulado` int(11)
,`posicion` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_resumen_admin`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_resumen_admin` (
`id_usuario` int(11)
,`nombre` varchar(61)
,`idiomas_totales` bigint(21)
,`idiomas_activos` bigint(21)
,`xp_total` decimal(32,0)
,`mejor_racha` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_usuario_dashboard`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_usuario_dashboard` (
`id_usuario` int(11)
,`nombre` varchar(61)
,`xp_total` decimal(32,0)
,`racha_actual` int(11)
,`idiomas_activos` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_usuario_perfil`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_usuario_perfil` (
`id_usuario` int(11)
,`nombre_completo` varchar(61)
,`correo` varchar(50)
,`nacionalidad` varchar(50)
,`avatar` varchar(100)
,`id_idioma` int(11)
,`idioma` varchar(30)
,`estado_aprendizaje` enum('aprendiendo','completado','inactivo','abandonado')
,`ranking` int(11)
,`xp_acumulado` int(11)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_competencia_liga`
--
DROP TABLE IF EXISTS `vw_competencia_liga`;

CREATE ALGORITHM=UNDEFINED DEFINER=`duolingo_user`@`localhost` SQL SECURITY DEFINER VIEW `vw_competencia_liga`  AS SELECT `ul`.`id_usuario` AS `id_usuario`, concat(`u`.`primer_nombre`,' ',`u`.`primer_apellido`) AS `usuario`, `ul`.`id_liga` AS `id_liga`, `l`.`nombre` AS `liga`, `ul`.`xp_ganado` AS `xp_ganado`, `ul`.`ranking` AS `ranking`, `ul`.`estado` AS `estado`, `ul`.`fecha_inicio` AS `fecha_inicio`, `ul`.`fecha_fin` AS `fecha_fin` FROM ((`usuario_liga` `ul` join `usuario` `u` on(`ul`.`id_usuario` = `u`.`id_usuario`)) join `liga` `l` on(`ul`.`id_liga` = `l`.`id_liga`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_progreso_lecciones`
--
DROP TABLE IF EXISTS `vw_progreso_lecciones`;

CREATE ALGORITHM=UNDEFINED DEFINER=`duolingo_user`@`localhost` SQL SECURITY DEFINER VIEW `vw_progreso_lecciones`  AS SELECT `uil`.`id_usuario` AS `id_usuario`, `uil`.`id_idioma` AS `id_idioma`, `i`.`nombre` AS `idioma`, `uil`.`id_leccion` AS `id_leccion`, `l`.`nivel` AS `nivel`, `uil`.`porcentaje` AS `porcentaje`, `uil`.`estado` AS `estado`, `uil`.`xp_obtenido` AS `xp_obtenido`, `uil`.`fecha_asignacion` AS `fecha_asignacion`, `uil`.`fecha_activacion` AS `fecha_activacion` FROM ((`usuario_idioma_leccion` `uil` join `idioma` `i` on(`uil`.`id_idioma` = `i`.`id_idioma`)) join `leccion` `l` on(`uil`.`id_leccion` = `l`.`id_leccion`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_racha_actual`
--
DROP TABLE IF EXISTS `vw_racha_actual`;

CREATE ALGORITHM=UNDEFINED DEFINER=`duolingo_user`@`localhost` SQL SECURITY DEFINER VIEW `vw_racha_actual`  AS SELECT `r`.`id_usuario` AS `id_usuario`, `r`.`dias_consecutivos` AS `dias_consecutivos`, `r`.`fecha_inicio` AS `fecha_inicio`, `r`.`fecha_fin` AS `fecha_fin` FROM `racha` AS `r` WHERE `r`.`fecha_fin` is null ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_ranking_xp_por_idioma`
--
DROP TABLE IF EXISTS `vw_ranking_xp_por_idioma`;

CREATE ALGORITHM=UNDEFINED DEFINER=`duolingo_user`@`localhost` SQL SECURITY DEFINER VIEW `vw_ranking_xp_por_idioma`  AS SELECT `ui`.`id_idioma` AS `id_idioma`, `i`.`nombre` AS `idioma`, `ui`.`id_usuario` AS `id_usuario`, concat(`u`.`primer_nombre`,' ',`u`.`primer_apellido`) AS `usuario`, `ui`.`xp_acumulado` AS `xp_acumulado`, rank()  ( partition by `ui`.`id_idioma` order by `ui`.`xp_acumulado` desc) AS `over` FROM ((`usuario_idioma` `ui` join `idioma` `i` on(`ui`.`id_idioma` = `i`.`id_idioma`)) join `usuario` `u` on(`ui`.`id_usuario` = `u`.`id_usuario`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_resumen_admin`
--
DROP TABLE IF EXISTS `vw_resumen_admin`;

CREATE ALGORITHM=UNDEFINED DEFINER=`duolingo_user`@`localhost` SQL SECURITY DEFINER VIEW `vw_resumen_admin`  AS SELECT `u`.`id_usuario` AS `id_usuario`, concat(`u`.`primer_nombre`,' ',`u`.`primer_apellido`) AS `nombre`, (select count(0) from `usuario_idioma` `ui` where `ui`.`id_usuario` = `u`.`id_usuario`) AS `idiomas_totales`, (select count(0) from `usuario_idioma` `ui` where `ui`.`id_usuario` = `u`.`id_usuario` and `ui`.`estado` = 'aprendiendo') AS `idiomas_activos`, (select sum(`ui`.`xp_acumulado`) from `usuario_idioma` `ui` where `ui`.`id_usuario` = `u`.`id_usuario`) AS `xp_total`, (select max(`r`.`dias_consecutivos`) from `racha` `r` where `r`.`id_usuario` = `u`.`id_usuario`) AS `mejor_racha` FROM `usuario` AS `u` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_usuario_dashboard`
--
DROP TABLE IF EXISTS `vw_usuario_dashboard`;

CREATE ALGORITHM=UNDEFINED DEFINER=`duolingo_user`@`localhost` SQL SECURITY DEFINER VIEW `vw_usuario_dashboard`  AS SELECT `u`.`id_usuario` AS `id_usuario`, concat(`u`.`primer_nombre`,' ',`u`.`primer_apellido`) AS `nombre`, (select sum(`ui2`.`xp_acumulado`) from `usuario_idioma` `ui2` where `ui2`.`id_usuario` = `u`.`id_usuario`) AS `xp_total`, (select `r`.`dias_consecutivos` from `racha` `r` where `r`.`id_usuario` = `u`.`id_usuario` and `r`.`fecha_fin` is null limit 1) AS `racha_actual`, (select count(0) from `usuario_idioma` `ui3` where `ui3`.`id_usuario` = `u`.`id_usuario` and `ui3`.`estado` = 'aprendiendo') AS `idiomas_activos` FROM `usuario` AS `u` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_usuario_perfil`
--
DROP TABLE IF EXISTS `vw_usuario_perfil`;

CREATE ALGORITHM=UNDEFINED DEFINER=`duolingo_user`@`localhost` SQL SECURITY DEFINER VIEW `vw_usuario_perfil`  AS SELECT `u`.`id_usuario` AS `id_usuario`, concat(`u`.`primer_nombre`,' ',`u`.`primer_apellido`) AS `nombre_completo`, `u`.`correo` AS `correo`, `u`.`nacionalidad` AS `nacionalidad`, `u`.`avatar` AS `avatar`, `ui`.`id_idioma` AS `id_idioma`, `i`.`nombre` AS `idioma`, `ui`.`estado` AS `estado_aprendizaje`, `ui`.`ranking` AS `ranking`, `ui`.`xp_acumulado` AS `xp_acumulado` FROM ((`usuario` `u` left join `usuario_idioma` `ui` on(`u`.`id_usuario` = `ui`.`id_usuario`)) left join `idioma` `i` on(`ui`.`id_idioma` = `i`.`id_idioma`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ejercicio`
--
ALTER TABLE `ejercicio`
  ADD PRIMARY KEY (`id_ejercicio`);

--
-- Indices de la tabla `idioma`
--
ALTER TABLE `idioma`
  ADD PRIMARY KEY (`id_idioma`),
  ADD UNIQUE KEY `uq_idioma_nombre` (`nombre`),
  ADD KEY `idx_idioma_nombre` (`nombre`);

--
-- Indices de la tabla `leccion`
--
ALTER TABLE `leccion`
  ADD PRIMARY KEY (`id_leccion`),
  ADD KEY `idx_leccion_nivel` (`nivel`);

--
-- Indices de la tabla `leccion_ejercicio`
--
ALTER TABLE `leccion_ejercicio`
  ADD PRIMARY KEY (`id_leccion`,`id_ejercicio`),
  ADD KEY `idx_leccion_ejercicio_leccion` (`id_leccion`),
  ADD KEY `idx_leccion_ejercicio_ejercicio` (`id_ejercicio`);

--
-- Indices de la tabla `liga`
--
ALTER TABLE `liga`
  ADD PRIMARY KEY (`id_liga`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD KEY `idx_liga_nombre` (`nombre`);

--
-- Indices de la tabla `notificacion`
--
ALTER TABLE `notificacion`
  ADD PRIMARY KEY (`id_notificacion`),
  ADD KEY `idx_notificacion_tipo` (`tipo`);

--
-- Indices de la tabla `racha`
--
ALTER TABLE `racha`
  ADD PRIMARY KEY (`id_racha`),
  ADD KEY `idx_racha_usuario` (`id_usuario`);

--
-- Indices de la tabla `recompensa`
--
ALTER TABLE `recompensa`
  ADD PRIMARY KEY (`id_recompensa`),
  ADD KEY `idx_recompensa_tipo` (`tipo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `uq_usuario_correo` (`correo`),
  ADD KEY `idx_usuario_correo` (`correo`);

--
-- Indices de la tabla `usuario_idioma`
--
ALTER TABLE `usuario_idioma`
  ADD PRIMARY KEY (`id_usuario`,`id_idioma`),
  ADD KEY `idx_usuario_idioma_usuario` (`id_usuario`),
  ADD KEY `idx_usuario_idioma_idioma` (`id_idioma`);

--
-- Indices de la tabla `usuario_idioma_leccion`
--
ALTER TABLE `usuario_idioma_leccion`
  ADD PRIMARY KEY (`id_usuario`,`id_idioma`,`id_leccion`),
  ADD KEY `idx_usuario_leccion_usuario` (`id_usuario`),
  ADD KEY `idx_usuario_leccion_idioma` (`id_idioma`),
  ADD KEY `idx_usuario_leccion_leccion` (`id_leccion`);

--
-- Indices de la tabla `usuario_liga`
--
ALTER TABLE `usuario_liga`
  ADD PRIMARY KEY (`id_usuario`,`id_liga`),
  ADD KEY `idx_usuario_liga_usuario` (`id_usuario`),
  ADD KEY `idx_usuario_liga_liga` (`id_liga`);

--
-- Indices de la tabla `usuario_notificacion`
--
ALTER TABLE `usuario_notificacion`
  ADD PRIMARY KEY (`id_usuario`,`id_notificacion`),
  ADD KEY `idx_usuario_notif_usuario` (`id_usuario`),
  ADD KEY `idx_usuario_notif_notificacion` (`id_notificacion`);

--
-- Indices de la tabla `usuario_recompensa`
--
ALTER TABLE `usuario_recompensa`
  ADD PRIMARY KEY (`id_usuario`,`id_recompensa`),
  ADD KEY `idx_usuario_recompensa_usuario` (`id_usuario`),
  ADD KEY `idx_usuario_recompensa_recompensa` (`id_recompensa`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ejercicio`
--
ALTER TABLE `ejercicio`
  MODIFY `id_ejercicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `idioma`
--
ALTER TABLE `idioma`
  MODIFY `id_idioma` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `leccion`
--
ALTER TABLE `leccion`
  MODIFY `id_leccion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `liga`
--
ALTER TABLE `liga`
  MODIFY `id_liga` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificacion`
--
ALTER TABLE `notificacion`
  MODIFY `id_notificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `racha`
--
ALTER TABLE `racha`
  MODIFY `id_racha` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `recompensa`
--
ALTER TABLE `recompensa`
  MODIFY `id_recompensa` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `leccion_ejercicio`
--
ALTER TABLE `leccion_ejercicio`
  ADD CONSTRAINT `fk_le_ejercicio` FOREIGN KEY (`id_ejercicio`) REFERENCES `ejercicio` (`id_ejercicio`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_le_leccion` FOREIGN KEY (`id_leccion`) REFERENCES `leccion` (`id_leccion`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `racha`
--
ALTER TABLE `racha`
  ADD CONSTRAINT `fk_racha_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario_idioma`
--
ALTER TABLE `usuario_idioma`
  ADD CONSTRAINT `fk_ui_idioma` FOREIGN KEY (`id_idioma`) REFERENCES `idioma` (`id_idioma`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ui_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario_idioma_leccion`
--
ALTER TABLE `usuario_idioma_leccion`
  ADD CONSTRAINT `fk_uil_idioma` FOREIGN KEY (`id_idioma`) REFERENCES `idioma` (`id_idioma`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_uil_leccion` FOREIGN KEY (`id_leccion`) REFERENCES `leccion` (`id_leccion`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_uil_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario_liga`
--
ALTER TABLE `usuario_liga`
  ADD CONSTRAINT `fk_ul_liga` FOREIGN KEY (`id_liga`) REFERENCES `liga` (`id_liga`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ul_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario_notificacion`
--
ALTER TABLE `usuario_notificacion`
  ADD CONSTRAINT `fk_un_notificacion` FOREIGN KEY (`id_notificacion`) REFERENCES `notificacion` (`id_notificacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_un_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario_recompensa`
--
ALTER TABLE `usuario_recompensa`
  ADD CONSTRAINT `fk_ur_recompensa` FOREIGN KEY (`id_recompensa`) REFERENCES `recompensa` (`id_recompensa`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ur_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
