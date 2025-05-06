USE music_trends;

-- 1 --
-- Cuál es la composición de genero de todos los años 
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

-- 2 --
-- Cual es la composición del top 5 de países por año
-- (5) de Leidy incluida acá

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

-- 3 --
-- Cual es el top 3 artistas por año, en función de los tres indicadores 
-- indicando genero musical, genero-sexo, nacionalidad
-- incluyendo: 6) Álbum más valorado de los años pares de mi selección y que muestre el año y el álbum

-- 4 --
-- promedio y máximo de popularidad de canciones en función del género 
-- y en función de los países más importantes de nuestra muestra

-- 5 --
-- artista menor valorado x índice de popularidad x cada año?
