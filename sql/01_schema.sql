-- ==== CREAR TABLAS ====

mysql -u duolingo_user -p
USE duolingo_db;

CREATE OR REPLACE TABLE usuario (
  id_usuario INT AUTO_INCREMENT,
  primer_nombre VARCHAR(30) NOT NULL,
  segundo_nombre VARCHAR(30),
  primer_apellido VARCHAR(30) NOT NULL,
  segundo_apellido VARCHAR(30),
  correo VARCHAR(50) NOT NULL,
  contrasena VARCHAR(255) NOT NULL,
  avatar VARCHAR(100),
  nacionalidad VARCHAR(50),
  fecha_registro DATE NOT NULL DEFAULT (CURRENT_DATE),
  
  CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),
  CONSTRAINT uq_usuario_correo UNIQUE (correo),
  CONSTRAINT chk_usuario_primer_nombre CHECK (primer_nombre <> ''),
  CONSTRAINT chk_usuario_primer_apellido CHECK (primer_apellido <> ''),
  CONSTRAINT chk_usuario_correo CHECK (correo REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')
) ENGINE=InnoDB;

CREATE INDEX idx_usuario_correo ON usuario(correo);


CREATE OR REPLACE TABLE racha (
  id_racha INT AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  dias_consecutivos INT NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE,
  
  CONSTRAINT pk_racha PRIMARY KEY (id_racha),
  CONSTRAINT fk_racha_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT chk_racha_dias CHECK (dias_consecutivos >= 0),
  CONSTRAINT chk_racha_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
) ENGINE=InnoDB;

CREATE INDEX idx_racha_usuario ON racha(id_usuario);


CREATE OR REPLACE TABLE liga (
  id_liga INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL UNIQUE,
  nivel VARCHAR(20),
  fecha_inicio DATE,
  CHECK (nombre <> '')
);

CREATE INDEX idx_liga_nombre ON liga(nombre);


CREATE OR REPLACE TABLE usuario_liga (
  id_usuario INT NOT NULL,
  id_liga INT NOT NULL,
  xp_ganado INT NOT NULL,
  ranking INT,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE,
  estado ENUM('compitiendo','ascendido','descendido','mantenido'),
  
  CONSTRAINT pk_usuario_liga PRIMARY KEY (id_usuario, id_liga),
  CONSTRAINT fk_ul_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ul_liga FOREIGN KEY (id_liga)
    REFERENCES liga(id_liga)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT chk_ul_xp CHECK (xp_ganado >= 0),
  CONSTRAINT chk_ul_ranking CHECK (ranking IS NULL OR ranking > 0),
  CONSTRAINT chk_ul_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
) ENGINE=InnoDB;

CREATE INDEX idx_usuario_liga_usuario ON usuario_liga(id_usuario);
CREATE INDEX idx_usuario_liga_liga ON usuario_liga(id_liga);


CREATE OR REPLACE TABLE idioma (
  id_idioma INT AUTO_INCREMENT,
  nombre VARCHAR(30) NOT NULL,
  nivel_maximo INT,
  codigo_iso VARCHAR(10),
  fecha_adicion DATE NOT NULL,
  
  CONSTRAINT pk_idioma PRIMARY KEY (id_idioma),
  CONSTRAINT uq_idioma_nombre UNIQUE (nombre),
  CONSTRAINT chk_idioma_nombre CHECK (nombre <> '')
) ENGINE=InnoDB;

CREATE INDEX idx_idioma_nombre ON idioma(nombre);


CREATE OR REPLACE TABLE usuario_idioma (
  id_usuario INT NOT NULL,
  id_idioma INT NOT NULL,
  estado ENUM('aprendiendo','completado','inactivo','abandonado') NOT NULL,
  ranking INT,
  fecha_inicio DATE,
  fecha_fin DATE,
  xp_acumulado INT NOT NULL,
  
  CONSTRAINT pk_usuario_idioma PRIMARY KEY (id_usuario, id_idioma),
  CONSTRAINT fk_ui_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ui_idioma FOREIGN KEY (id_idioma)
    REFERENCES idioma(id_idioma)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT chk_ui_xp CHECK (xp_acumulado >= 0),
  CONSTRAINT chk_ui_ranking CHECK (ranking IS NULL OR ranking >= 0),
  CONSTRAINT chk_ui_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
) ENGINE=InnoDB;

CREATE INDEX idx_usuario_idioma_usuario ON usuario_idioma(id_usuario);
CREATE INDEX idx_usuario_idioma_idioma ON usuario_idioma(id_idioma);


CREATE OR REPLACE TABLE leccion (
  id_leccion INT AUTO_INCREMENT,
  nivel INT,
  dificultad ENUM('baja','media','alta') NOT NULL,
  tiempo_estimado TIME,
  habilidad_enfocada ENUM('gramática','vocabulario','escucha','lectura','escritura','pronunciación') NOT NULL,
  
  CONSTRAINT pk_leccion PRIMARY KEY (id_leccion),
  CONSTRAINT chk_leccion_nivel CHECK (nivel IS NULL OR nivel >= 1)
) ENGINE=InnoDB;

CREATE INDEX idx_leccion_nivel ON leccion(nivel);


