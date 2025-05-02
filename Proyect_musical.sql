-- PROYECTO MUSICAL MODULO2 --

CREATE SCHEMA IF NOT EXISTS proyecto_musical;
USE proyecto_musical;



CREATE TABLE IF NOT EXISTS genero (
    id_genero INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);


-- Tabla País
CREATE TABLE IF NOT EXISTS nationality (
    id_nationality VARCHAR(100) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla Artista


CREATE TABLE IF NOT EXISTS Artista (
    id_artista INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    sexo VARCHAR(100),
    Listeners BIGINT,
    play_count BIGINT,
    biografia TEXT,
    id_nationality VARCHAR(100),
    FOREIGN KEY (id_nationality) REFERENCES nationality(id_nationality)
);


-- Tabla de Álbumes
CREATE TABLE IF NOT EXISTS Album (
    id_album INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    id_artista INT,
    ano_lanzamiento YEAR,
    FOREIGN KEY (id_artista) REFERENCES Artista(id_artista)
);


-- Tabla de Canciones
CREATE TABLE IF NOT EXISTS tracks (
    id_cancion INT PRIMARY KEY AUTO_INCREMENT,
    nombre_cancion VARCHAR(150) NOT NULL,
    nombre_artista VARCHAR (150) NOT NULL,
    indice_popularidad INT,
    nombre_album VARCHAR(150) NOT NULL,
    genero_cancion VARCHAR(150) NOT NULL,
    ano_lanzamiento_cancion YEAR,
    FOREIGN KEY (id_album) REFERENCES Album(id_album),
    FOREIGN KEY (id_genero) REFERENCES genero (id_genero)
);


-- modificaciones de hoy 01/05

-- 1. Insertar géneros únicos en la tabla genero
INSERT INTO genero (nombre)
SELECT DISTINCT genre
FROM data_music.canciones
WHERE genre IS NOT NULL
  AND genre NOT IN (
    SELECT nombre FROM genero
);

-- 2. Insertar álbumes únicos en la tabla album
-- Trunca los nombres de álbum que exceden 150 caracteres
INSERT INTO album (titulo, ano_lanzamiento)
SELECT DISTINCT
    LEFT(album_name, 150),
    CAST(year AS UNSIGNED)
FROM data_music.canciones
WHERE album_name IS NOT NULL
  AND year REGEXP '^[0-9]{4}$'
  AND LEFT(album_name, 150) NOT IN (
    SELECT titulo FROM album
);



-- 3. Insertar canciones en tracks con id_album e id_genero
INSERT INTO tracks (titulo, indice_popularidad, id_album, id_genero)
SELECT
    c.name_track,
    c.popularity,
    a.id_album,
    g.id_genero
FROM data_music.canciones c
JOIN album a ON c.album_name = a.titulo
JOIN genero g ON c.genre = g.nombre;

-- ahora si migracion 

-- Usar base de datos destino
USE proyecto_musical;

-- Insertar directamente en tracks
INSERT INTO tracks (
    nombre_cancion,
    nombre_artista,
    indice_popularidad,
    nombre_album,
    genero_cancion,
    ano_lanzamiento_cancion
)
SELECT
    LEFT(c.name_track, 150),          -- nombre_cancion (truncado)
    LEFT(c.name_artist, 150),         -- nombre_artista (truncado)
    c.popularity,                     -- indice_popularidad
    LEFT(c.album_name, 150),          -- nombre_album (truncado)
    LEFT(c.genre, 150),               -- genero_cancion (truncado)
    CASE
        WHEN c.year REGEXP '^[0-9]{4}$' THEN CAST(c.year AS UNSIGNED)
        ELSE NULL
    END                               -- ano_lanzamiento_cancion
FROM data_music.canciones c
WHERE c.name_track IS NOT NULL
  AND c.name_artist IS NOT NULL
  AND c.album_name IS NOT NULL
  AND c.genre IS NOT NULL;

INSERT INTO artista (nombre)
SELECT DISTINCT LEFT(name_artist, 150)
FROM data_music.canciones
WHERE name_artist IS NOT NULL
  AND LEFT(name_artist, 150) NOT IN (SELECT nombre FROM artista);
  
  UPDATE album a
JOIN (
    SELECT DISTINCT
        LEFT(c.album_name, 150) AS album_name,
        ar.id_artista
    FROM data_music.canciones c
    JOIN artista ar ON LEFT(c.name_artist, 150) = ar.nombre
    WHERE c.album_name IS NOT NULL AND c.name_artist IS NOT NULL
) sub ON a.titulo = sub.album_name
SET a.id_artista = sub.id_artista;

INSERT INTO genero (nombre)
SELECT DISTINCT LEFT(genre, 100)
FROM data_music.canciones
WHERE genre IS NOT NULL
  AND LEFT(genre, 100) NOT IN (SELECT nombre FROM genero);

INSERT INTO tracks (titulo, indice_popularidad, id_album, id_genero)
SELECT
    LEFT(c.name_track, 150),       -- titulo de la canción
    c.popularity,                  -- popularidad
    a.id_album,                    -- FK álbum
    g.id_genero                    -- FK género
FROM data_music.canciones c
JOIN album a ON LEFT(c.album_name, 150) = a.titulo
JOIN genero g ON LEFT(c.genre, 100) = g.nombre
WHERE c.name_track IS NOT NULL
  AND c.album_name IS NOT NULL
  AND c.genre IS NOT NULL;

UPDATE album a
JOIN (
    SELECT DISTINCT
        LEFT(c.album_name, 150) AS album_name,
        ar.id_artista
    FROM data_music.canciones c
    JOIN artista ar ON LEFT(c.name_artist, 150) = ar.nombre
    WHERE c.album_name IS NOT NULL AND c.name_artist IS NOT NULL
) sub ON a.titulo = sub.album_name
SET a.id_artista = sub.id_artista;

-- Transferir info de canciones de base de datos data_music a tabla tracks de nuestra base de datos proyecto_musical

INSERT INTO tracks (titulo, indice_popularidad, id_album, id_genero)
SELECT
    LEFT(c.name_track, 150),       -- título de la canción
    c.popularity,                  -- índice de popularidad
    a.id_album,                    -- clave foránea al álbum
    g.id_genero                    -- clave foránea al género
FROM data_music.canciones c
JOIN album a ON LEFT(c.album_name, 150) = a.titulo
JOIN genero g ON LEFT(c.genre, 100) = g.nombre
WHERE c.name_track IS NOT NULL
  AND c.album_name IS NOT NULL
  AND c.genre IS NOT NULL;
  
  SELECT
    t.id_track AS id_cancion,
    t.titulo AS nombre_cancion,
    ar.nombre AS nombre_artista,
    t.indice_popularidad,
    al.titulo AS nombre_album,
    al.ano_lanzamiento AS ano_lanzamiento_cancion,
    g.nombre AS genero_cancion
FROM
    tracks t
JOIN album al ON t.id_album = al.id_album
JOIN artista ar ON al.id_artista = ar.id_artista
JOIN genero g ON t.id_genero = g.id_genero
ORDER BY t.id_track;



-- Análisis de nuestra Base de Datos--

-- Vista o Consulta para obtener la Canción más escuchada por Álbum

-- 1. Artista con más albunes

SELECT 
    ar.nombre AS artista,
    COUNT(DISTINCT al.id_album) AS cantidad_albumes
FROM 
    artista ar
JOIN 
    album al ON ar.id_artista = al.id_artista
GROUP BY 
    ar.id_artista
ORDER BY 
    cantidad_albumes DESC
LIMIT 1;

-- 2. Género mejor valorado por indice de popularidad

SELECT 
    g.nombre AS genero,
    AVG(t.indice_popularidad) AS valoracion_promedio
FROM 
    tracks t
JOIN 
    genero g ON t.id_genero = g.id_genero
GROUP BY 
    g.id_genero
ORDER BY 
    valoracion_promedio DESC
LIMIT 1;

-- 3. Año en que se lanzaron más albunes

SELECT 
    al.ano_lanzamiento AS año,
    COUNT(DISTINCT al.id_album) AS cantidad_albumes
FROM 
    album al
GROUP BY 
    al.ano_lanzamiento
ORDER BY 
    cantidad_albumes DESC
LIMIT 1;

-- 4. Canción mejor valorada 

SELECT 
    c.name_track AS nombre_cancion,
    c.popularity AS indice_popularidad
FROM 
    data_music.canciones c
ORDER BY 
    c.popularity DESC
LIMIT 1;


-- 5. Artista con más valoración segun indice de popularidad

SELECT 
    ar.nombre AS artista,
    SUM(t.indice_popularidad) AS total_popularidad
FROM 
    tracks t
JOIN 
    album al ON t.id_album = al.id_album
JOIN 
    artista ar ON al.id_artista = ar.id_artista
GROUP BY 
    ar.id_artista
ORDER BY 
    total_popularidad DESC
LIMIT 1;

-- 6. Album más valorado de los años pares de mi selección

SELECT 
    al.titulo AS nombre_album,
    al.ano_lanzamiento AS ano_lanzamiento,
    SUM(t.indice_popularidad) AS total_popularidad
FROM 
    tracks t
JOIN 
    album al ON t.id_album = al.id_album
WHERE 
    MOD(al.ano_lanzamiento, 2) = 0  -- Filtrar por años pares
GROUP BY 
    al.id_album
ORDER BY 
    total_popularidad DESC
LIMIT 1;

-- 7. País con más artistas *

SELECT 
    ar.pais AS pais,
    COUNT(DISTINCT ar.id_artista) AS cantidad_artistas,
    SUM(t.indice_popularidad) AS total_popularidad
FROM 
    artista ar
JOIN 
    album al ON ar.id_artista = al.id_artista
JOIN 
    tracks t ON al.id_album = t.id_album
GROUP BY 
    ar.pais
ORDER BY 
    cantidad_artistas DESC, total_popularidad DESC
LIMIT 1;

-- 8. Qué artista estuvo más tiempo y cuántos albunes tiene

SELECT 
    ar.nombre AS artista,
    COUNT(DISTINCT al.id_album) AS cantidad_albumes,
    MIN(al.ano_lanzamiento) AS primer_album,
    MAX(al.ano_lanzamiento) AS ultimo_album,
    MAX(al.ano_lanzamiento) - MIN(al.ano_lanzamiento) AS tiempo_actividad
FROM 
    artista ar
JOIN 
    album al ON ar.id_artista = al.id_artista
GROUP BY 
    ar.id_artista
ORDER BY 
    tiempo_actividad DESC
LIMIT 1;

-- 9. Género con más canciones- consulta extra-

SELECT 
    g.nombre AS genero,
    COUNT(t.id_track) AS cantidad_canciones
FROM 
    genero g
JOIN 
    tracks t ON g.id_genero = t.id_genero
GROUP BY 
    g.id_genero
ORDER BY 
    cantidad_canciones DESC
LIMIT 1;

-- 10. Cantidad de artistas por género- consulta extra-

SELECT 
    g.nombre AS genero,
    COUNT(DISTINCT ar.id_artista) AS cantidad_artistas
FROM 
    genero g
JOIN 
    tracks t ON g.id_genero = t.id_genero
JOIN 
    album al ON t.id_album = al.id_album
JOIN 
    artista ar ON al.id_artista = ar.id_artista
GROUP BY 
    g.id_genero
ORDER BY 
    cantidad_artistas DESC;

-- 11. Canción más escuchada

SELECT 
    c.name_track AS nombre_cancion,
    c.name_artist AS nombre_artista,
    c.popularity AS indice_popularidad
FROM 
    data_music.canciones c
ORDER BY 
    c.popularity DESC
LIMIT 1;

-- 12. Año con más escuchas

SELECT 
    c.year AS año,
    SUM(c.popularity) AS total_escuchas
FROM 
    data_music.canciones c
GROUP BY 
    c.year
ORDER BY 
    total_escuchas DESC
LIMIT 1;

-- 13. qué canción se escucho más en el 2020 (año pandemia)

SELECT 
    c.name_track AS nombre_cancion,
    c.name_artist AS nombre_artista,
    c.popularity AS indice_popularidad
FROM 
    data_music.canciones c
WHERE 
    c.year = 2020
ORDER BY 
    c.popularity DESC
LIMIT 1;

-- 14. Qué artista más escuchado en el 2020 (año pandemia)

SELECT 
    c.name_artist AS nombre_artista,
    SUM(c.popularity) AS total_escuchas
FROM 
    data_music.canciones c
WHERE 
    c.year = 2020
GROUP BY 
    c.name_artist
ORDER BY 
    total_escuchas DESC
LIMIT 1;

-- 15. Qué canción más escuchada de bad bunny del 2020

SELECT 
    c.name_track AS nombre_cancion,
    c.popularity AS indice_popularidad
FROM 
    data_music.canciones c
WHERE 
    c.name_artist = 'Bad Bunny' 
    AND c.year = 2020
ORDER BY 
    c.popularity DESC
LIMIT 1;

-- 16. Artista más escuchada en el 2024

SELECT 
    c.name_artist AS nombre_artista,
    SUM(c.popularity) AS total_popularidad
FROM 
    data_music.canciones c
WHERE 
    c.year = 2024
GROUP BY 
    c.name_artist
ORDER BY 
    total_popularidad DESC
LIMIT 1;





