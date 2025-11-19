# Base de Datos Duolingo

## Descripción General
El presente proyecto corresponde al rediseño y análisis funcional de la base de datos de la aplicación "Duolingo", que representara de manera estructurada las dinámicas de aprendizaje, progreso y gamificación de esta plataforma

Este trabajo da continuidad a una etapa previa en la que se elaboró el diagrama de contexto, las reglas de negocio y un primer modelo entidad–relación. En esta fase, se consolidó el Modelo E-R y se implementó la base de datos en MariaDB, asegurando su normalización hasta la Tercera Forma Normal (3FN), la definición de restricciones de integridad y la creación de índices para optimizar las consultas.

El modelo integra los componentes esenciales del sistema: usuarios, idiomas, lecciones, ejercicios, ligas, rachas, notificaciones y recompensas, junto con las relaciones N:M resueltas mediante tablas puente.

## Motor y Versión 
- Motor de base de datos: MariaDB (compatible con MySQL)  
- Versión utilizada: `10.11.13-MariaDB`  
- Distribución: Debian GNU/Linux (x86_64)

## Requisitos Previos
Si desea clonar este repositorio para hacer uso del proyecto y ejecutar los scripts incluidos, asegúrese de cumplir con los siguientes requisitos previos:
- Git instalado
- En su terminal ingrese el comando "git clone https://github.com/Manuel-Carreno/duolingo-db.git"
- MariaDB o MySQL (versión 15.1)
- Permisos de administrador para crear bases de datos y usuarios

## Documentos del proyecto
| Archivo | Descripción| 
|--------------|--------------|
| 01_schema.sql | 'Contiene el codigo para: creación de tablas, claves primarias/foráneas, restricciones e índices'|
| 02_seed.sql |'Inserta datos de ejemplo (usuarios, idiomas, lecciones, ejercicios etc...) para todo tipo de consultas, pruebas y validación del modelo'|
| 03_queries.sql| 'Contiene el codigo para realizar consultas'|

## Orden de ejecución de comandos
1. **Crear la base de datos y al usuario:**
" sudo mysql
   CREATE DATABASE duolingo_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
   USE duolingo_db;

   CREATE USER IF NOT EXISTS 'duolingo_user'@'localhost' IDENTIFIED BY 'Duolingo123';
   GRANT ALL PRIVILEGES ON duolingo_db.* TO 'duolingo_user'@'localhost';
   FLUSH PRIVILEGES;

   exit;
"
2. **Ejecutar 01_schema.sql** 
"mysql -u duolingo_user -p duolingo_db < 01_schema.sql"
3. **Cargar los datos iniciales**
"mysql -u duolingo_user -p duolingo_db < 02_seed.sql"
4. **Ejecutar las consultas representativas**
mysql -u duolingo_user -p duolingo_db < 03_queries.sql