-- A partir de la taula "countrylanguage", mostra:

-- 1. La llista d'idiomes que es parlen en el món (el seu nom, sense duplicats, ordenat alfabèticament).

SELECT DISTINCT language
FROM countryLanguage
ORDER BY language;


-- 2. La quantitat d'idiomes "aparentment diferents" que es parlen en el món.

SELECT COUNT(DISTINCT language)
FROM countryLanguage;


-- 3, 4, 5. La llista d'idiomes el nom dels quals comença per "Ch", de 3 formes diferents.

-- 3: LIKE

SELECT DISTINCT language
FROM countryLanguage
WHERE language LIKE 'Ch%'
ORDER BY language;

-- 4: SUBSTR

SELECT DISTINCT language
FROM countryLanguage
WHERE SUBSTR(language, 1, 2) ='Ch'
ORDER BY language;

-- 5: INSTR

SELECT DISTINCT language
FROM countryLanguage
WHERE INSTR(language, 'Ch') = 1
ORDER BY language;


-- 6. La llista de codis de països en els quals es parla l'idioma "Spanish".

SELECT countryCode
FROM countryLanguage
WHERE language = 'Spanish'
ORDER BY countryCode;


-- Enllaçant amb la taula "country", mostra:

-- 7. El nom de cada país, i la quantitat d'idiomes que es parlen en ell.

-- Previ: amb el codi de país

SELECT countryCode, COUNT(*)
FROM countryLanguage
GROUP BY countryCode
ORDER BY countryCode;

-- Consulta completa

SELECT name, COUNT(*)
FROM countryLanguage, country
WHERE country.code = countryLanguage.countryCode
GROUP BY name
ORDER BY name;

-- Inclouent Antarctica

SELECT name, COUNT(language)
FROM country LEFT JOIN countryLanguage
ON country.code = countryLanguage.countryCode
GROUP BY name
ORDER BY name;

-- Comprovació: sense idiomes

SELECT name, COUNT(language)
FROM country LEFT JOIN countryLanguage
ON country.code = countryLanguage.countryCode
GROUP BY name
HAVING COUNT(language) = 0
ORDER BY name;


-- 8. El nom de cada país i el nom de l'idioma que més es parla en ell.

SELECT name, language
FROM country LEFT JOIN countryLanguage
ON country.code = countryLanguage.countryCode
WHERE percentage = 
(
   SELECT MAX(percentage) FROM countryLanguage c2
   WHERE country.code = c2.countryCode
);


-- 9. Crea una vista v_country_language que retorne totes les dades de cada país, creuats amb totes les dades d'idiomes que es parlen en eixos països (fins i tot si d'algun país no tenim informació sobre idiomes).

CREATE VIEW v_country_language AS
    SELECT * 
    FROM country LEFT JOIN countryLanguage
    ON country.code = countryLanguage.countryCode;

SELECT * FROM v_country_language
ORDER BY name, language;

-- 10. Mostra els noms dels països per als quals no coneixem idiomes, emprant la vista.

SELECT name FROM v_country_language
WHERE language IS NULL;


-- 11. Com a comparació, mostra els noms dels països per als quals no coneixem idiomes, sense emprar eixa vista.

SELECT name
FROM country LEFT JOIN countryLanguage
ON country.code = countryLanguage.countryCode
WHERE language IS NULL;


SELECT name, COUNT(language)
FROM country LEFT JOIN countryLanguage
ON country.code = countryLanguage.countryCode
GROUP BY countryCode
HAVING COUNT(language) = 0
ORDER BY countryCode;


-- 12. Mostra la població del país més poblat.

SELECT MAX(population) FROM country;


-- 13. Noms de països amb més població que la mitjana

SELECT name FROM country WHERE population >
(
    SELECT AVG(population) FROM country
)
ORDER BY name;


-- 14, 15, 16, 17. Mostra el nom del país més poblat, de quatre formes diferents.

-- 14: MAX

SELECT name FROM country WHERE population = 
(
    SELECT MAX(population) FROM country
);

-- 15: ALL / ANY

SELECT name FROM country WHERE population >=  ALL
(
    SELECT population FROM country
);

 -- 16: EXISTS / NOT EXISTS

SELECT name FROM country c1 WHERE NOT EXISTS
(
    SELECT name FROM country c2
    WHERE c2.population > c1.population
);


-- 17: LIMIT / FETCH

-- SQLite

SELECT name FROM country c 
ORDER BY population DESC
LIMIT 1;

-- Oracle

SELECT name FROM country c 
ORDER BY population DESC
FETCH FIRST 1 ROWS ONLY;


-- 18. Mostra el nom del segon país més poblat.

-- SQLite

SELECT name FROM country c 
ORDER BY population DESC
LIMIT 1 OFFSET 1;

-- Oracle

SELECT name FROM country c 
ORDER BY population DESC
OFFSET 1 ROWS
FETCH FIRST 1 ROWS ONLY;


