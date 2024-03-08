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


-- 01. Nombre de las temáticas que tenemos almacenadas, ordenadas alfabéticamente.

SELECT nombre FROM tematicas ORDER BY nombre;

-- 02. Cantidad de streamers cuyo país es "España".

SELECT COUNT(*) AS cantidad FROM streamers WHERE pais = 'España';

-- 03, 04, 05. Nombres de streamers cuya segunda letra no sea una "B" (quizá en minúsculas), de 3 formas distintas.

SELECT nombre FROM streamers
WHERE UPPER(nombre) NOT LIKE '_B%';

SELECT nombre FROM streamers
WHERE SUBSTR(UPPER(nombre),2,1) <> 'B';

SELECT nombre FROM streamers
WHERE INSTR(UPPER(nombre),'B',2) <> 2;

-- 06. Media de suscriptores para los canales cuyo idioma es "Español".

SELECT AVG(milesSeguidores)
FROM hablaSobre 
WHERE idioma = 'Español';


-- Si lo queremos por streamer:

-- Previo 1: canal e idioma

SELECT streamers.nombre, hablaSobre.idioma
FROM streamers 
    JOIN hablaSobre 
    ON streamers.codigo = hablaSobre.codigoStreamer;

-- Previo 2: canales en español y suscriptores

SELECT streamers.nombre, milesSeguidores
FROM streamers 
    JOIN hablaSobre 
    ON streamers.codigo = hablaSobre.codigoStreamer
WHERE hablaSobre.idioma = 'Español';

-- Consulta completa:

SELECT streamers.nombre, AVG(milesSeguidores)
FROM streamers 
    JOIN hablaSobre 
    ON streamers.codigo = hablaSobre.codigoStreamer
WHERE hablaSobre.idioma = 'Español'
GROUP BY streamers.nombre;


-- 07. Media de seguidores para los canales cuyo streamer es del país "España".

SELECT AVG(milesSeguidores)
FROM streamers 
    JOIN hablaSobre 
    ON streamers.codigo = hablaSobre.codigoStreamer
WHERE streamers.pais = 'España';


-- Si filtramos por streamer:

SELECT streamers.nombre, AVG(milesSeguidores)
FROM streamers 
    JOIN hablaSobre 
    ON streamers.codigo = hablaSobre.codigoStreamer
WHERE streamers.pais = 'España'
GROUP BY streamers.nombre;


-- 08. Nombre de cada streamer y medio en el que habla, para aquellos 
-- que tienen entre 5.000 y 15.000 miles de seguidores, usando BETWEEN.

SELECT streamers.nombre, milesSeguidores
FROM streamers 
    JOIN hablaSobre 
    ON streamers.codigo = hablaSobre.codigoStreamer
WHERE milesSeguidores BETWEEN 5000 AND 15000;


-- 09. Nombre de cada streamer y medio en el que habla, para aquellos 
-- que tienen entre 5.000 y 15.000 miles de seguidores, sin usar BETWEEN.

SELECT streamers.nombre, medio, milesSeguidores
FROM streamers 
    JOIN hablaSobre 
    ON streamers.codigo = hablaSobre.codigoStreamer
WHERE milesSeguidores >= 5000 AND milesSeguidores <= 15000;


-- 10. Nombre de cada temática y nombre de los idiomas en que tenemos 
-- canales de esa temática (quizá ninguno), sin duplicados.

SELECT DISTINCT tematicas.nombre, hablaSobre.idioma
FROM tematicas LEFT JOIN hablaSobre
ON tematicas.codigo = hablaSobre.codigoTematica;


-- 11. Nombre de cada streamer, nombre de la temática de la que habla 
-- y del medio en el que habla de esa temática, usando INNER JOIN.

SELECT streamers.nombre, tematicas.nombre, hablaSobre.medio
FROM streamers INNER JOIN hablaSobre 
    ON streamers.codigo = hablaSobre.codigoStreamer
    INNER JOIN tematicas 
    ON tematicas.codigo = hablaSobre.codigoTematica;


