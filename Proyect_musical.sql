-- Tabla de Géneros Musicales

CREATE SCHEMA proyecto_musical;
USE proyecto_musical;

CREATE TABLE genero (
    id_genero INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla País
CREATE TABLE Pais (
    id_pais VARCHAR(100) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla Artista

CREATE TABLE Artista (
    id_artista INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    sexo VARCHAR(100),
    indice_popularidad_artista FLOAT,
    biografia TEXT,
    id_pais VARCHAR(100),
    FOREIGN KEY (id_pais) REFERENCES Pais(id_pais)
);


-- Tabla de Álbumes
CREATE TABLE Album (
    id_album INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    indice_popularidad_album FLOAT,
    id_artista INT,
    ano_lanzamiento DATE,
    escuchas INT DEFAULT 0,
    reproducciones INT DEFAULT 0,
    FOREIGN KEY (id_artista) REFERENCES Artista(id_artista)
);



-- Tabla de Canciones
CREATE TABLE Cancion (
    id_cancion INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    indice_popularidad_cancion FLOAT,
    id_album INT,
    id_genero INT,
    escuchas INT DEFAULT 0,
	reproducciones INT DEFAULT 0,
    FOREIGN KEY (id_album) REFERENCES Album(id_album),
    FOREIGN KEY (id_genero) REFERENCES genero (id_genero)
);


-- Análisis de nuestra Base de Datos--

-- Vista o Consulta para obtener el Álbum más escuchado por Artista
CREATE VIEW Album_Mas_Escuchado AS
SELECT a.id_artista, ar.nombre AS artista, al.titulo AS album, al.escuchas
FROM Artista ar
JOIN Album al ON ar.id_artista = al.id_artista
JOIN (
    SELECT id_artista, MAX(escuchas) AS max_escuchas
    FROM Album
    GROUP BY id_artista
) a ON a.id_artista = al.id_artista AND a.max_escuchas = al.escuchas;

-- Vista o Consulta para obtener la Canción más escuchada por Álbum
CREATE VIEW Cancion_Mas_Escuchada AS
SELECT c.id_album, al.titulo AS album, c.titulo AS cancion, c.escuchas
FROM Album al
JOIN Cancion c ON al.id_album = c.id_album
JOIN (
    SELECT id_album, MAX(escuchas) AS max_escuchas
    FROM Cancion
    GROUP BY id_album
) cc ON cc.id_album = c.id_album AND cc.max_escuchas = c.escuchas;