-- 19. Mostra que idiomes es parlen al país (o països) en el qual més idiomes ens consta que es parlen.

--19a. Països i quantitat d'idiomes

SELECT name, COUNT(DISTINCT language)
FROM country LEFT JOIN countryLanguage
ON country.code = countryLanguage.countryCode
GROUP BY name;

-- 19b. Primer registre

SELECT name, COUNT(DISTINCT language)
FROM country LEFT JOIN countryLanguage
ON country.code = countryLanguage.countryCode
GROUP BY name
ORDER BY COUNT(DISTINCT language) DESC
FETCH FIRST 1 ROWS WITH TIES;

--19c. Consulta completa

SELECT name, language
FROM country JOIN countryLanguage
ON country.code = countryLanguage.countryCode
WHERE country.code IN
(
  SELECT country.code
  FROM country LEFT JOIN countryLanguage
  ON country.code = countryLanguage.countryCode
  GROUP BY name
  ORDER BY COUNT(DISTINCT language) DESC
  FETCH FIRST 1 ROWS WITH TIES
);


-- Enllaçant amb la taula "city", mostra:

-- 20. Al costat del nom de cada ciutat, el nom del país al qual pertany.

SELECT city.name AS cityName, country.name AS countryName
FROM city, country
WHERE city.countryCode = country.code
ORDER BY cityName, countryName;

SELECT city.name AS cityName, country.name AS countryName
FROM city JOIN country
ON city.countryCode = country.code
ORDER BY cityName, countryName;

-- 21. Al costat de cada ciutat, cadascun dels idiomes que es parla 
-- i la quantitat de parlants estimada d'eixe idioma.

-- Previ: ciutats i idiomes (1: WHERE)

SELECT city.name, language
FROM city, country, countryLanguage
WHERE city.countryCode = country.code
AND countryLanguage.countryCode = country.code
ORDER BY city.name, language;

-- Previ: ciutats i idiomes (2: JOIN)

SELECT city.name, language
FROM city JOIN country
    ON city.countryCode = country.code
    JOIN countryLanguage
        ON countryLanguage.countryCode = country.code
ORDER BY city.name, language;

-- Consulta completa (JOIN)

SELECT city.name, language, 
   ROUND(city.population * countryLanguage.percentage / 100) AS speakers
FROM city JOIN country
    ON city.countryCode = country.code
    JOIN countryLanguage
        ON countryLanguage.countryCode = country.code
ORDER BY city.name, language;



