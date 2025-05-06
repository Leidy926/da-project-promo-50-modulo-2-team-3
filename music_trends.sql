-- PROYECTO MODULO 2 --
-- Base de datos: Music Trends

CREATE SCHEMA IF NOT EXISTS music_trends;
USE music_trends;

-- Creación de tablas
CREATE TABLE nationalities (
    nationality_id INT PRIMARY KEY,
    nationality_en VARCHAR(50),
    nationality_es VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS genre (
    id_genre INT PRIMARY KEY AUTO_INCREMENT,
    genre VARCHAR(100) NOT NULL
);


CREATE TABLE IF NOT EXISTS artists (
    id_artist INT PRIMARY KEY AUTO_INCREMENT,
    name_artist VARCHAR(100) NOT NULL,
    gender VARCHAR(100),
    listeners BIGINT,
    playcount BIGINT,
    biography TEXT,
    nationality_id INT,
    FOREIGN KEY (nationality_id) REFERENCES nationalities(nationality_id)
);

CREATE TABLE IF NOT EXISTS albums (
    id_album INT PRIMARY KEY AUTO_INCREMENT,
    name_album VARCHAR(300) NOT NULL,
    id_artist INT,
    FOREIGN KEY (id_artist) REFERENCES artists(id_artist)
);

CREATE TABLE IF NOT EXISTS tracks (
    id_track INT PRIMARY KEY AUTO_INCREMENT,
    name_track VARCHAR(300) NOT NULL,
    id_artist INT,
    popularity_index INT,
    id_album INT,
    id_genre INT ,
    release_year YEAR,
    FOREIGN KEY (id_album) REFERENCES albums(id_album),
    FOREIGN KEY (id_genre) REFERENCES genre (id_genre),
    FOREIGN KEY (id_artist) REFERENCES artists (id_artist)
);

-- Insertar datos de la base de datos 'musicdata', cambiar el nombre en el caso que se llame diferente

-- 1. Insertar genre

INSERT INTO genre (genre)
SELECT DISTINCT genre
FROM datamusic.tracks
WHERE genre IS NOT NULL
  AND genre NOT IN (
    SELECT genre FROM genre
);

-- 2. Insertar albums
-- Trunca los nombres de álbum que exceden 150 caracteres
ALTER TABLE albums
ADD COLUMN artist VARCHAR(300);

INSERT INTO albums (name_album, artist)
SELECT DISTINCT album_name, name_artist 
FROM datamusic.tracks
WHERE album_name IS NOT NULL;

INSERT INTO music_trends.artists (name_artist, biography, listeners, playcount)
SELECT DISTINCT Artist, Biography, Listeners, Playcount
FROM datamusic.artists
WHERE Artist IS NOT NULL;

SET SQL_SAFE_UPDATES = 0;

SET SESSION net_write_timeout = 600;
SET SESSION net_read_timeout = 600;

ALTER TABLE music_trends.albums 
MODIFY COLUMN name_album VARCHAR(300);

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 0 AND 1000;

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 1000 AND 2000;

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 2000 AND 3000;

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 3000 AND 4000;

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 4000 AND 5000;

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 5000 AND 6000;

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 6000 AND 7000;

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 7000 AND 8000;

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 8000 AND 9000;

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 9000 AND 10000;

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 10000 AND 11000;

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 11000 AND 12000;

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 12000 AND 13000;

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 13000 AND 14000;

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 14000 AND 15000;

UPDATE albums a
JOIN artists n ON a.artist = n.name_artist
SET a.id_artist = n.id_artist
WHERE a.id_album Between 15000 AND 16000;

ALTER TABLE music_trends.albums 
DROP COLUMN artist;

DELETE FROM music_trends.tracks;

ALTER TABLE music_trends.tracks 
ADD COLUMN name_artist VARCHAR(300),
ADD COLUMN genre VARCHAR (50),
ADD COLUMN album_name VARCHAR(300);

INSERT INTO music_trends.tracks (
    name_track, name_artist, popularity_index, genre, release_year, album_name
)
SELECT
    name_track, name_artist, popularity, genre, year, album_name
FROM datamusic.tracks;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 0 AND 1000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 1000 AND 2000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 2000 AND 3000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 3000 AND 4000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 4000 AND 5000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 5000 AND 6000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 6000 AND 7000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 7000 AND 8000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 8000 AND 9000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 9000 AND 10000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 10000 AND 11000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 11000 AND 12000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 12000 AND 13000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 13000 AND 14000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 14000 AND 15000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 15000 AND 16000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 16000 AND 17000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 17000 AND 18000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 18000 AND 19000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 19000 AND 20000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 20000 AND 21000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 21000 AND 22000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 22000 AND 23000;

UPDATE tracks a
LEFT JOIN albums n 
	ON a.album_name = n.name_album
LEFT JOIN artists b
	ON a.name_artist = b.name_artist
LEFT JOIN genre g
	ON a.genre = g.genre
SET a.id_album = n.id_album, a.id_artist = b.id_artist, a.id_genre = g.id_genre
WHERE id_track BETWEEN 23000 AND 24000;

ALTER TABLE tracks
DROP COLUMN name_artist,
DROP COLUMN genre,
DROP COLUMN album_name;


INSERT INTO Nationalities (nationality_id, nationality_en, nationality_es, country) VALUES
(1, 'Afghan', 'Afgan', 'Afghanistan'),
(2, 'Albanian', 'Alban', 'Albania'),
(3, 'Algerian', 'Argelin', 'Algeria'),
(4, 'Andorran', 'Andorran', 'Andorra'),
(5, 'Angolan', 'Angole', 'Angola'),
(6, 'Argentine', 'Argentin', 'Argentina'),
(7, 'Armenian', 'Armeni', 'Armenia'),
(8, 'Australian', 'Australian', 'Australia'),
(9, 'Austrian', 'Austriac', 'Austria'),
(10, 'Azerbaijani', 'Azerí', 'Azerbaijan'),
(11, 'Bahamian', 'Bahameñ', 'Bahamas'),
(12, 'Bahraini', 'Bareiní', 'Bahrain'),
(13, 'Bangladeshi', 'Bangladesí', 'Bangladesh'),
(14, 'Barbadian', 'Barbadens', 'Barbados'),
(15, 'Belarusian', 'Bielorrus', 'Belarus'),
(16, 'Belgian', 'Belga', 'Belgium'),
(17, 'Belizean', 'Beliceñ', 'Belize'),
(18, 'Beninese', 'Beninés', 'Benin'),
(19, 'Bhutanese', 'Butanés', 'Bhutan'),
(20, 'Bolivian', 'Bolivian', 'Bolivia'),
(21, 'Bosnian', 'Bosni', 'Bosnia and Herzegovina'),
(22, 'Botswanan', 'Botsuan', 'Botswana'),
(23, 'Brazilian', 'Brasiler', 'Brazil'),
(24, 'British', 'Británic', 'United Kingdom'),
(25, 'Bruneian', 'Brunean', 'Brunei'),
(26, 'Bulgarian', 'Búlgar', 'Bulgaria'),
(27, 'Burkinabe', 'Burkin', 'Burkina Faso'),
(28, 'Burmese', 'Birman', 'Myanmar'),
(29, 'Burundian', 'Burundés', 'Burundi'),
(30, 'Cambodian', 'Camboyan', 'Cambodia'),
(31, 'Cameroonian', 'Camerun', 'Cameroon'),
(32, 'Canadian', 'Canadiense', 'Canada'),
(33, 'Cape Verdean', 'Cabo Verdean', 'Cape Verde'),
(34, 'Chadian', 'Chadian', 'Chad'),
(35, 'Chilean', 'Chilen', 'Chile'),
(36, 'Chinese', 'Chin', 'China'),
(37, 'Colombian', 'Colombian', 'Colombia'),
(38, 'Congolese', 'Congolen', 'Congo'),
(39, 'Costa Rican', 'Costarricense', 'Costa Rica'),
(40, 'Croatian', 'Croata', 'Croatia'),
(41, 'Cuban', 'Cuban', 'Cuba'),
(42, 'Cypriot', 'Chipriota', 'Cyprus'),
(43, 'Czech', 'Chec', 'Czech Republic'),
(44, 'Danish', 'Dan', 'Denmark'),
(45, 'Djiboutian', 'Yibutian', 'Djibouti'),
(46, 'Dominican', 'Dominican', 'Dominican Republic'),
(47, 'Dutch', 'Neerlandés', 'Netherlands'),
(48, 'Ecuadorean', 'Ecuatorian', 'Ecuador'),
(49, 'Egyptian', 'Egipci', 'Egypt'),
(50, 'Salvadoran', 'Salvadoreñ', 'El Salvador'),
(51, 'English', 'Inglés', 'England'),
(52, 'Eritrean', 'Eritre', 'Eritrea'),
(53, 'Estonian', 'Eston', 'Estonia'),
(54, 'Ethiopian', 'Etíop', 'Ethiopia'),
(55, 'Fijian', 'Fiyian', 'Fiji'),
(56, 'Finnish', 'Finlandés', 'Finland'),
(57, 'French', 'Francés', 'France'),
(58, 'Gabonese', 'Gabones', 'Gabon'),
(59, 'Gambian', 'Gambian', 'Gambia'),
(60, 'Georgian', 'Georgian', 'Georgia'),
(61, 'German', 'Alemán', 'Germany'),
(62, 'Ghanaian', 'Ghanés', 'Ghana'),
(63, 'Greek', 'Grieg', 'Greece'),
(64, 'Grenadian', 'Granadin', 'Grenada'),
(65, 'Guatemalan', 'Guatemaltec', 'Guatemala'),
(66, 'Guinean', 'Guinean', 'Guinea'),
(67, 'Guyanese', 'Guyanés', 'Guyana'),
(68, 'Haitian', 'Haitian', 'Haiti'),
(69, 'Honduran', 'Hondureñ', 'Honduras'),
(70, 'Hungarian', 'Húngar', 'Hungary'),
(71, 'Icelandic', 'Islandés', 'Iceland'),
(72, 'Indian', 'Indi', 'India'),
(73, 'Indonesian', 'Indonesi', 'Indonesia'),
(74, 'Iranian', 'Iraní', 'Iran'),
(75, 'Iraqi', 'Iraquí', 'Iraq'),
(76, 'Irish', 'Irlandés', 'Ireland'),
(77, 'Israeli', 'Israelí', 'Israel'),
(78, 'Italian', 'Italian', 'Italy'),
(79, 'Jamaican', 'Jamaiquin', 'Jamaica'),
(80, 'Japanese', 'Japon', 'Japan'),
(81, 'Jordanian', 'Jordan', 'Jordan'),
(82, 'Kazakh', 'Kazaj', 'Kazakhstan'),
(83, 'Kenyan', 'Keniat', 'Kenya'),
(84, 'Kuwaiti', 'Kuwaití', 'Kuwait'),
(85, 'Laotian', 'Laosian', 'Laos'),
(86, 'Latvian', 'Letón', 'Latvia'),
(87, 'Lebanese', 'Libanés', 'Lebanon'),
(88, 'Liberian', 'Liberian', 'Liberia'),
(89, 'Libyan', 'Libi', 'Libya'),
(90, 'Lithuanian', 'Lituan', 'Lithuania'),
(91, 'Luxembourgish', 'Luxemburgués', 'Luxembourg'),
(92, 'Macedonian', 'Macedoni', 'North Macedonia'),
(93, 'Malagasy', 'Malgach', 'Madagascar'),
(94, 'Malawian', 'Malauí', 'Malawi'),
(95, 'Malaysian', 'Malasi', 'Malaysia'),
(96, 'Maldivian', 'Maldiv', 'Maldives'),
(97, 'Malian', 'Maliens', 'Mali'),
(98, 'Maltese', 'Maltés', 'Malta'),
(99, 'Marshallese', 'Marshalés', 'Marshall Islands'),
(100, 'Mauritanian', 'Mauritan', 'Mauritania'),
(101, 'Mauritian', 'Maurician', 'Mauritius'),
(102, 'Mexican', 'Mexican', 'Mexico'),
(103, 'Micronesian', 'Micronesi', 'Micronesia'),
(104, 'Moldovan', 'Moldav', 'Moldova'),
(105, 'Monacan', 'Monegas', 'Monaco'),
(106, 'Mongolian', 'Mongol', 'Mongolia'),
(107, 'Montenegrin', 'Montenegrin', 'Montenegro'),
(108, 'Moroccan', 'Marroquí', 'Morocco'),
(109, 'Mozambican', 'Mozambiqueñ', 'Mozambique'),
(110, 'Namibian', 'Namibi', 'Namibia'),
(111, 'Nauruan', 'Nauruan', 'Nauru'),
(112, 'Nepalese', 'Nepalí', 'Nepal'),
(113, 'New Zealander', 'Neozelandés', 'New Zealand'),
(114, 'Nicaraguan', 'Nicaragüens', 'Nicaragua'),
(115, 'Nigerian', 'Nigerian', 'Nigeria'),
(116, 'Nigerien', 'Nigerin', 'Niger'),
(117, 'North Korean', 'Norcorean', 'North Korea'),
(118, 'Norwegian', 'Norueg', 'Norway'),
(119, 'Omani', 'Omaní', 'Oman'),
(120, 'Pakistani', 'Pakistaní', 'Pakistan'),
(121, 'Palauan', 'Palauan', 'Palau'),
(122, 'Palestinian', 'Palestin', 'Palestine'),
(123, 'Panamanian', 'Panameñ', 'Panama'),
(124, 'Papua New Guinean', 'Papú', 'Papua New Guinea'),
(125, 'Paraguayan', 'Paraguay', 'Paraguay'),
(126, 'Peruvian', 'Peruan', 'Peru'),
(127, 'Philippine', 'Filipin', 'Philippines'),
(128, 'Polish', 'Polac', 'Poland'),
(129, 'Portuguese', 'Portugués', 'Portugal'),
(130, 'Qatari', 'Catarí', 'Qatar'),
(131, 'Romanian', 'Ruman', 'Romania'),
(132, 'Russian', 'Rus', 'Russia'),
(133, 'Rwandan', 'Ruandés', 'Rwanda'),
(134, 'Saint Lucian', 'Santa Lucía', 'Saint Lucia'),
(135, 'Samoan', 'Samoan', 'Samoa'),
(136, 'San Marinese', 'Sanmarinens', 'San Marino'),
(137, 'Sao Tomean', 'Santotomens', 'Sao Tome and Principe'),
(138, 'Saudi', 'Saudí', 'Saudi Arabia'),
(139, 'Senegalese', 'Senegalés', 'Senegal'),
(140, 'Serbian', 'Serbi', 'Serbia'),
(141, 'Seychellois', 'Seychelens', 'Seychelles'),
(142, 'Sierra Leonean', 'Sierraleonés', 'Sierra Leone'),
(143, 'Singaporean', 'Singapurens', 'Singapore'),
(144, 'Slovak', 'Eslovac', 'Slovakia'),
(145, 'Slovenian', 'Esloven', 'Slovenia'),
(146, 'Solomon Islander', 'Salomonens', 'Solomon Islands'),
(147, 'Somali', 'Somalí', 'Somalia'),
(148, 'South African', 'Sudafrican', 'South Africa'),
(149, 'South Korean', 'Surcorean', 'South Korea'),
(150, 'Spanish', 'Español', 'Spain'),
(151, 'Sri Lankan', 'Ceilanés', 'Sri Lanka'),
(152, 'Sudanese', 'Sudanés', 'Sudan'),
(153, 'Surinamese', 'Surinam', 'Suriname'),
(154, 'Swazi', 'Suaz', 'Eswatini'),
(155, 'Swedish', 'Suec', 'Sweden'),
(156, 'Swiss', 'Suiz', 'Switzerland'),
(157, 'Syrian', 'Siri', 'Syria'),
(158, 'Taiwanese', 'Taiwanés', 'Taiwan'),
(159, 'Tajik', 'Tayik', 'Tajikistan'),
(160, 'Tanzanian', 'Tanzanian', 'Tanzania'),
(161, 'Thai', 'Tailand', 'Thailand'),
(162, 'Togolese', 'Togoles', 'Togo'),
(163, 'Tongan', 'Tongano', 'Tonga'),
(164, 'Trinidadian', 'Trinitense', 'Trinidad and Tobago'),
(165, 'Tunisian', 'Tunecino', 'Tunisia'),
(166, 'Turkish', 'Turc', 'Turkey'),
(167, 'Turkmen', 'Turcoman', 'Turkmenistan'),
(168, 'Tuvaluan', 'Tuvaluan', 'Tuvalu'),
(169, 'Ugandan', 'Ugand', 'Uganda'),
(170, 'Ukrainian', 'Ucranian', 'Ukraine'),
(171, 'Uruguayan', 'Uruguay', 'Uruguay'),
(172, 'Uzbek', 'Uzbek', 'Uzbekistan'),
(173, 'Vanuatuan', 'Vanuatuense', 'Vanuatu'),
(174, 'Venezuelan', 'Venezolan', 'Venezuela'),
(175, 'Vietnamese', 'Vietnamita', 'Vietnam'),
(176, 'Welsh', 'Gal', 'Wales'),
(177, 'Yemeni', 'Yemení', 'Yemen'),
(178, 'Zambian', 'Zambian', 'Zambia'),
(179, 'Zimbabwean', 'Zimbabuen', 'Zimbabwe'),
(180, 'American', 'American', 'United States'),
(181, 'Scottish', 'Escos', 'Scotland'),
(182, 'Puerto Rican', 'Puertoriqueñ', 'Puerto Rico');

-- alter table artists
-- DROP COLUMN id_nationality;

ALTER TABLE artists
ADD nationality_en VARCHAR(20),
ADD nationality_es VARCHAR(20),
ADD nationality VARCHAR(20),
ADD country VARCHAR(30);

ALTER TABLE artists 
ADD COLUMN nationality_list VARCHAR(255);

SET SQL_SAFE_UPDATES = 0;

-- UPDATE artists a
-- SET a.nationality_list = (
-- SELECT GROUP_CONCAT(n.nationality_en ORDER BY LOCATE(n.nationality_en, a.Biography) SEPARATOR ', ') 
-- FROM nationalities n
-- WHERE a.Biography LIKE CONCAT('%', n.nationality_en, '%')
-- );

UPDATE artists a
SET a.nationality_list = (
    SELECT GROUP_CONCAT(n.nationality_en ORDER BY LOCATE(n.nationality_en, a.Biography) SEPARATOR ', ')
    FROM nationalities n
    WHERE a.Biography REGEXP CONCAT('\\b', n.nationality_en, '\\b')
);

UPDATE artists
SET nationality_list = SUBSTRING_INDEX(nationality_list, ', ', 1);

UPDATE artists
SET nationality_en = nationality_list;

UPDATE artists set nationality_list = NULL;

UPDATE artists a
SET a.nationality_list = (
    SELECT GROUP_CONCAT(n.nationality_es ORDER BY LOCATE(n.nationality_es, a.Biography) SEPARATOR ', ')
    FROM nationalities n
    WHERE a.Biography REGEXP CONCAT('\\b', n.nationality_es, '\\b')
);


-- UPDATE artists a
-- SET a.nationality_list = (
-- SELECT GROUP_CONCAT(n.nationality_es ORDER BY LOCATE(n.nationality_es, a.Biography) SEPARATOR ', ') 
-- FROM nationalities n
-- WHERE a.Biography LIKE CONCAT('%', n.nationality_es, '%')
-- );

UPDATE artists
SET nationality_list = SUBSTRING_INDEX(nationality_list, ', ', 1);

UPDATE artists
SET nationality_es = nationality_list;

UPDATE artists set nationality_list = NULL;

UPDATE artists a
SET a.nationality_list = (
SELECT GROUP_CONCAT(n.country ORDER BY LOCATE(n.country, a.Biography) SEPARATOR ', ') 
FROM nationalities n
WHERE a.Biography LIKE CONCAT('%', n.country, '%')
);

UPDATE artists
SET nationality_list = SUBSTRING_INDEX(nationality_list, ', ', 1);

UPDATE artists a
JOIN nationalities n ON a.nationality_list = n.country
SET a.nationality_en = n.nationality_en
WHERE a.nationality_en IS NULL;

ALTER TABLE artists
DROP COLUMN nationality_list;

-- EXCEPETIONS IN THE LIST OF COUNTRIES

-- American states
-- DROP TABLE us_states;

CREATE TABLE us_states (
    StateName VARCHAR(50) NOT NULL
);

INSERT INTO us_states (StateName) VALUES
('Alabama'),
('Alaska'),
('Arizona'),
('Arkansas'),
('California'),
('Colorado'),
('Connecticut'),
('Delaware'),
('Florida'),
('Georgia'),
('Hawaii'),
('Idaho'),
('Illinois'),
('Indiana'),
('Iowa'),
('Kansas'),
('Kentucky'),
('Louisiana'),
('Maine'),
('Maryland'),
('Massachusetts'),
('Michigan'),
('Minnesota'),
('Mississippi'),
('Missouri'),
('Montana'),
('Nebraska'),
('Nevada'),
('New Hampshire'),
('New Jersey'),
('New Mexico'),
('New York'),
('North Carolina'),
('North Dakota'),
('Ohio'),
('Oklahoma'),
('Oregon'),
('Pennsylvania'),
('Rhode Island'),
('South Carolina'),
('South Dakota'),
('Tennessee'),
('Texas'),
('Utah'),
('Vermont'),
('Virginia'),
('Washington'),
('West Virginia'),
('Wisconsin'),
('Wyoming');

UPDATE artists a
JOIN us_states n ON a.Biography 
LIKE CONCAT('%', n.StateName, '%')
SET a.country = 'United States';

-- Different ways in writing Nationalities
-- DROP TABLE us_citizens;

CREATE TABLE us_citizens(
    term VARCHAR(50)
);

INSERT INTO us_citizens (term) VALUES
('U.S. citizen'),
('Yankee'),
('North American'),
('Americano'),
('Americana'),
('Estadounidense'),
('Norteamericano'),
('Norteamericana');

UPDATE artists a
JOIN us_citizens n ON a.Biography 
LIKE CONCAT('%', n.term, '%')
SET a.country = 'United States';

-- DROP TABLE us_cities;

CREATE TABLE us_cities (
	CityName VARCHAR(50) NOT NULL
);

INSERT INTO us_cities (CityName) VALUES
('New York'),
('Los Angeles'),
('Chicago'),
('Houston'),
('Phoenix'),
('Philadelphia'),
('San Antonio'),
('San Diego'),
('Dallas'),
('San Jose'),
('Austin'),
('Jacksonville'),
('Fort Worth'),
('Columbus'),
('Charlotte'),
('San Francisco'),
('Indianapolis'),
('Seattle'),
('Denver'),
('Washington'),
('Boston'),
('El Paso'),
('Nashville'),
('Detroit'),
('Oklahoma City'),
('Portland'),
('Las Vegas'),
('Memphis'),
('Louisville'),
('Baltimore'),
('Milwaukee'),
('Albuquerque'),
('Tucson'),
('Fresno'),
('Sacramento'),
('Kansas City'),
('Mesa'),
('Atlanta'),
('Omaha'),
('Colorado Springs'),
('Raleigh'),
('Miami'),
('Long Beach'),
('Virginia Beach'),
('Oakland'),
('Minneapolis'),
('Tulsa'),
('Arlington'),
('Tampa'),
('New Orleans'),
('Wichita'),
('Cleveland'),
('Bakersfield'),
('Aurora'),
('Anaheim'),
('Honolulu'),
('Santa Ana'),
('Riverside'),
('Corpus Christi'),
('Lexington'),
('Henderson'),
('Stockton'),
('St. Paul'),
('Cincinnati'),
('St. Louis'),
('Pittsburgh'),
('Greensboro'),
('Lincoln'),
('Anchorage'),
('Plano'),
('Orlando'),
('Irvine'),
('Newark'),
('Toledo'),
('Durham'),
('Chula Vista'),
('Fort Wayne'),
('Jersey City'),
('St. Petersburg'),
('Laredo'),
('Madison'),
('Chandler'),
('Buffalo'),
('Lubbock'),
('Scottsdale'),
('Reno'),
('Glendale'),
('Gilbert'),
('Winston-Salem'),
('North Las Vegas'),
('Norfolk'),
('Chesapeake'),
('Garland'),
('Irving'),
('Hialeah'),
('Fremont'),
('Boise'),
('Richmond'),
('Baton Rouge'),
('Spokane'),
('LA'),
('NY');

UPDATE artists a
JOIN us_cities n ON a.Biography REGEXP CONCAT('\\b', n.CityName, '\\b')
SET a.country = 'United States';

-- Great Britain 
-- DROP TABLE uk_cities;

CREATE TABLE uk_cities (
    CityName VARCHAR(50) NOT NULL
);

INSERT INTO uk_cities (CityName) VALUES
('Bath'),
('Birmingham'),
('Bradford'),
('Brighton & Hove'),
('Bristol'),
('Cambridge'),
('Canterbury'),
('Carlisle'),
('Chelmsford'),
('Chester'),
('Chichester'),
('Colchester'),
('Coventry'),
('Derby'),
('Doncaster'),
('Durham'),
('Ely'),
('Exeter'),
('Gloucester'),
('Hereford'),
('Kingston-upon-Hull'),
('Lancaster'),
('Leeds'),
('Leicester'),
('Lichfield'),
('Lincoln'),
('Liverpool'),
('London'),
('Manchester'),
('Milton Keynes'),
('Newcastle-upon-Tyne'),
('Norwich'),
('Nottingham'),
('Oxford'),
('Peterborough'),
('Plymouth'),
('Portsmouth'),
('Preston'),
('Ripon'),
('Salford'),
('Salisbury'),
('Sheffield'),
('Southampton'),
('Southend-on-Sea'),
('St Albans'),
('Stoke on Trent'),
('Sunderland'),
('Truro'),
('Wakefield'),
('Wells'),
('Westminster'),
('Winchester'),
('Wolverhampton'),
('Worcester'),
('York');

UPDATE artists a
JOIN uk_cities n ON a.Biography 
LIKE CONCAT('%', n.CityName, '%')
SET a.country = 'England';

-- Japan
-- DROP TABLE japan_cities;

CREATE TABLE japan_cities (
    CityName VARCHAR(50) NOT NULL
);

INSERT INTO japan_cities (CityName) VALUES
('Tokyo'),
('Osaka'),
('Kyoto'),
('Yokohama'),
('Nagoya'),
('Sapporo'),
('Kobe'),
('Fukuoka'),
('Hiroshima'),
('Sendai'),
('Chiba'),
('Kitakyushu'),
('Kawasaki'),
('Saitama'),
('Kumamoto'),
('Okayama'),
('Shizuoka'),
('Hamamatsu'),
('Niigata'),
('Nagasaki'),
('Kanazawa'),
('Oita'),
('Matsuyama'),
('Naha'),
('Utsunomiya'),
('Wakayama'),
('Toyama'),
('Kofu'),
('Fukui'),
('Tokushima'),
('Matsue'),
('Tottori'),
('Takamatsu'),
('Kochi'),
('Miyazaki'),
('Kagoshima'),
('Saga'),
('Akita'),
('Aomori'),
('Morioka'),
('Yamagata'),
('Fukushima'),
('Maebashi'),
('Urawa'),
('Yokosuka'),
('Hachinohe'),
('Hakodate'),
('Asahikawa'),
('Tomakomai'),
('Obihiro');

UPDATE artists a
JOIN japan_cities n ON a.Biography 
LIKE CONCAT('%', n.CityName, '%')
SET a.country = 'Japan';

-- DROP TABLE mexico_cities;

CREATE TABLE mexico_cities (
    CityName VARCHAR(50) NOT NULL
);

INSERT INTO mexico_cities (CityName) VALUES
('Ciudad de Mexico'),
('Guadalajara'),
('Monterrey'),
('Puebla'),
('Tijuana'),
('León'),
('Ciudad Juárez'),
('Torreón'),
('Querétaro'),
('Mérida'),
('Mexicali'),
('Aguascalientes'),
('Hermosillo'),
('Saltillo'),
('Morelia'),
('Culiacán'),
('Chihuahua'),
('San Luis Potosí'),
('Toluca'),
('Reynosa'),
('Villahermosa'),
('Tampico'),
('Veracruz'),
('Acapulco'),
('Cancún'),
('Tuxtla Gutiérrez'),
('Durango'),
('Zacatecas'),
('Oaxaca'),
('Tepic'),
('Colima'),
('Campeche'),
('La Paz'),
('Mazatlán'),
('Irapuato'),
('Celaya'),
('Ensenada'),
('Matamoros'),
('Nuevo Laredo'),
('Coatzacoalcos'),
('Ciudad Victoria'),
('Cuernavaca'),
('Chilpancingo'),
('Pachuca'),
('Xalapa'),
('Puerto Vallarta'),
('Playa del Carmen'),
('San Cristóbal de las Casas'),
('Los Mochis'),
('Uruapan');

UPDATE artists a
JOIN mexico_cities n ON a.Biography 
LIKE CONCAT('%', n.CityName, '%')
SET a.country = 'Mexico';

-- DROP TABLE brazil_cities;

CREATE TABLE brazil_cities (
    CityName VARCHAR(50) NOT NULL
);

INSERT INTO brazil_cities (CityName) VALUES
('São Paulo'),
('Rio de Janeiro'),
('Brasília'),
('Salvador'),
('Fortaleza'),
('Belo Horizonte'),
('Manaus'),
('Curitiba'),
('Recife'),
('Porto Alegre'),
('Belém'),
('Goiânia'),
('Guarulhos'),
('Campinas'),
('São Luís'),
('São Gonçalo'),
('Maceió'),
('Duque de Caxias'),
('Natal'),
('Teresina'),
('Campo Grande'),
('São Bernardo do Campo'),
('Nova Iguaçu'),
('João Pessoa'),
('Santo André'),
('Osasco'),
('Jaboatão dos Guararapes'),
('Ribeirão Preto'),
('Uberlândia'),
('Contagem'),
('Sorocaba'),
('Aracaju'),
('Feira de Santana'),
('Londrina'),
('Juiz de Fora'),
('Joinville'),
('Ananindeua'),
('Niterói'),
('Florianópolis'),
('Santos'),
('Ribeirão das Neves'),
('Vila Velha'),
('Serra'),
('Diadema'),
('Campos dos Goytacazes'),
('Betim'),
('Mauá'),
('Caxias do Sul'),
('São João de Meriti'),
('Macapá');

UPDATE artists a
JOIN brazil_cities n ON a.Biography 
LIKE CONCAT('%', n.CityName, '%')
SET a.country = 'Brazil';

-- GENDER
-- ALTER TABLE artists
-- DROP COLUMN gender_id, 
-- DROP COLUMN gender;

ALTER TABLE artists
ADD COLUMN gender_id INT,
MODIFY COLUMN gender VARCHAR(10);

-- List of gender
-- DROP TABLE genders;

CREATE TABLE genders (
	gender_id INT AUTO_INCREMENT PRIMARY KEY,
    gender VARCHAR(10) NOT NULL,
    pronouns_en VARCHAR(10) NOT NULL,
    pronouns_es VARCHAR(10) NOT NULL
    );

INSERT INTO genders (gender, pronouns_en, pronouns_es) VALUES 
('female', 'she', 'ella'),
('male', 'he', 'el'),
('non-binary', 'they', 'elles'),
('N/A - band', 'band', 'banda')
;

-- ALTER table artists
-- DROP COLUMN male,
-- DROP COLUMN female,
-- DROP COLUMN non_binary,
-- DROP COLUMN band;

ALTER TABLE artists
ADD male VARCHAR(10),
ADD female VARCHAR(10),
ADD non_binary VARCHAR(10),
ADD band VARCHAR(10);

UPDATE artists a
JOIN genders n ON a.Biography REGEXP CONCAT('\\b', n.pronouns_en, '\\b')
SET a.gender = n.gender;

UPDATE artists a
JOIN genders n ON a.Biography REGEXP CONCAT('\\b', n.pronouns_es, '\\b')
SET a.gender = n.gender;

-- key words by gender
-- DROP TABLE male;

CREATE TABLE male (
    key_male_words VARCHAR(20) NOT NULL
    );

INSERT INTO male (key_male_words) VALUES 
('he'),
('him'),
('man'),
('male'),
('hombre'),
('masculino'),
('his');

-- DROP TABLE female;

CREATE TABLE female (
    key_female_words VARCHAR(20) NOT NULL
    );

INSERT INTO female (key_female_words) VALUES 
('she'),
('her'),
('woman'),
('female'),
('mujer'),
('femenina');

UPDATE artists a
JOIN male n ON a.Biography REGEXP CONCAT('\\b', n.key_male_words, '\\b')
SET a.male = 'male';

UPDATE artists a
JOIN female n ON a.Biography REGEXP CONCAT('\\b', n.key_female_words, '\\b')
SET a.female = 'female';

-- DROP TABLE band;

CREATE TABLE band (
    key_band_words VARCHAR(20) NOT NULL
    );

INSERT INTO band (key_band_words) VALUES 
('grupo'),
('group'),
('band'),
('banda'),
('duo'),
('trio'),
('quartet'),
('comprising'),
('who comprise'),
('formed by'),
('brothers'),
('sisters'),
('project'),
('made up'),
('artists'),
('was formed');

UPDATE artists a
JOIN band n ON a.Biography REGEXP CONCAT('\\b', n.key_band_words, '\\b')
SET a.band = 'N/A - band';

-- DROP TABLE non_binary;

CREATE TABLE non_binary (
    key_non_binary_words VARCHAR(20) NOT NULL
    );

INSERT INTO non_binary (key_non_binary_words) VALUES 
('their');

UPDATE artists a
JOIN non_binary n ON a.Biography REGEXP CONCAT('\\b', n.key_non_binary_words, '\\b')
SET a.non_binary = 'non-binary';

-- Filling the nationality and gender id field

UPDATE artists a
JOIN nationalities n ON a.nationality_en = n.nationality_en
SET a.nationality_id = n.nationality_id
WHERE a.nationality_id IS NULL;

UPDATE artists a
JOIN nationalities n ON a.nationality_es = n.nationality_es
SET a.nationality_id = n.nationality_id
WHERE a.nationality_id IS NULL;

UPDATE artists a
JOIN nationalities n ON a.country = n.country
SET a.nationality_id = n.nationality_id
WHERE a.nationality_id IS NULL;

-- Gender
UPDATE artists a
JOIN genders n ON a.gender = n.gender
SET a.gender_id = n.gender_id
WHERE a.gender_id IS NULL;

UPDATE artists a
JOIN genders n ON a.male = n.gender
SET a.gender_id = n.gender_id
WHERE a.gender_id IS NULL;

UPDATE artists a
JOIN genders n ON a.female = n.gender
SET a.gender_id = n.gender_id
WHERE a.gender_id IS NULL;

UPDATE artists a
JOIN genders n ON a.band = n.gender
SET a.gender_id = n.gender_id
WHERE a.gender = 'non-binary' OR a.gender_id IS NULL;

UPDATE artists a
JOIN genders n ON a.non_binary = n.gender
SET a.gender_id = n.gender_id
WHERE a.gender_id IS NULL;

-- Crear relaciones entre tablas
-- Fix from here!!

ALTER TABLE artists 
ADD CONSTRAINT fk_nationality FOREIGN KEY (nationality_id) 
REFERENCES nationalities(nationality_id);

ALTER TABLE artists 
ADD CONSTRAINT fk_genders FOREIGN KEY (gender_id) 
REFERENCES genders(gender_id);

DELETE FROM tracks 
WHERE id_track NOT IN (
    SELECT id_track FROM (
        SELECT MIN(id_track) AS id_track 
        FROM tracks 
        GROUP BY name_track, id_artist
    ) AS subquery
);


ALTER TABLE tracks 
ADD CONSTRAINT fk_albums FOREIGN KEY (id_album) 
REFERENCES albums(id_album);


ALTER TABLE artists 
DROP COLUMN nationality_en, 
DROP COLUMN nationality_es,  
DROP COLUMN nationality,
DROP COLUMN country, 
DROP COLUMN male, 
DROP COLUMN female, 
DROP COLUMN non_binary, 
DROP COLUMN band,
DROP COLUMN gender;

ALTER TABLE genders 
DROP COLUMN pronouns_en,
DROP COLUMN pronouns_es; 

DROP TABLE band;
DROP TABLE brazil_cities;
DROP TABLE female;

DROP TABLE japan_cities;
DROP TABLE male;
DROP TABLE mexico_cities;
DROP TABLE non_binary;
DROP TABLE uk_cities;
DROP TABLE us_cities;
DROP TABLE us_citizens;
DROP TABLE us_states;

SET SQL_SAFE_UPDATES = 1;