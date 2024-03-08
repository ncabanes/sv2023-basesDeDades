-- A partir de estos datos:

-- Streamers y temáticas (relación M:M)

CREATE TABLE streamers (
  codigo VARCHAR(6) PRIMARY KEY,
  nombre VARCHAR(30),
  pais VARCHAR(20)
);

CREATE TABLE tematicas (
  codigo VARCHAR(4) PRIMARY KEY,
  nombre VARCHAR(30)
);

CREATE TABLE hablaSobre (
  codigoStreamer VARCHAR(6),
  codigoTematica VARCHAR(4),
  idioma VARCHAR2(10),
  medio VARCHAR2(20),
  milesSeguidores NUMERIC(6,1),
  PRIMARY KEY (codigoStreamer, codigoTematica)
);

INSERT INTO streamers VALUES ('ill','Ibai Llanos', 'España');
INSERT INTO streamers VALUES ('ap','AuronPlay', 'España');
INSERT INTO streamers VALUES ('ng','Nate Gentile', 'España');
INSERT INTO streamers VALUES ('ltt','Linus Tech Tips', 'Canadá');
INSERT INTO streamers VALUES ('dyip','DYI Perks', NULL);
INSERT INTO streamers VALUES ('ach','Alexandre Chappel', 'Noruega');
INSERT INTO streamers VALUES ('tkn','Tekendo','España');
INSERT INTO streamers VALUES ('cad','Caddac Tech',NULL);

INSERT INTO tematicas VALUES ('inf','Informática');
INSERT INTO tematicas VALUES ('tec','Tecnología en general');
INSERT INTO tematicas VALUES ('gam','Gaming');
INSERT INTO tematicas VALUES ('var','Variado');
INSERT INTO tematicas VALUES ('bri','Bricolaje');
INSERT INTO tematicas VALUES ('via','Viajes');
INSERT INTO tematicas VALUES ('hum','Humor');

INSERT INTO hablaSobre VALUES ('ap','gam','Español','YouTube',29200);
INSERT INTO hablaSobre VALUES ('ill','var','Español','Twitch',12800);
INSERT INTO hablaSobre VALUES ('ap','var','Español','Twitch',14900);
INSERT INTO hablaSobre VALUES ('ng','inf','Español','YouTube',2450);
INSERT INTO hablaSobre VALUES ('ltt','inf','Inglés','YouTube',15200);
INSERT INTO hablaSobre VALUES ('dyip','bri','Inglés','YouTube',4140);
INSERT INTO hablaSobre VALUES ('ach','bri','Inglés','YouTube',370);
INSERT INTO hablaSobre VALUES ('cad','inf','Inglés','YouTube',3);


-- 24. Tres primeras letras de cada país y tres primeras letras de 
-- cada idioma, en una misma lista.

SELECT SUBSTR(pais,1,3) FROM streamers
UNION
SELECT SUBSTR(idioma,1,3) FROM hablaSobre;


-- 25, 26, 27, 28. Tres primeras letras de países que coincidan con 
-- las tres primeras letras de un idioma, sin duplicados, de 
-- cuatro formas distintas.

-- 25. INTERSECT

SELECT SUBSTR(pais,1,3) FROM streamers
INTERSECT
SELECT SUBSTR(idioma,1,3) FROM hablaSobre;

-- 26. IN

SELECT DISTINCT SUBSTR(pais,1,3) FROM streamers
WHERE SUBSTR(pais,1,3) IN
(
    SELECT SUBSTR(idioma,1,3) FROM hablaSobre
);

-- 27. ANY

SELECT DISTINCT SUBSTR(pais,1,3) FROM streamers
WHERE SUBSTR(pais,1,3) = ANY
(
    SELECT SUBSTR(idioma,1,3) FROM hablaSobre
);


-- 28. EXISTS

SELECT DISTINCT SUBSTR(pais,1,3) dato FROM streamers
WHERE EXISTS
(
    SELECT idioma FROM hablaSobre
    WHERE SUBSTR(idioma,1,3) = dato
);


-- 29. Nombre de streamer, nombre de medio y nombre de temática, 
-- para los canales que están por encima de la media de suscriptores.

SELECT streamers.nombre, medio, tematicas.nombre
FROM streamers INNER JOIN hablaSobre
    ON streamers.codigo = hablaSobre.codigoStreamer
    INNER JOIN tematicas
        ON tematicas.codigo = hablaSobre.codigoTematica
