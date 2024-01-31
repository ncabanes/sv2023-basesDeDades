-- A partir de les dades de països, has de mostrar:


-- La esperanza de vida (lifeExpectancy) truncada.

SELECT TRUNC(lifeExpectancy) FROM country; 


-- La esperanza de vida (lifeExpectancy) truncada redondeada a una cifra decimal.

SELECT ROUND(lifeExpectancy, 1) FROM country;


-- Nom, continent y año de independecia (o el texto "Desconegut", en vez de NULL, si esta fecha no se conoce.

-- SQLite

SELECT name, continent, IFNULL(IndepYear, 'Desconegut') FROM country;

-- Oracle

SELECT name, continent, NVL(TO_CHAR(IndepYear), 'Desconegut') FROM country;
