-- Data_music_consultas

-- 1 --
--  artista mejor valorado - para todos los años y para el total de los años
-- no me queda claro por que contamos los distintos album_names
-- en mejor valorado me fijaría en en las tres medidas (una depende del año y las otras son independeientes del año)

-- 2 --
-- Género mejor valorado
-- me fijaría el promedio y el maximo por año de cada genero musical de la valoración de los tracks
-- no los limitaría

-- 3 --
--  Año que se lanzarón más albunes
-- No limitaría a solo 1


-- 4 --
-- Canción mejor valorada
-- (custom_popularity_score) = (a.Playcount * 0.6 + a.Listeners * 0.4) / total_songs_by_artist. Aquí se tiene en cuenta las escuchas y reproducciones
-- este índice es dificil para nosotras porque no tenemos una cantidad total de canciones. pero lo podemos armar con las canciones que tenemos en nuestra base
-- creo que usar el índice de popularidad que ya tenemos es bastante directo y funciona, pero podemos usar ambos
-- no limitaría 

-- 5 --
-- artista con más valoración
-- podemos mostrar un top 3 por año (según indice de popularidad de sus canciones - un promedio) 
-- y total con las otras tres medidas diferentes
-- podemos agregarle el genero musical para que sea más completo el análisis

-- 6 -- 
-- que nos devuelve como info el año también

-- 7 --
-- País con más artistas
-- Nos pide acá información sobre la popularidad?
-- lo haría por año y total - para mostrar cambios de tendencia

-- 8 --
-- Artista que estuvo más tiempo y cantidad de albunes
-- Como se ve? - no me convence del todo a limitarlo a 1

-- 9 -- 
-- Genero con más canciones (genero musical o genero de le artista?)
-- no Limitaría a 1
-- lo uniría a la pregunta (3)

-- 10 --
-- Cantidad de artistas por género- consulta extra (por genero musical o por genero de le artista?)

-- 11 --
-- Canción más escuchada
-- no se puede usar nuestro indice, solo el indice que tiene Spotify que es por track
-- lo haría por año y genero y país y un top 3

-- 12 --
-- no podemos hacer año con más escuchas

-- 13 -- 
-- Qué artista más escuchado en el 2020 (año pandemia)
-- Quizás artista más popular/ o canción más popular
-- quizás podemos hacer la composición de genero y de país - y un top 10

-- 14 --
-- Género de artist mas valorado, segun indice de popularidad
-- por año?

-- 15. 
-- País de origen del artistas mas escuchado segun reproducciones 
-- por año?
-- por genero?

-- 16 
-- País que tienen artistas con menos escuchas. 



