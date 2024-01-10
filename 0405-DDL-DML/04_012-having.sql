-- HAVING
-- A partir de la taula de països:

-- Mostra cada codi de país (CountryCode) juntament amb la quantitat 
-- de ciutats que conté, però només els casos en què continguen 
-- més de 50 ciutats.

SELECT CountryCode, COUNT(Name) AS quantitatCiutat 
FROM city
GROUP BY CountryCode
HAVING quantitatCiutat >= 50;

SELECT CountryCode, COUNT(Name) 
FROM city
GROUP BY CountryCode
HAVING COUNT(Name) >= 50;


-- Mostra cada codi de país (CountryCode) juntament amb la 
-- població (Population) mitjana de les seues ciutats, per 
-- als casos en què eixa població mitjana siga inferior a 100.000.

SELECT CountryCode, AVG(Population) 
FROM city
GROUP BY CountryCode
HAVING AVG(Population) < 10000;


-- Mostra cada codi de país (CountryCode) juntament amb la major
-- població (Population) de les seues ciutats, només si 
-- eixa dada és inferior a 5000 

SELECT CountryCode, MAX(Population) 
FROM city
GROUP BY CountryCode
HAVING MAX(Population) < 5000;
