# Base de Datos Duolingo

## Descripción General
Este proyecto corresponde al rediseño y análisis funcional de la base de datos de la aplicación Duolingo, estructurando las dinámicas de aprendizaje, progreso y gamificación de la plataforma.

Da continuidad a una fase previa en la que se elaboraron el diagrama de contexto, las reglas de negocio y un primer modelo entidad–relación. En esta etapa, se consolidó el Modelo E-R y se implementó la base de datos en MariaDB, asegurando su normalización hasta la Tercera Forma Normal (3FN), definiendo restricciones de integridad y creando índices para optimizar las consultas.

El modelo integra los componentes y vistas esenciales del sistema: usuarios, idiomas, lecciones, ejercicios, ligas, rachas, notificaciones y recompensas, incluyendo las relaciones N:M resueltas mediante tablas puente.


## Normalización (1FN, 2FN, 3FN)
Durante el diseño del modelo relacional se aplico un proceso de normalización con el objetivo de reducir redundancias, inconsistencias y asegurar dependencias funcionales dentro de la base de datos inspirada en Duolingo. Este proceso nos permitio refinar las entidades y relaciones hasta cumplir con la tercera forma normal (3FN):

- **Primera Forma Normal (1FN):** Se garantizó que todos los atributos fueran atómicos y que no existieran atributos compuestos o multivaluados.
- **Segunda Forma Normal (2FN):** Se corrigieron dependencias parciales en tablas con claves compuestas, reorganizando las relaciones N:M de la base.
- **Tercera Forma Normal (3FN):** Se eliminaron dependencias transitivas entre atributos no clave para evitar duplicidad y ambigüedad.

## Motor y Versión 
- **Motor de base de datos:** MariaDB (compatible con MySQL)  
- **Versión utilizada:** `10.11.13-MariaDB`  
- **Distribución:** Debian GNU/Linux (x86_64)

## Requisitos Previos
Para clonar este repositorio y ejecutar los scripts incluidos, asegúrese de cumplir los siguientes requisitos:
- Git instalado
- En su terminal ingrese el comando "git clone https://github.com/Manuel-Carreno/duolingo-db.git"
- MariaDB o MySQL (versión mínima 15.1)
- PHP y un servidor local (Apache/XAMPP) para la demo y formularios
- Permisos de administrador para crear bases de datos y usuarios

## Documentos del proyecto
Dentro de la carpeta /sql encontrará:
| Archivo | Descripción| 
|--------------|--------------|
| 01_schema.sql | Creación de tablas, claves primarias y foráneas, restricciones e índices. |
| 02_seed.sql | Inserta datos de ejemplo (usuarios, idiomas, lecciones, ejercicios, etc.) para pruebas y validación del modelo. |
| 03_queries.sql | Consultas representativas sobre los datos. |
| 04_function.sql | Define la función fn_total_xp_usuario que calcula el XP total acumulado por un usuario en todos sus idiomas. Para esto, suma el xp_acumulado de la tabla usuario_idioma segun el id_usuario de cada uno.|
| 05_triggers.sq | Trigger trg_usuario_idioma_leccion_ai, que actualiza automáticamente el XP acumulado tras insertar una nueva lección completada por un usuario. Si la fila insertada incluye un valor en xp_obtenido lo sumara al xp_acumulado. |
| 06_transaction.sql | Transacción que suma XP y registra o actualiza recompensas, asegurando la atomicidad mediante COMMIT o ROLLBACK. Si ambos son exitosos entonces se confirma el commit y de lo contrario se revierte con un rollback. Incluye el procedimiento sp_sumar_xp_y_recompensa para sumar XP y asignar recompensa. |
| 07_stored procedure.sql | Procedimiento sp_completar_leccion para marcar lecciones como completadas, otorgar XP y asignar recompensas automáticamente. | 
| 08_stored_procedure2.sql | Define sp_eliminar_usuario para eliminar un usuario y sus datos asociados. | 
| 09_views.sql | Define las vistas para perfiles, dashboards, rachas, progreso de lecciones y ligas activas. | 

## Orden de ejecución de comandos
1. **Crear la base de datos y usuario:**
```
sudo mysql
CREATE DATABASE duolingo_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE duolingo_db;

CREATE USER IF NOT EXISTS 'duolingo_user'@'localhost' IDENTIFIED BY 'Duolingo123';
GRANT ALL PRIVILEGES ON duolingo_db.* TO 'duolingo_user'@'localhost';
FLUSH PRIVILEGES;

EXIT;
```
2. **Ejecutar scripts SQL desde la carpeta sql:** 
```
mysql -u duolingo_user -p duolingo_db
SOURCE /ruta/a/tu/repositorio/sql/01_schema.sql;
SOURCE /ruta/a/tu/repositorio/sql/02_seed.sql;
SOURCE /ruta/a/tu/repositorio/sql/03_queries.sql;
SOURCE /ruta/a/tu/repositorio/sql/04_function.sql;
SOURCE /ruta/a/tu/repositorio/sql/05_triggers.sql;
SOURCE /ruta/a/tu/repositorio/sql/06_transaction.sql;
SOURCE /ruta/a/tu/repositorio/sql/07_stored_procedure.sql;
SOURCE /ruta/a/tu/repositorio/sql/08_stored_procedure2.sql;
SOURCE /ruta/a/tu/repositorio/sql/09_views.sql;
EXIT;
```
**Nota:** Ajuste la ruta a la carpeta sql según su sistema operativo y ubicación del repositorio. Se recomienda /var/www/html/duolingo_db.

## Ejemplos de Uso
1. **Función para obtener XP total de un usuario:**
```SELECT fn_total_xp_usuario(1) AS xp_total_usuario_1;```
2. **Completar una lección con trigger y procedimiento:**
```
CALL sp_completar_leccion(1, 1, 3, 50);
SELECT xp_acumulado FROM usuario_idioma WHERE id_usuario = 1 AND id_idioma = 1;
```
3. **Sumar XP y asignar recompensa manualmente:**
```CALL sp_sumar_xp_y_recompensa(1, 1, 30, 1);```
4. **Eliminar un usuario y sus datos asociados:**
```CALL sp_eliminar_usuario(1);```

## Funcionalidades PHP / Demo
El repositorio incluye una carpeta /demo con un formularios PHP para interactuar con la base de datos:

Para abrirlo:
1. Copie la carpeta demo/ a su servidor local (Apache o XAMPP).
2. Abra la ruta:
http://localhost/duolingo-db/demo/index.php

Desde allí puede:
- Crear y eliminar distintas entidades (usuarios, idiomas, lecciones, ejercicios, ligas, rachas...)
- Visualizar tablas y dashboards
- Completar lecciones y sumar XP
- Asignar usuarios a ligas, y ejercicios a lecciones
- Probar la función de XP total
- Ejecutar procedimientos y trigger