CREATE OR REPLACE TABLE ejercicio (
  id_ejercicio INT AUTO_INCREMENT,
  tipo ENUM('selección múltiple','verdadero/falso','completar','relacionar','escribir','ordenar') NOT NULL,
  contenido TEXT,
  respuesta_correcta TEXT,
  puntos_asignados INT,
  
  CONSTRAINT pk_ejercicio PRIMARY KEY (id_ejercicio),
  CONSTRAINT chk_ejercicio_puntos CHECK (puntos_asignados >= 0)
) ENGINE=InnoDB;

CREATE INDEX idx_ejercicio_puntos ON ejercicio(puntos_asignados);


CREATE OR REPLACE TABLE usuario_idioma_leccion (
  id_usuario INT NOT NULL,
  id_idioma INT NOT NULL,
  id_leccion INT NOT NULL,
  porcentaje DECIMAL(5,2),
  estado ENUM('activa','inactiva','obsoleta') NOT NULL,
  xp_obtenido INT,
  fecha_asignacion DATE,
  fecha_activacion DATE,
  
  CONSTRAINT pk_usuario_idioma_leccion PRIMARY KEY (id_usuario, id_idioma, id_leccion),
  CONSTRAINT fk_uil_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_uil_idioma FOREIGN KEY (id_idioma)
    REFERENCES idioma(id_idioma)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_uil_leccion FOREIGN KEY (id_leccion)
    REFERENCES leccion(id_leccion)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT chk_uil_porcentaje CHECK (porcentaje >= 0 AND porcentaje <= 100),
  CONSTRAINT chk_uil_xp CHECK (xp_obtenido IS NULL OR xp_obtenido >= 0)
) ENGINE=InnoDB;

CREATE INDEX idx_usuario_leccion_usuario ON usuario_idioma_leccion(id_usuario);
CREATE INDEX idx_usuario_leccion_idioma ON usuario_idioma_leccion(id_idioma);
CREATE INDEX idx_usuario_leccion_leccion ON usuario_idioma_leccion(id_leccion);


CREATE OR REPLACE TABLE leccion_ejercicio (
  id_leccion INT NOT NULL,
  id_ejercicio INT NOT NULL,
  puntos_asignados INT NOT NULL,
  
  CONSTRAINT pk_leccion_ejercicio PRIMARY KEY (id_leccion, id_ejercicio),
  CONSTRAINT fk_le_leccion FOREIGN KEY (id_leccion)
    REFERENCES leccion(id_leccion)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_le_ejercicio FOREIGN KEY (id_ejercicio)
    REFERENCES ejercicio(id_ejercicio)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT chk_le_puntos CHECK (puntos_asignados >= 0)
) ENGINE=InnoDB;

CREATE INDEX idx_leccion_ejercicio_leccion ON leccion_ejercicio(id_leccion);
CREATE INDEX idx_leccion_ejercicio_ejercicio ON leccion_ejercicio(id_ejercicio);


CREATE OR REPLACE TABLE notificacion (
  id_notificacion INT AUTO_INCREMENT,
  tipo ENUM('sistema','recordatorio','logro','promoción','alerta','mensaje') NOT NULL,
  contenido TEXT,
  
  CONSTRAINT pk_notificacion PRIMARY KEY (id_notificacion)
) ENGINE=InnoDB;

CREATE INDEX idx_notificacion_tipo ON notificacion(tipo);


CREATE OR REPLACE TABLE usuario_notificacion (
  id_usuario INT NOT NULL,
  id_notificacion INT NOT NULL,
  leida BOOLEAN NOT NULL DEFAULT FALSE,
  canal ENUM('email','app','push'),
  fecha_envio DATE NOT NULL,
  
  CONSTRAINT pk_usuario_notificacion PRIMARY KEY (id_usuario, id_notificacion),
  CONSTRAINT fk_un_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_un_notificacion FOREIGN KEY (id_notificacion)
    REFERENCES notificacion(id_notificacion)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_usuario_notif_usuario ON usuario_notificacion(id_usuario);
CREATE INDEX idx_usuario_notif_notificacion ON usuario_notificacion(id_notificacion);


CREATE OR REPLACE TABLE recompensa (
  id_recompensa INT AUTO_INCREMENT,
  tipo ENUM('moneda','xp','insignia','desbloqueo') NOT NULL,
  descripcion TEXT,
  cantidad_base INT,
  
  CONSTRAINT pk_recompensa PRIMARY KEY (id_recompensa),
  CONSTRAINT chk_recompensa_cantidad CHECK (cantidad_base IS NULL OR cantidad_base >= 0)
) ENGINE=InnoDB;

CREATE INDEX idx_recompensa_tipo ON recompensa(tipo);


CREATE OR REPLACE TABLE usuario_recompensa (
  id_usuario INT NOT NULL,
  id_recompensa INT NOT NULL,
  cantidad INT DEFAULT 0,
  fecha_obtencion DATE NOT NULL,
  
  CONSTRAINT pk_usuario_recompensa PRIMARY KEY (id_usuario, id_recompensa),
  CONSTRAINT fk_ur_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ur_recompensa FOREIGN KEY (id_recompensa)
    REFERENCES recompensa(id_recompensa)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT chk_ur_cantidad CHECK (cantidad >= 0)
) ENGINE=InnoDB;

CREATE INDEX idx_usuario_recompensa_usuario ON usuario_recompensa(id_usuario);
CREATE INDEX idx_usuario_recompensa_recompensa ON usuario_recompensa(id_recompensa);