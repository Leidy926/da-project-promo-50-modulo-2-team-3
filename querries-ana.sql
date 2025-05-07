USE music_trends;

-- 1 --
-- Cuál es la composición de genero de todos los años? 
-- (incluyendo bandas y non-binary)
SELECT
    COUNT(DISTINCT t.id_artist) AS Nr_of_Artists,
    t.release_year AS ReleaseYear,
    g.gender AS ArtistsGender
FROM tracks t
LEFT JOIN artists a
    ON t.id_artist = a.id_artist
LEFT JOIN genders g
    ON a.gender_id = g.gender_id
WHERE a.gender_id IS NOT NULL
GROUP BY t.release_year, g.gender;

-- 1.2 --
-- La mujer y el hombre y banda mejor valorada por año y el total (con el AVG popularity)
-- corresponde (5) del proyecto -- ¿Cuál es el artista con más valoración?
SELECT
g.gender AS GenderArtist,
t.release_year AS ReleaseYear,
a.name_artist AS NameArtist,
AVG(t.popularity_index) AS PopularityAvg
FROM artists a
LEFT JOIN genders g
	ON a.gender_id = g.gender_id
LEFT JOIN tracks t
	ON a.id_artist = t.id_artist 
WHERE t.release_year = 2019 AND g.gender_id = 1 
GROUP BY a.id_artist, t.release_year
ORDER BY PopularityAvg DESC
LIMIT 1;

-- 1.3 --
-- Composición de genero del top 5 de artistas más escuchades y con mas listeners (las dos variables)
SELECT
a.name_artist AS ArtistName,
a.listeners AS Listeners,
g.gender AS Gender,
n.nationality_es AS Nationality
FROM artists a
LEFT JOIN genders g
	ON a.gender_id = g.gender_id
LEFT JOIN nationalities n
	ON a.nationality_id = n.nationality_id
ORDER BY listeners DESC
LIMIT 5;

SELECT
a.name_artist AS ArtistName,
a.playcount AS Listeners,
g.gender AS Gender,
n.nationality_es AS Nationality
FROM artists a
LEFT JOIN genders g
	ON a.gender_id = g.gender_id
LEFT JOIN nationalities n
	ON a.nationality_id = n.nationality_id
ORDER BY playcount DESC
LIMIT 5;

-- 1.4 - 
-- Composición genero-sexo por genero musical a través del tiempo
SELECT
t.release_year,
g.gender,
ge.genre,
COUNT(DISTINCT t.id_artist)
FROM tracks t
LEFT JOIN artists a
	ON t.id_artist = a.id_artist
LEFT JOIN genders g
	ON a.gender_id = g.gender_id
LEFT JOIN genre ge
	ON t.id_genre = ge.id_genre
WHERE a.gender_id IS NOT NULL
GROUP BY t.release_year, g.gender, ge.genre;

-- 2 --
-- 2.1 --
-- Top 5 de cantidad de artistas por países y por año
-- (5) de Leidy incluida acá
-- Igual a la (7) del proyecto - ¿Qué país tiene má artistas? (ordenar por popularidad)
SELECT
    COUNT(DISTINCT t.id_artist) AS Nr_of_Artists,
    t.release_year AS ReleaseYear,
    n.country AS Country
FROM tracks t
LEFT JOIN artists a
    ON t.id_artist = a.id_artist
LEFT JOIN nationalities n
    ON a.nationality_id = n.nationality_id
WHERE a.nationality_id IS NOT NULL AND t.release_year = 2019
GROUP BY t.release_year, n.nationality_id
ORDER BY Nr_of_Artists DESC
LIMIT 5;

SELECT
    COUNT(DISTINCT t.id_artist) AS Nr_of_Artists,
    t.release_year AS ReleaseYear,
    n.country AS Country
FROM tracks t
LEFT JOIN artists a
    ON t.id_artist = a.id_artist
LEFT JOIN nationalities n
    ON a.nationality_id = n.nationality_id
WHERE a.nationality_id IS NOT NULL AND t.release_year = 2020
GROUP BY t.release_year, n.nationality_id
ORDER BY Nr_of_Artists DESC
LIMIT 5;

