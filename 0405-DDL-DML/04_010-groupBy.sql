-- GROUP BY
-- A partir de la taula de països:

-- Mostra els continents als quals pertanyen els països

SELECT continent FROM country;


-- - Mostra els continents als quals pertanyen els països, sense duplicats

SELECT DISTINCT continent FROM country;


-- Mostra els continents als quals pertanyen els països, 
-- sense duplicats, ordenats alfabèticament

SELECT DISTINCT continent FROM country
ORDER BY continent;


-- Mostra el nom de cada continent, juntament 
-- amb la quantitat de països que conté eixe continent

.mode column

SELECT continent, COUNT(*) AS amount
FROM country
GROUP BY continent;


-- Mostra el nom de cada continent, juntament amb la 
-- població mitjana dels països que conté eixe continent

SELECT continent, AVG(population) AS averagePop
FROM country
GROUP BY continent;


-- Mostra el nom de cada continent, juntament amb la 
-- població mitjana dels països que conté eixe continent.
-- ordenat alfabèticament per nom de país

SELECT continent, AVG(population) AS averagePop
FROM country
GROUP BY continent
ORDER BY averagePop DESC;

-- No en tots els gestors de bases de dades:

SELECT continent, AVG(population) AS averagePop
FROM country
GROUP BY continent
ORDER BY AVG(population) DESC;

-- Es pot ordenar sense necessitat de mostrar la dada:

SELECT continent
FROM country
GROUP BY continent
ORDER BY AVG(population) DESC;


-- Mostra les regions dels països, juntament amb la 
-- menor població que tenen els països d'eixa regió

SELECT region, MIN(population)
FROM country
GROUP BY region;


-- Mostra les regions dels països, juntament amb la 
-- major esperança de vida que hi ha als països d'eixa regió

SELECT region, MAX(lifeExpectancy)
FROM country
GROUP BY region;
   
-- Ordenat:

SELECT region, MAX(lifeExpectancy)
FROM country
GROUP BY region
ORDER BY MAX(lifeExpectancy);


-- Mostra el nom de cada continent, juntament amb 
-- la superfície mitjana dels països que el formen

SELECT continent, AVG(surfaceArea)
FROM country
GROUP BY continent;