-- 12. Nombre de cada streamer, temática y medio en el que habla de esa temática, usando WHERE.

SELECT streamers.nombre, tematicas.nombre, hablaSobre.medio
FROM streamers, hablaSobre, tematicas
    WHERE streamers.codigo = hablaSobre.codigoStreamer
    AND tematicas.codigo = hablaSobre.codigoTematica;


-- 13. Nombre de cada streamer, del medio en el que habla y de la 
-- temática de la que habla en ese medio, incluso si de algún streamer no 
-- tenemos dato del medio o de la temática.

SELECT streamers.nombre, tematicas.nombre, hablaSobre.medio
FROM streamers LEFT JOIN hablaSobre 
    ON streamers.codigo = hablaSobre.codigoStreamer
    LEFT JOIN tematicas 
    ON tematicas.codigo = hablaSobre.codigoTematica;


-- 14. Nombre de cada medio y cantidad de canales que tenemos 
-- anotados en él, ordenado alfabéticamente por el nombre del medio.

SELECT medio, COUNT(*)
FROM hablaSobre
GROUP BY medio
ORDER BY medio;


-- 15, 16, 17, 18. Medio en el que se emite el canal de más seguidores,
-- de 4 formas distintas.

-- 15 - MAX

SELECT medio FROM hablaSobre
WHERE milesSeguidores = (SELECT MAX(milesSeguidores) FROM hablaSobre);

-- 16 - ALL

SELECT medio FROM hablaSobre
WHERE milesSeguidores >= ALL (SELECT milesSeguidores FROM hablaSobre);

-- 17 - NOT EXISTS

SELECT medio FROM hablaSobre h1
WHERE NOT EXISTS
(
    SELECT medio FROM hablaSobre h2
    WHERE h2.milesSeguidores > h1.milesSeguidores
);

-- 18 - ORDER BY

SELECT medio FROM hablaSobre
ORDER BY milesSeguidores DESC
FETCH NEXT 1 ROWS ONLY;


-- 19. Categorías de las que tenemos 2 o más canales.

-- Previo: categorías y (código de) canales

SELECT tematicas.nombre, hablaSobre.codigoStreamer
FROM tematicas 
    JOIN hablaSobre 
    ON tematicas.codigo = hablaSobre.codigoTematica;
    
-- Consulta real

SELECT tematicas.nombre, COUNT(*)
FROM tematicas 
    JOIN hablaSobre 
    ON tematicas.codigo = hablaSobre.codigoTematica
GROUP BY tematicas.nombre
HAVING COUNT(*) >= 2;
    

-- 20. Categorías de las que no tenemos anotado ningún canal, ordenadas, empleando COUNT.

SELECT tematicas.nombre, COUNT(hablaSobre.codigoStreamer)
FROM tematicas 
    LEFT JOIN hablaSobre 
    ON tematicas.codigo = hablaSobre.codigoTematica
GROUP BY tematicas.nombre
HAVING COUNT(hablaSobre.codigoStreamer) = 0;


-- 21. Categorías de las que no tenemos anotado ningún canal, ordenadas, empleando IN / NOT IN.

SELECT tematicas.nombre
FROM tematicas 
WHERE tematicas.codigo NOT IN
(
    SELECT codigoTematica FROM hablaSobre
);

-- 22. Categorías de las que no tenemos anotado ningún canal, ordenadas, empleando ALL / ANY.

SELECT tematicas.nombre
FROM tematicas 
WHERE tematicas.codigo <> ALL
(
    SELECT codigoTematica FROM hablaSobre
);


-- 23. Categorías de las que no tenemos ningún canal, ordenadas, empleando EXISTS / NOT EXISTS.

SELECT tematicas.nombre
FROM tematicas 
WHERE NOT EXISTS
(
    SELECT codigoTematica FROM hablaSobre
    WHERE codigoTematica = tematicas.codigo
);