WHERE milesSeguidores > 
(
    SELECT AVG(milesSeguidores) FROM hablaSobre
);


-- 30. Nombre de streamer y medio, para los canales que hablan de la 
-- temática "Bricolaje".

SELECT streamers.nombre, medio
FROM streamers INNER JOIN hablaSobre
    ON streamers.codigo = hablaSobre.codigoStreamer
    INNER JOIN tematicas
        ON tematicas.codigo = hablaSobre.codigoTematica
WHERE tematicas.nombre = 'Bricolaje';


-- 31. Crea una tabla de "juegos". Para cada juego querremos un
-- código (5 cifras, clave primaria), un nombre (hasta 20 letras, 
-- no nulo) y una referencia al streamer que más habla de él (clave 
-- ajena a la tabla "streamers"). Usa sintaxis de Oracle.

CREATE TABLE juegos (
  codigo NUMBER(6),
  nombre VARCHAR2(20) NOT NULL,
  codigoStreamer VARCHAR2(6),
  CONSTRAINT pk_juegos PRIMARY KEY(codigo),
  CONSTRAINT fk_juegos_streamers 
    FOREIGN KEY(codigoStreamer) REFERENCES streamers(codigo)
);


-- 32. Añade a la tabla de juegos la restricción de que el código
-- debe ser 1000 o superior.

ALTER TABLE juegos ADD CONSTRAINT ck_codigo CHECK(codigo >= 1000);


-- 33. Añade 3 datos de ejemplo en la tabla de juegos. Para uno 
-- indicarás todos los campos, para otro no indicarás el streamer, 
-- ayudándote de NULL, y para el tercero no indicarás el streamer 
-- porque no detallarás todos los nombres de los campos.

INSERT INTO juegos VALUES (1000, 'Fortnite', 'tkn');
INSERT INTO juegos VALUES (1001, 'Valorant', NULL);
INSERT INTO juegos (codigo, nombre) VALUES  (1002, 'League of Legends');


-- 34. Borra el segundo dato de ejemplo que has añadido en la tabla 
-- de juegos, a partir de su código.

DELETE FROM juegos WHERE codigo = 1001;


-- 35. Muestra el nombre de cada juego junto al nombre del streamer 
-- que más habla de él, si existe. Los datos aparecerán ordenados 
-- por nombre de juego y, en caso de coincidir éste, por streamer.

SELECT juegos.nombre, streamers.nombre 
FROM juegos LEFT JOIN streamers
ON juegos.codigoStreamer = streamers.codigo
ORDER BY juegos.nombre, streamers.nombre;


-- 36. Modifica el último dato de ejemplo que has añadido en la tabla 
-- de juegos, para que sí tenga asociado un streamer que hable de él.

UPDATE juegos SET codigoStreamer = 'ill'
WHERE codigo = 1002;


-- 37. Crea una tabla "juegosStreamers", volcando en ella el nombre 
-- de cada juego (con el alias "juego") y el nombre del streamer que
-- habla de él (con el alias "streamer").

CREATE TABLE juegosStreamers AS
    SELECT juegos.nombre AS juego, streamers.nombre  AS streamer
    FROM juegos LEFT JOIN streamers
    ON juegos.codigoStreamer = streamers.codigo
    ORDER BY juegos.nombre, streamers.nombre;

SELECT * FROM juegosStreamers;


-- 38. Añade a la tabla "juegosStreamers" un campo "fechaPrueba".

ALTER TABLE juegosStreamers
ADD (fechaPrueba DATE);


-- 39. Pon la fecha de hoy (prefijada, sin usar SYSDATE) en el campo 
-- "fechaPrueba" de todos los registros de la tabla "juegosStreamers".

UPDATE juegosStreamers
SET fechaPrueba = TO_DATE('2024/03/06', 'YYYY/MM/DD');


-- 40. Muestra juego, streamer y fecha de ayer (día anterior al valor 
-- del campo "fechaPrueba") para todos los registros de la tabla "juegosStreamers".

SELECT juego, streamer, fechaPrueba - 1 AS fechaAyer FROM juegosStreamers;


-- 41. Muestra todos los datos de los registros de la tabla "juegosStreamers" 
-- que sean del año actual de 2 formas distintas (por ejemplo, usando comodines 
-- o funciones de cadenas).

SELECT * FROM juegosStreamers
WHERE TO_CHAR(fechaPrueba, 'YYYY/MM/DD') LIKE '2024%';

