-- RESULTADO DE NUESTRO ANÁLISIS--

-- CONSULTAS  DE NUESTRA BASE DE DATOS DATA_MUSIC--

USE data_music;

-- 1. ¿Artista mejor valorado? 

SELECT c.name_artist, COUNT(DISTINCT c.album_name) AS total_albums
FROM canciones c
GROUP BY c.name_artist
ORDER BY total_albums DESC
LIMIT 1;

-- 2. Género mejor valorado

SELECT c.genre, AVG(c.popularity) AS avg_popularity
FROM canciones c
GROUP BY c.genre
ORDER BY avg_popularity DESC
LIMIT 1;

-- 3. Año que se lanzarón más albunes

SELECT c.year, COUNT(DISTINCT c.album_name) AS total_albums
FROM canciones c
GROUP BY c.year
ORDER BY total_albums DESC
LIMIT 1;

-- 4. Canción mejor valorada (se puede adapatar)

-- Formúla para sacar indice de popularidad con base a la info sacada de spotify--

-- (custom_popularity_score) = (a.Playcount * 0.6 + a.Listeners * 0.4) / total_songs_by_artist. Aquí se tiene en cuenta las escuchas y reproducciones


-- Por indice de popularidad--

SELECT c.name_track, MAX(c.popularity) AS max_popularity
FROM canciones c
GROUP BY c.name_track
ORDER BY max_popularity DESC
LIMIT 1;

-- por reproducciones

SELECT 
c.name_track,
c.name_artist,
c.album_name,
c.year,
a.Playcount  -- Reproducciones del artista
FROM canciones c
JOIN artists a ON c.name_artist = a.Artist
ORDER BY a.Playcount DESC
LIMIT 1;


-- 5. Artista con más valoración-- (formúla que se puede modificar)

SELECT 
a.Artist,
SUM(c.popularity) AS canciones_popularity,
a.Playcount,
a.Listeners,
ROUND(SUM(c.popularity) * 0.5 + a.Playcount * 0.3 + a.Listeners * 0.2, 2) AS valoracion_total -- El round aprox decimales-- 
FROM canciones c
JOIN artists a
ON c.name_artist = a.Artist
GROUP BY a.Artist, a.Playcount, a.Listeners
ORDER BY valoracion_total DESC
LIMIT 1;

-- En base a popularidad--

SELECT 
a.Artist,
ROUND(SUM(c.popularity), 2) AS total_indice_popularidad
FROM canciones c
JOIN artists a ON c.name_artist = a.Artist
WHERE c.popularity IS NOT NULL  -- Solo consideramos canciones con popularidad
GROUP BY a.Artist
ORDER BY total_indice_popularidad DESC
LIMIT 1;


-- 6. Albun más valorado de los años pares de mi selección--

SELECT 
c.album_name,
c.name_artist,
AVG(c.popularity) AS avg_popularity
FROM canciones c
WHERE MOD(c.year, 2) = 0  -- Años pares
GROUP BY c.album_name, c.name_artist
ORDER BY avg_popularity DESC
LIMIT 1;

-- 7. País que tiene más artistas--

SELECT 
a.country,
COUNT(*) AS total_artists,
ROUND(AVG(a.Playcount * 0.6 + a.Listeners * 0.4), 2) AS avg_valoracion
FROM artists a
WHERE a.country IS NOT NULL AND a.country != ''
GROUP BY a.country
ORDER BY total_artists DESC, avg_valoracion DESC
LIMIT 1;

-- 8. Artista que estuvo más tiempo y cantidad de albunes--

SELECT c.name_artist, COUNT(DISTINCT c.album_name) AS total_albums,
MIN(c.year) AS first_year, MAX(c.year) AS last_year,
(MAX(c.year) - MIN(c.year)) AS active_years
FROM canciones c
GROUP BY c.name_artist
ORDER BY active_years DESC
LIMIT 1;