SELECT
    COUNT(DISTINCT t.id_artist) AS Nr_of_Artists,
    t.release_year AS ReleaseYear,
    n.country AS Country
FROM tracks t
LEFT JOIN artists a
    ON t.id_artist = a.id_artist
LEFT JOIN nationalities n
    ON a.nationality_id = n.nationality_id
WHERE a.nationality_id IS NOT NULL AND t.release_year = 2021
GROUP BY t.release_year, n.nationality_id
ORDER BY Nr_of_Artists DESC
LIMIT 5;

SELECT
    COUNT(DISTINCT t.id_artist) AS Nr_of_Artists,
    t.release_year AS ReleaseYear,
    n.country AS Country
FROM tracks t
LEFT JOIN artists a
    ON t.id_artist = a.id_artist
LEFT JOIN nationalities n
    ON a.nationality_id = n.nationality_id
WHERE a.nationality_id IS NOT NULL AND t.release_year = 2022
GROUP BY t.release_year, n.nationality_id
ORDER BY Nr_of_Artists DESC
LIMIT 5;

SELECT
    COUNT(DISTINCT t.id_artist) AS Nr_of_Artists,
    t.release_year AS ReleaseYear,
    n.country AS Country
FROM tracks t
LEFT JOIN artists a
    ON t.id_artist = a.id_artist
LEFT JOIN nationalities n
    ON a.nationality_id = n.nationality_id
WHERE a.nationality_id IS NOT NULL AND t.release_year = 2023
GROUP BY t.release_year, n.nationality_id
ORDER BY Nr_of_Artists DESC
LIMIT 5;

SELECT
    COUNT(DISTINCT t.id_artist) AS Nr_of_Artists,
    t.release_year AS ReleaseYear,
    n.country AS Country
FROM tracks t
LEFT JOIN artists a
    ON t.id_artist = a.id_artist
LEFT JOIN nationalities n
    ON a.nationality_id = n.nationality_id
WHERE a.nationality_id IS NOT NULL AND t.release_year = 2024
GROUP BY t.release_year, n.nationality_id
ORDER BY Nr_of_Artists DESC
LIMIT 5;

-- 2.2 --
-- 

-- 3 --
-- Cual es el top 3 artistas por año, en función de los tres indicadores 
-- indicando genero musical, genero-sexo, nacionalidad
-- incluyendo: 6) Álbum más valorado de los años pares de mi selección y que muestre el año y el álbum

-- 4 --
-- promedio y máximo de popularidad de canciones en función del género 
-- y en función de los países más importantes de nuestra muestra

-- 5 --
-- artista menor valorado x índice de popularidad x cada año?

-- 6 Por genero musical --

-- 6.1 --
-- ¿Cuál es el artista con más albums?
-- identificar: genero artista y pais
-- arreglar gender del 3ero
SELECT
COUNT(DISTINCT m.id_album),
a.name_artist,
g.gender,
n.nationality_es
FROM albums m
LEFT JOIN tracks t
	ON m.id_album = t.id_album
LEFT JOIN artists a
	ON m.id_artist = a.id_artist
LEFT JOIN genders g
	ON a.gender_id = g.gender_id
LEFT JOIN nationalities n
	ON a.nationality_id = n.nationality_id
WHERE n.nationality_id IS NOT NULL
GROUP BY m.id_artist
ORDER BY COUNT(DISTINCT m.id_album) DESC
LIMIT 3;

-- 7.1 --
-- (pregunta 2 del proyecto) ¿Qué género es el mejor valorado? por año y total?
SELECT
ge.genre,
AVG(t.popularity_index),
t.release_year
FROM tracks t
LEFT JOIN genre ge
	ON t.id_genre = ge.id_genre
GROUP BY t.id_genre, t.release_year;

-- 8.1 --
-- ¿Cuál es la canción mejor valorada? Por genero y por año
-- agregamos genero de artista y nacionalidad


-- cARO
SELECT 
a.name_artist, 
a.playcount, 
AVG(t.popularity_index) AS avg_popularity
FROM artists a
JOIN tracks t ON a.id_artist = t.id_artist
GROUP BY a.id_artist, a.name_artist
ORDER BY a.playcount DESC
LIMIT 10;