SELECT * FROM juegosStreamers
WHERE SUBSTR(TO_CHAR(fechaPrueba, 'YYYY/MM/DD'),1,4) = '2024';


-- 42. Elimina la columna "streamer" de la tabla "juegosStreamers".

ALTER TABLE juegosStreamers
DROP COLUMN streamer;

SELECT * FROM juegosStreamers;


-- 43. Vacía la tabla de "juegosStreamers", conservando su estructura.

TRUNCATE TABLE juegosStreamers;

SELECT * FROM juegosStreamers;

-- 44. Elimina por completo la tabla de "juegosStreamers".

DROP TABLE juegosStreamers;


-- 45. Borra los canales (registros de la tabla "hablaSobre") del 
-- streamer "Caddac Tech".

DELETE FROM hablaSobre WHERE codigoStreamer =
(
    SELECT codigo FROM streamers
    WHERE nombre = 'Caddac Tech'
);


-- 46. Muestra la diferencia entre el canal con más seguidores y 
-- la media, mostrada en millones de seguidores. Usa el alias "diferenciaMillones".

SELECT (MAX(milesSeguidores) - AVG(milesSeguidores))  1000 AS diferenciaMillones
FROM hablaSobre;


-- 47. Medios en los que tienen canales los creadores de código "ill", 
-- "ng" y "ltt", sin duplicados, usando IN (pero no en una subconsulta).

SELECT DISTINCT medio 
FROM hablaSobre 
WHERE codigoStreamer IN ('ill', 'ng', 'ltt');


-- 48. Medios en los que tienen canales los creadores "ill", "ng" y "ltt", 
-- sin duplicados, sin usar IN.

SELECT DISTINCT medio 
FROM hablaSobre 
WHERE codigoStreamer ='ill'
  OR codigoStreamer = 'ng'
  OR codigoStreamer = 'ltt';


-- 49. Nombre de streamer y nombre del medio en el que habla, para 
-- aquellos de los que no conocemos el país.

SELECT streamers.nombre, medio
FROM streamers INNER JOIN hablaSobre
ON streamers.codigo = hablaSobre.codigoStreamer
WHERE pais IS NULL;


-- 50. Nombre del streamer y medio de los canales que sean del mismo medio 
-- que el canal de Ibai Llanos que tiene 12800 miles de seguidores (puede aparecer 
-- el propio Ibai Llanos).

-- Previo: buscar ese canal

SELECT nombre, medio
FROM streamers INNER JOIN hablaSobre
ON streamers.codigo = hablaSobre.codigoStreamer
WHERE streamers.nombre = 'Ibai Llanos'
AND milesSeguidores = 12800;

-- Consulta completa

SELECT streamers.nombre, medio
FROM streamers INNER JOIN hablaSobre
ON streamers.codigo = hablaSobre.codigoStreamer
WHERE medio = 
(
    SELECT medio
    FROM streamers INNER JOIN hablaSobre
    ON streamers.codigo = hablaSobre.codigoStreamer
    WHERE streamers.nombre = 'Ibai Llanos'
    AND milesSeguidores = 12800
);


-- 51. Nombre del streamer y medio de los canales que sean del mismo
-- medio que el canal de Ibai Llanos que tiene 12800 miles de seguidores 
-- (sin incluir a Ibai Llanos).

SELECT streamers.nombre, medio
FROM streamers INNER JOIN hablaSobre
ON streamers.codigo = hablaSobre.codigoStreamer
WHERE medio = 
(
    SELECT medio
    FROM streamers INNER JOIN hablaSobre
    ON streamers.codigo = hablaSobre.codigoStreamer
    WHERE streamers.nombre = 'Ibai Llanos'
    AND milesSeguidores = 12800
)
AND streamers.nombre <> 'Ibai Llanos';


-- 52. Nombre de cada streamer, medio y temática, incluso si para algún
-- streamer no aparece ningún canal o para alguna temática no aparece
-- ningún canal.

SELECT streamers.nombre, medio, tematicas.nombre
FROM streamers LEFT JOIN hablaSobre
    ON streamers.codigo = hablaSobre.codigoStreamer
    RIGHT JOIN tematicas
        ON tematicas.codigo = hablaSobre.codigoTematica;


-- 53. Nombre de medio y nombre de cada temática, como parte de una 
-- única lista (quizá desordenada).

SELECT medio FROM hablaSobre
UNION
SELECT nombre FROM tematicas;


-- 54. Nombre de medio y nombre de cada temática, como parte de una 
-- única lista ordenada alfabéticamente.

