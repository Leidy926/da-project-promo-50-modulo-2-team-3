-- Consultas proyecto Módulo 2 : 

USE music_trends;

-- 1. Comparación de indicadores: como se vincula el indice de popularidad con la cantidad de oyentes?

SELECT 
	a.name_artist, a.listeners, 
	AVG(t.popularity_index) AS avg_popularity
FROM artists a
JOIN tracks t 
	ON a.id_artist = t.id_artist
GROUP BY a.id_artist, a.name_artist
ORDER BY a.listeners DESC
LIMIT 10;

-- y con la cantidad de reproducciones?

SELECT 
	a.name_artist, a.playcount, 
	AVG(t.popularity_index) AS avg_popularity
FROM artists a
JOIN tracks t 
	ON a.id_artist = t.id_artist
GROUP BY a.id_artist, a.name_artist
ORDER BY a.playcount DESC
LIMIT 10;

-- 2. Qué estilo musical es el mejor valorado por año?

SELECT
	ge.genre,
	AVG(t.popularity_index),
	t.release_year
FROM tracks t
LEFT JOIN genre ge
	ON t.id_genre = ge.id_genre
GROUP BY t.id_genre, t.release_year;

-- 3. Cuál es la estructura de género de todos los años?

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

-- 4. Qué promedio de popularidad anual tiene el/la artista más popular por grupos?

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

-- 5. Cuál es el top 5 de artistas con más reproducciones y con más oyentes?

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

-- 6. Cuál es la distribución de género de artistas por estilo musical a través del tiempo?

SELECT 
	t.release_year, 
    g.genre, 
    gen.gender, 
    COUNT(DISTINCT a.id_artist) AS cantidad_artistas
FROM tracks t
JOIN artists a 
	ON t.id_artist = a.id_artist
JOIN genre g 
	ON t.id_genre = g.id_genre
JOIN genders gen 
	ON a.gender_id = gen.gender_id
WHERE t.release_year BETWEEN 2019 AND 2024
GROUP BY t.release_year, g.genre, gen.gender
ORDER BY t.release_year ASC, g.genre, cantidad_artistas DESC;

-- 7. Cuál es el número de artistas qeu hay en el top 5 de los paises con mayor cantidad de artistas?

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

-- 8. Cuál es el top 3 de artistas con más álbumes por género y nacionalidad?

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