-- 22. El codi, nom, continent i població de cada país,
-- juntament amb el codi, nom i població de la seua capital, 
-- i amb cada idioma (nom, percentatge i si l'oficial o no).

SELECT country.code, country.name AS countryName, 
    continent, country.population AS countryPop,
    city.id, city.name AS cityName, city.population AS cityPop,
    language, percentage, isOfficial
FROM country LEFT JOIN city
    ON country.capital = city.id
    LEFT JOIN countryLanguage
        ON countryLanguage.countryCode = country.code
ORDER BY country.name, city.name, language;



-- 23. Ampliant la consulta anterior, mostra els idiomes oficials 
-- en les capitals dels països del continent "Europe".

SELECT country.code, country.name AS countryName, 
    continent, country.population AS countryPop,
    city.id, city.name AS cityName, city.population AS cityPop,
    language, percentage, isOfficial
FROM country LEFT JOIN city
    ON country.capital = city.id
    LEFT JOIN countryLanguage
        ON countryLanguage.countryCode = country.code
WHERE continent = 'Europe'
AND isOfficial = 'T'
ORDER BY country.name, city.name, language;

-- 24. Repetix la consulta anterior emprant una vista.

CREATE VIEW v_country_capital_language AS

    SELECT country.code, country.name AS countryName, 
        continent, country.population AS countryPop,
        city.id, city.name AS cityName, city.population AS cityPop,
        language, percentage, isOfficial
    FROM country LEFT JOIN city
        ON country.capital = city.id
        LEFT JOIN countryLanguage
            ON countryLanguage.countryCode = country.code
    ORDER BY country.name, city.name, language;


SELECT * FROM  v_country_capital_language
WHERE continent = 'Europe'
AND isOfficial = 'T';

-- 25. Bolca eixa informació a una taula anomenada "capitalsEuropa".

CREATE TABLE capitalsEuropa AS
    SELECT * FROM  v_country_capital_language
    WHERE continent = 'Europe'
    AND isOfficial = 'T';

SELECT * FROM capitalsEuropa;


-- 26. Modifica la dada de Madrid: una dada més actual de la seua població és 3332035.

UPDATE city SET population = 3332035 WHERE name = 'Madrid';


-- 27. Esborra la dada de "Torrejón de Ardoz", que hem considerat que no té suficients habitants.

DELETE FROM city
WHERE name = 'Torrejón de Ardoz';


-- 28. Crea una taula anomenada "ciutatsEspanya" amb camps: codi (numèric 5, clau), nom (text 35).

CREATE TABLE ciutatsEspanya
(
    codi NUMBER(5),
    nom VARCHAR2(46),
    CONSTRAINT pk_ciutatsEspanya PRIMARY KEY(codi)
);


-- 29. Amplia la taula anterior per a afegir un camp "població" (numèric 12).

ALTER TABLE ciutatsEspanya ADD (poblacio NUMBER(12));


-- 30. Introduïx en eixa taula les dades corresponents de les ciutats d'Espanya.

-- 30a. A partir del codi (no desitjable)

INSERT INTO ciutatsEspanya
SELECT id, name, population 
	FROM city
	WHERE countryCode = 'ESP';

-- 30b. Creuant amb la taula de països

INSERT INTO ciutatsEspanya
SELECT id, city.name, city.population 
	FROM city, country
	WHERE city.countryCode = country.code
	AND country.name = 'Spain';


-- 31. Mostra les ciutats, juntament amb la quantitat de parlants de 
-- idioma, per al país que ens aparega com a menys poblat (però amb 
-- població superior a 0) i del qual tinguem dades tant de ciutats 
-- com d'idiomes.

-- 31a - Nom del país menys poblat

SELECT country.name FROM country
WHERE population = 
(
   SELECT MIN(population) FROM country
   WHERE population > 0
);

-- 31b. Percentatges d'diomes al país menys poblat

SELECT countryLanguage.percentage 
FROM countryLanguage, country
WHERE countryLanguage.countryCode = country.code
AND country.population = 
(
   SELECT MIN(population) FROM country
   WHERE population > 0
);

-- 31c. Consulta completa

SELECT city.name, 
	countryLanguage.percentage * city.population / 100 AS speakers
FROM city, country, countryLanguage
WHERE countryLanguage.countryCode = country.code
AND city.countryCode = country.code
AND country.population = 
(
   SELECT MIN(population) FROM country
   WHERE population > 0
);



-- --------------------------------------------------

-- A partir de la tabla "countrylanguage", muestra:

-- 1. La lista de idiomas que se hablan en el mundo (su nombre, sin duplicados, ordenado alfabéticamente).

-- 2. La cantidad de idiomas "aparentemente distintos" que se hablan en el mundo.

-- 3, 4, 5. La lista de idiomas cuyo nombre empieza por "Ch", de 3 formas distintas.

-- 6. La lista de códigos de países en los que se habla el idioma "Spanish".

-- Enlazando con la tabla "country", muestra:

-- 7. El nombre de cada país, y la cantidad de idiomas que se hablan en él.

-- 8. El nombre de cada país y el nombre del idioma que más se habla en él.

-- 9. Crea una vista v_country_language que devuelva todos los datos de cada país, cruzados con todos los datos de idiomas que se hablan en esos países (incluso si de algún país no tenemos información sobre idiomas).

-- 10. Muestra los nombres de los países para los que no conocemos idiomas, empleando la vista.

-- 11. Como comparación, muestra los nombres de los países para los que no conocemos idiomas, sin emplear esa vista.

-- 12. Muestra la población del país más poblado.

-- 14, 15, 16, 17. Muestra el nombre del país más poblado, de cuatro formas distintas.

-- 18. Muestra que idiomas se hablan en el país (o países) en el que más idiomas nos consta que se hablan.

-- Enlazando con la tabla "city", muestra:

-- 19. Junto al nombre de cada ciudad, el nombre del país al que pertenece.

-- 20. Junto a cada ciudad, cada uno de los idiomas que se habla y la cantidad de parlantes estimada de ese idioma.

-- 21. El código, nombre, continente y población de cada país, junto con el código, nombre y población de su capital, y con cada idioma (nombre, porcentaje y si el oficial o no).

-- 22. Ampliando la consulta anterior, muestra los idiomas oficiales en las capitales de los países del continente "Europe".

-- 23. Repite la consulta anterior empleando una vista.

-- 24. Vuelca esa información a una tabla llamada "capitalsEuropa"-

-- 25. Modifica el dato de Madrid: un dato más actual de su población es 3332035.

-- 26. Borra el dato de "Torrejón de Ardoz", que hemos considerado que no tiene suficientes habitantes.

-- 27. Crea una tabla llamada "ciutatsEspanya" con campos: código (numérico 5, clave), nombre (texto 35).

-- 28. Amplía la tabla anterior para añadir un campo "población" (numérico 12).

-- 29. Inserta en esa tabla los datos correspondientes de las ciudades de España.

-- 30. Muestra las ciudades, junto con la cantidad de hablantes de cada idioma, para el país que nos aparezca como menos poblado (pero con población superior a 0) y del que tengamos datos tanto de ciudades como de idiomas.