SELECT nombre FROM
(
    SELECT medio AS nombre FROM hablaSobre
    UNION
    SELECT nombre FROM tematicas
)
ORDER BY nombre;



-- 55. Nombre de medio y cantidad media de suscriptores en 
-- ese medio, para los que están por encima de la media de suscriptores
-- de los canales.

SELECT medio, AVG(milesSeguidores) FROM hablaSobre
GROUP BY medio
HAVING AVG(milesSeguidores) > 
(
     SELECT AVG(milesSeguidores) FROM hablaSobre
);


-- 56. Nombre de los streamers que emiten en YouTube y que o bien
-- hablan en español o bien sus miles de seguidores están por encima de 12.000.

SELECT DISTINCT streamers.nombre
FROM streamers LEFT JOIN hablaSobre
    ON streamers.codigo = hablaSobre.codigoStreamer
    LEFT JOIN tematicas
        ON tematicas.codigo = hablaSobre.codigoTematica
WHERE medio = 'YouTube'
    AND (idioma = 'Español'
    OR milesSeguidores > 12000);


-- 57. Añade información ficticia sobre ti: datos como streamer,
-- temática sobre la que supuestamente y medio en el que hablas sobre ella, 
-- sin indicar cantidad de seguidores. Crea una consulta que muestre 
-- todos esos datos a partir de tu código.

INSERT INTO streamers VALUES ('nc','Nacho Cabanes', 'España');
INSERT INTO tematicas VALUES ('pro','Programación');
INSERT INTO hablaSobre VALUES ('nc','pro','Español','YouTube',5);

SELECT streamers.nombre, medio, tematicas.nombre
FROM streamers LEFT JOIN hablaSobre
    ON streamers.codigo = hablaSobre.codigoStreamer
    LEFT JOIN tematicas
        ON tematicas.codigo = hablaSobre.codigoTematica
WHERE streamers.codigo = 'nc';


-- 58. Muestra el nombre de cada streamer, medio en el que emite y 
-- cantidad de seguidores, en millones, redondeados a 1 decimal.

SELECT streamers.nombre, medio, ROUND(milesSeguidores / 1000, 1)
FROM streamers INNER JOIN hablaSobre
    ON streamers.codigo = hablaSobre.codigoStreamer;


-- 59. Muestra el nombre de cada streamer y el país de origen. Si 
-- no se sabe este dato, deberá aparecer "(País desconocido)".

SELECT nombre, NVL(pais, '(País desconocido)')
FROM streamers;


-- 60. Muestra, para cada streamer, su nombre, el medio en el que emite 
-- (precedido por "Emite en: ") y el idioma de su canal (precedido por "Idioma: ")

SELECT 
    streamers.nombre,
    CONCAT('Emite en: ', medio),
    CONCAT('Idioma: ', idioma)
FROM streamers INNER JOIN hablaSobre
    ON streamers.codigo = hablaSobre.codigoStreamer;


SELECT 
    streamers.nombre,
    'Emite en: ' || medio,
    'Idioma: '|| idioma
FROM streamers INNER JOIN hablaSobre
    ON streamers.codigo = hablaSobre.codigoStreamer;


-- Bonus. 61 a 64: Muestra el código de streamer, código de temática y 
-- miles de seguidores, para todos los canales excepto el que tiene la
-- máxima cantidad de seguidores, de 4 formas distintas.

-- 61. Max

SELECT codigoStreamer, codigoTematica, milesSeguidores
FROM hablaSobre WHERE milesSeguidores <
(
    SELECT MAX(milesSeguidores)
    FROM hablaSobre
)
ORDER BY milesSeguidores DESC;

-- 62. Any

SELECT codigoStreamer, codigoTematica, milesSeguidores
FROM hablaSobre WHERE milesSeguidores < ANY
(
    SELECT milesSeguidores
    FROM hablaSobre
)
ORDER BY milesSeguidores DESC;

-- 63. Exists

SELECT codigoStreamer, codigoTematica, milesSeguidores
FROM hablaSobre h1 WHERE EXISTS
(
    SELECT milesSeguidores 
    FROM hablaSobre h2
    WHERE h2.milesSeguidores > h1.milesSeguidores
)
ORDER BY milesSeguidores DESC;

-- 64. Fetch (offset)

SELECT codigoStreamer, codigoTematica, milesSeguidores
FROM hablaSobre 
ORDER BY milesSeguidores DESC
OFFSET 1 ROWS;
