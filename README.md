# Base de Datos Duolingo

## Descripción General
Este proyecto corresponde al rediseño y análisis funcional de la base de datos de la aplicación Duolingo, estructurando las dinámicas de aprendizaje, progreso y gamificación de la plataforma.

Da continuidad a una fase previa en la que se elaboraron el diagrama de contexto, las reglas de negocio y un primer modelo entidad–relación. En esta etapa, se consolidó el Modelo E-R y se implementó la base de datos en MariaDB, asegurando su normalización hasta la Tercera Forma Normal (3FN), definiendo restricciones de integridad y creando índices para optimizar las consultas.

El modelo integra los componentes y vistas esenciales del sistema: usuarios, idiomas, lecciones, ejercicios, ligas, rachas, notificaciones y recompensas, incluyendo las relaciones N:M resueltas mediante tablas puente.

---

## Descripción del desarrollo de este proyecto
En esta sección se explica cómo se avanzó en la construcción del proyecto, incluyendo los pasos, herramientas y decisiones tomadas, para servir de ejemplo a futuros estudiantes:

1. **Planificación y Boceto Inicial**
    - Se definieron los objetivos del proyecto y las reglas de negocio de la aplicación.
    - Se realizó un boceto inicial en Miro para visualizar entidades, relaciones y flujos de información.
    - Se estableció un flujo de trabajo iterativo para refinar el modelo a medida que se avanzaba en el diseño. 

2. **Modelado Conceptual (Modelo E-R)**
    - El modelo E-R representa la estructura conceptual de la base de datos, mostrando cómo interactúan los distintos componentes del sistema.
    - Se definieron cardinalidades, tipos de participación (total/parcial) y relaciones clave.
    - Se usó DrawDB para construir el modelo final, incorporando:
        - Ajustes en la estructura de entidades
        - Normalización hasta la 3FN
        - Atributos clave, restricciones y tablas intermedias para relaciones N:M
    - El diseño conceptual se refleja en la base de datos implementada y en las 7 vistas definidas en el archivo 09_views.sql.
        - **Nota:** Se puede apreciar en la carpeta /bd tanto el archivo generado al exportar la base de datos como su modelo E-R generado en phpMyAdmin.

3. **Normalización (1FN, 2FN, 3FN)**
Durante el diseño del modelo relacional se aplico un proceso de normalización con el objetivo de reducir redundancias, inconsistencias y asegurar dependencias funcionales dentro de la base de datos inspirada en Duolingo. Este proceso permitió refinar las entidades y relaciones hasta cumplir con la tercera forma normal (3FN):
    - **Primera Forma Normal (1FN):** 
        - Todos los atributos son atómicos; se separaron nombres y apellidos en la tabla usuario.
        - Se crearon entidades para manejar listas multivaluadas (ej. usuario_idioma, usuario_liga).
    - **Segunda Forma Normal (2FN):** 
        - Se eliminaron dependencias parciales en tablas con claves compuestas, como usuario_idioma, usuario_liga, usuario_recompensa y leccion_ejercicio.
        - Se redefinieron atributos para que dependieran de la clave completa.
    - **Tercera Forma Normal (3FN):** 
        - Se eliminaron dependencias transitivas, por ejemplo, en usuario_idioma_leccion, evitando duplicidades y redundancias.
        - Se redistribuyeron atributos de tablas innecesarias (perfil) a tablas existentes, manteniendo independencia semántica.

El resultado fue un modelo final eficiente, coherente y normalizado, listo para implementación en MariaDB.

4. **Restricciones e Integridad**
Se implementaron reglas para garantizar la consistencia de los datos:
    - Claves primarias y foráneas, políticas CASCADE y RESTRICT.
    - Valores obligatorios y únicos, check constraints, y enumeraciones (ENUM) para tipos y estados.
    - Índices estratégicos para optimizar consultas frecuentes (usuario, correo, XP, ligas, lecciones, ejercicios, recompensas, notificaciones).

5. **Implementación de Vistas**
Se definieron 7 vistas principales para facilitar consultas y reportes:
    1. **vw_usuario_perfil:** Información básica y progreso del usuario por idioma.
    2. **vw_racha_actual:** Rachas activas de los usuarios.
    3. **vw_ranking_xp_por_idioma:** Ranking global de XP por idioma.
    4. **vw_usuario_dashboard:** Panel de actividad combinando XP total, rachas, idiomas activos y liga actual.
    5. **vw_progreso_lecciones:** Detalle de progreso por usuario e idioma.
    6. **vw_competencia_liga:** XP y ranking en ligas.
    7. **vw_resumen_admin:** Información resumida para administradores.

---

## Motor y Versión 
- **Motor de base de datos:** MariaDB (compatible con MySQL)  
- **Versión utilizada:** `10.11.13-MariaDB`  
- **Distribución:** Debian GNU/Linux (x86_64)

---

## Requisitos Previos
Para clonar este repositorio y ejecutar los scripts incluidos, asegúrese de cumplir los siguientes requisitos:
- Git instalado
- En su terminal ingrese el comando "git clone https://github.com/Manuel-Carreno/duolingo-db.git"
- MariaDB o MySQL (versión mínima 15.1)
- PHP y un servidor local (Apache/XAMPP) para la demo y formularios
- Permisos de administrador para crear bases de datos y usuarios

---

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
| 09_views.sql | Definición de vistas de perfil, dashboards, rachas, progreso y ligas. | 

---

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
**Nota:** Ajuste la ruta a la carpeta sql según su sistema operativo y ubicación del repositorio. En Linux se recomienda /var/www/html/duolingo_db.

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

---

## Funcionalidades PHP / Demo
El repositorio incluye una carpeta /demo con un formularios PHP para interactuar con la base de datos:

Para abrirlo:
1. Copie la carpeta demo/ a su servidor local (Apache o XAMPP).
2. Abrir en navegador:
http://localhost/duolingo-db/demo/index.php

Desde allí puede:
- Crear y eliminar distintas entidades (usuarios, idiomas, lecciones, ejercicios, ligas, rachas)
- Visualizar tablas y dashboards
- Completar lecciones y sumar XP
- Asignar usuarios a ligas y ejercicios a lecciones
- Probar la función de XP total
- Ejecutar procedimientos y triggers

---

## Diccionario de Datos, Índices y Restricciones
- Se documentó en un archivo Excel anexo en /bd que describe:
    - Tablas, atributos, claves primarias y foráneas
    - Tipos de datos, valores obligatorios, restricciones CHECK, ENUM
    - Índices para optimizar consultas frecuentes
    - Relaciones N:M y ternarias (usuario–idioma–lección)
- **Estrategia de índices:**
    - Búsquedas y autenticación: usuario.correo
    - Progreso y aprendizaje: usuario_idioma, usuario_idioma_leccion
    - Ejercicios y niveles: leccion.nivel, ejercicio.puntos_asignados
    - Notificaciones y recompensas: usuario_notificacion, usuario_recompensa
    - Ligas y competencias: liga.nombre, usuario_liga.id_usuario/id_liga