-- 9.Género con más canciones- consulta extra- 

SELECT 
genre,
COUNT(*) AS total_canciones
FROM canciones
WHERE genre IS NOT NULL AND genre != ''
GROUP BY genre
ORDER BY total_canciones DESC
LIMIT 1;

-- 10. Cantidad de artistas por género- consulta extra-

SELECT 
c.genre,
COUNT(DISTINCT a.Artist) AS total_artistas
FROM canciones c
JOIN artists a ON c.name_artist = a.Artist
WHERE c.genre IS NOT NULL AND c.genre != ''
GROUP BY c.genre
ORDER BY total_artistas DESC;

-- 11. Canción más escuchada

SELECT 
c.name_track,
c.name_artist,
c.popularity,
a.Playcount,
a.Listeners,
    ROUND((c.popularity * 0.5) + (a.Playcount * 0.3) + (a.Listeners * 0.2), 2) AS indice_popularidad
FROM canciones c
JOIN artists a ON c.name_artist = a.Artist
WHERE c.popularity IS NOT NULL
ORDER BY indice_popularidad DESC
LIMIT 1;

-- Por reproducciones--

SELECT 
c.name_track,
c.name_artist,
c.album_name,
c.year,
a.Playcount  -- Reproducciones del artista (usado como base para la canción más escuchada)
FROM canciones c
JOIN artists a ON c.name_artist = a.Artist  -- Relacionamos las canciones con los artistas
ORDER BY a.Playcount DESC  -- Ordenamos por el Playcount del artista
LIMIT 1;

-- solo por popularidad

SELECT 
c.name_track,
c.name_artist,
c.album_name,
c.year,
    c.popularity  -- Popularidad de la canción
FROM canciones c
ORDER BY c.popularity DESC  -- Ordenamos por la popularidad de la canción
LIMIT 1;


-- 12. Año con más escuchas-- se tiene en cuenta todas las variables de escuchas y reproducciones. se pondera estos valores segun nuestros criterios , pero sacados de pag oficiales. porque no existe un criterio o una formula para sacar esto.

SELECT 
c.year,
    ROUND(SUM(
        (0.6 * c.popularity) +
        (0.25 * a.Playcount) +
        (0.15 * a.Listeners)
    ), 2) AS total_indice_escuchas
FROM canciones c
JOIN artists a ON c.name_artist = a.Artist
WHERE c.popularity IS NOT NULL AND c.year IS NOT NULL
GROUP BY c.year
ORDER BY total_indice_escuchas DESC
LIMIT 1;

-- 13.Qué artista más escuchado en el 2020 (año pandemia) 

SELECT 
    c.name_artist,
    ROUND(SUM(
        (0.6 * c.popularity) +
        (0.25 * a.Playcount) +
        (0.15 * a.Listeners)
    ), 2) AS total_indice_escuchas
FROM canciones c
JOIN artists a ON c.name_artist = a.Artist
WHERE c.year = 2020 AND c.popularity IS NOT NULL
GROUP BY c.name_artist
ORDER BY total_indice_escuchas DESC
LIMIT 1;

 -- con base a escuchas
 
SELECT 
a.Artist,
SUM(a.Listeners) AS total_listeners_2020
FROM canciones c
JOIN artists a ON c.name_artist = a.Artist
WHERE c.year = 2020
GROUP BY a.Artist
ORDER BY total_listeners_2020 DESC
LIMIT 1;

-- con base a reproducciones

SELECT 
a.Artist,
SUM(a.Playcount) AS total_playcount_2020
FROM canciones c
JOIN artists a ON c.name_artist = a.Artist
WHERE c.year = 2020
GROUP BY a.Artist
ORDER BY total_playcount_2020 DESC
LIMIT 1;

-- 14. Género (en cuanto al sexo) mas valorado, segun indice de popularidad)

