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
INSERT INTO hablaSobre VALUES ('ill','var','Español','Twitch',12800);;
INSERT INTO hablaSobre VALUES ('ap','var','Español','Twitch',14900);
INSERT INTO hablaSobre VALUES ('ng','inf','Español','YouTube',2450);
INSERT INTO hablaSobre VALUES ('ltt','inf','Inglés','YouTube',15200);
INSERT INTO hablaSobre VALUES ('dyip','bri','Inglés','YouTube',4140);
INSERT INTO hablaSobre VALUES ('ach','bri','Inglés','YouTube',370);
INSERT INTO hablaSobre VALUES ('cad','inf','Inglés','YouTube',3);


-- 01. Nombre de las temáticas que tenemos almacenadas, ordenadas alfabéticamente.
-- 02. Cantidad de streamers cuyo país es "España".
-- 03, 04, 05. Nombres de streamers cuya segunda letra no sea una "B" (quizá en minúsculas), de 3 formas distintas.
-- 06. Media de suscriptores para los canales cuyo idioma es "Español".
-- 07. Media de seguidores para los canales cuyo streamer es del país "España".
-- 08. Nombre de cada streamer y medio en el que habla, para aquellos que tienen entre 5.000 y 15.000 miles de seguidores, usando BETWEEN.
-- 09. Nombre de cada streamer y medio en el que habla, para aquellos que tienen entre 5.000 y 15.000 miles de seguidores, sin usar BETWEEN.
-- 10. Nombre de cada temática y nombre de los idiomas en que tenemos canales de esa temática (quizá ninguno), sin duplicados.
-- 11. Nombre de cada streamer, nombre de la temática de la que habla y del medio en el que habla de esa temática, usando INNER JOIN.
-- 12. Nombre de cada streamer, temática y medio en el que habla de esa temática, usando WHERE.
-- 13. Nombre de cada streamer, del medio en el que habla y de la temática de la que habla en ese medio, incluso si de algún streamer no tenemos dato del medio o de la temática.
-- 14. Nombre de cada medio y cantidad de canales que tenemos anotados en él, ordenado alfabéticamente por el nombre del medio.
-- 15, 16, 17, 18. Medio en el que se emite el canal de más seguidores, de 4 formas distintas.
-- 19. Categorías de las que tenemos 2 o más canales.
-- 20. Categorías de las que no tenemos anotado ningún canal, ordenadas, empleando COUNT.
-- 21. Categorías de las que no tenemos anotado ningún canal, ordenadas, empleando IN / NOT IN.
-- 22. Categorías de las que no tenemos anotado ningún canal, ordenadas, empleando ALL / ANY.
-- 23. Categorías de las que no tenemos ningún canal, ordenadas, empleando EXISTS / NOT EXISTS.
