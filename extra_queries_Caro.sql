-- Impacto de la pandemia en la popularidad musical
-- ¿Hubo un aumento o disminución en la cantidad de reproducciones de música en general durante 
-- los años de la pandemia (2020-2021)?

SELECT release_year, SUM(playcount) AS total_reproducciones
FROM tracks t
JOIN artists a ON t.id_artist = a.id_artist
WHERE release_year BETWEEN 2020 AND 2021
GROUP BY release_year;

--  Esto muestra la cantidad total de reproducciones en 2020 y 2021.
-- Para comparar con años anteriores:

SELECT release_year, SUM(playcount) AS total_reproducciones
FROM tracks t
JOIN artists a ON t.id_artist = a.id_artist
WHERE release_year BETWEEN 2018 AND 2021
GROUP BY release_year;


-- ¿Qué géneros musicales experimentaron un mayor crecimiento en número de reproducciones durante 
-- la pandemia?

SELECT g.genre, SUM(t.popularity_index) AS total_popularidad
FROM tracks t
JOIN genre g ON t.id_genre = g.id_genre
WHERE release_year BETWEEN 2020 AND 2021
GROUP BY g.genre
ORDER BY total_popularidad DESC
LIMIT 5;

-- ¿Los artistas que lanzaron música en 2020-2021 tuvieron más éxito (en términos de reproducciones
--  y calificaciones) que aquellos que lanzaron en años previos o posteriores?

SELECT a.name_artist, SUM(t.popularity_index) AS total_popularidad
FROM artists a
JOIN tracks t ON a.id_artist = t.id_artist
WHERE t.release_year BETWEEN 2020 AND 2021
GROUP BY a.name_artist
ORDER BY total_popularidad DESC
LIMIT 10;

-- Lista los artistas más exitosos en esos años en términos de reproducciones.
-- Para comparar con años anteriores:

SELECT t.release_year, AVG(t.popularity_index) AS promedio_popularidad
FROM tracks t
WHERE t.release_year BETWEEN 2018 AND 2022
GROUP BY t.release_year;

-- ¿Hubo un aumento en la popularidad de canciones con letras relacionadas con aislamiento, 
-- resiliencia o bienestar emocional durante la pandemia?

SELECT t.name_track, t.popularity_index
FROM tracks t
JOIN lyrics l ON t.id_track = l.id_track
WHERE l.lyrics LIKE '%isolation%' OR l.lyrics LIKE '%resilience%' OR l.lyrics LIKE '%hope%'
ORDER BY t.popularity_index DESC
LIMIT 10;

-- Análisis de sesgo de género en la popularidad musical

-- ¿Existe una diferencia en la cantidad de reproducciones entre artistas masculinos y femeninos
-- durante el período analizado?

SELECT a.gender, SUM(t.popularity_index) AS total_reproducciones
FROM artists a
JOIN tracks t ON a.id_artist = t.id_artist
WHERE t.release_year BETWEEN 2018 AND 2022
GROUP BY a.gender;

-- ¿Las canciones de artistas femeninas tienen mejores calificaciones y reseñas en comparación con 
-- las de artistas masculinos?

SELECT a.gender, AVG(r.rating) AS promedio_calificaciones
FROM artists a
JOIN albums al ON a.id_artist = al.id_artist
JOIN ratings r ON al.id_album = r.id_album
GROUP BY a.gender;

-- ¿Hay géneros donde los artistas masculinos o femeninos dominen significativamente en términos de 
-- popularidad?

SELECT g.genre, a.gender, COUNT(*) AS cantidad_artistas
FROM artists a
JOIN tracks t ON a.id_artist = t.id_artist
JOIN genre g ON t.id_genre = g.id_genre
GROUP BY g.genre, a.gender
ORDER BY cantidad_artistas DESC;

-- ¿Cómo varió la representación de artistas femeninas en listas de los más escuchados antes, durante
-- y después de la pandemia?

SELECT t.release_year, COUNT(DISTINCT a.id_artist) AS total_artistas_femeninas
FROM artists a
JOIN tracks t ON a.id_artist = t.id_artist
WHERE a.gender = 'female' AND t.release_year BETWEEN 2018 AND 2022
GROUP BY t.release_year;

-- ¿Las colaboraciones entre artistas de diferentes géneros (masculino y femenino) influyen en la 
-- cantidad de reproducciones?

SELECT COUNT(*) AS total_colaboraciones, AVG(t.popularity_index) AS promedio_popularidad
FROM tracks t
WHERE name_track LIKE '%feat%' OR name_track LIKE '%&%';