SELECT 
g.gender,  -- Género basado en la tabla 'genders'
SUM(c.popularity) AS total_popularity  -- Suma de la popularidad de las canciones
FROM canciones c
JOIN artists a ON c.name_artist = a.Artist  -- Relacionamos las canciones con los artistas
JOIN genders g ON a.gender_id = g.gender_id  -- Relacionamos los artistas con su género
GROUP BY g.gender  -- Agrupamos por género de la tabla 'genders'
ORDER BY total_popularity DESC  -- Ordenamos por la popularidad total, de mayor a menor
LIMIT 1;  -- Tomamos el género mejor valorado

-- con base a nuestra formula de todas las variables como escuchas, reproducciones e indice de popularidad--
SELECT 
    g.gender,  -- Género basado en la tabla 'genders'
    SUM(
        (c.popularity + a.Listeners + a.Playcount) / 3
    ) AS combined_popularity  -- Cálculo del índice combinado de popularidad
FROM canciones c
JOIN artists a ON c.name_artist = a.Artist  -- Relacionamos las canciones con los artistas
JOIN genders g ON a.gender_id = g.gender_id  -- Relacionamos los artistas con su género
GROUP BY g.gender  -- Agrupamos por género de la tabla 'genders'
ORDER BY combined_popularity DESC  -- Ordenamos por el índice combinado de popularidad
LIMIT 1;  -- Tomamos el género mejor valorado

-- 15. País de origen del artistas mas escuchado segun reproducciones

SELECT 
a.country  -- Solo mostramos el país de origen del artista
FROM canciones c
JOIN artists a ON c.name_artist = a.Artist  -- Relacionamos canciones con los artistas
WHERE a.country IS NOT NULL  -- Aseguramos que el país no sea nulo
GROUP BY a.country  -- Agrupamos solo por país
ORDER BY SUM(a.Playcount) DESC  -- Ordenamos por las reproducciones (Playcount) de mayor a menor 
LIMIT 1;  -- Tomamos solo el país con el artista más escuchado

-- País donde existen mas escuchas, basadas en reproducciones-- 
-- Nota en cuanto diferencia de sum y count
-- SUM(a.Playcount): Suma todas las reproducciones (Playcount) de los artistas en cada país. Esto te da la cantidad total de reproducciones de los artistas en ese país. Es útil si quieres ver qué país tiene más reproducciones acumuladas en total.
-- COUNT(a.Playcount): Cuenta cuántas veces aparece un valor en el campo Playcount para cada país, es decir, cuántas canciones han sido reproducidas, independientemente de cuántas reproducciones tuvo cada canción. Esto cuenta el número de registros de canciones por país, no la cantidad total de reproducciones.

SELECT 
a.country,  -- Mostramos el país
SUM(c.popularity) AS total_playcount  -- Sumamos el total de reproducciones (Playcount)
FROM canciones c
JOIN artists a ON c.name_artist = a.Artist  -- Relacionamos las canciones con los artistas
WHERE a.country IS NOT NULL  -- Aseguramos que el país no sea nulo
GROUP BY a.country  -- Agrupamos por país
ORDER BY total_playcount DESC  -- Ordenamos por el total de reproducciones (Playcount) de mayor a menor
LIMIT 1;  -- Limitamos a solo el país con más reproducciones

-- País donde existen menos escuchas, basadas en reproducciones--

SELECT 
a.country,  -- Mostramos el país
SUM(c.popularity) AS total_playcount  -- Sumamos el total de reproducciones (Playcount)
FROM canciones c
JOIN artists a ON c.name_artist = a.Artist  -- Relacionamos las canciones con los artistas
WHERE a.country IS NOT NULL  -- Aseguramos que el país no sea nulo
GROUP BY a.country  -- Agrupamos por país
ORDER BY total_playcount ASC  -- Ordenamos por el total de reproducciones (Playcount) de menor a mayor
LIMIT 1;  -- Limitamos a solo el país con menos reproducciones
