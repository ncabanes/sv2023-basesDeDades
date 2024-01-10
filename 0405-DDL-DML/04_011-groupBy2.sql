-- GROUP BY (2)
-- A partir de la taula de països:

-- Mostra la quantitat de ciutats.

SELECT COUNT(*) FROM city;


-- Mostra la quantitat de codis de país (CountryCode).
SELECT COUNT(countryCode) FROM city;


-- Mostra la quantitat de codis de país (CountryCode) diferents.
SELECT COUNT(countryCode) FROM city;


-- Mostra cada codi de país (CountryCode) juntament amb la quantitat de ciutats que conté.
SELECT CountryCode, COUNT(Name) AS quantitatCiutat 
FROM city
GROUP BY CountryCode;


-- Mostra cada codi de país (CountryCode) juntament amb la població (Population) mitjana de les seues ciutats.
SELECT CountryCode, AVG(Population) AS averagePopulation 
FROM city
GROUP BY CountryCode;


-- Mostra cada codi de país (CountryCode) juntament amb la major població (Population) de les seues ciutats.

SELECT CountryCode, MAX(Population) AS maxPopulation 
FROM city
GROUP BY CountryCode;


-- Mostra la població de la ciutat més poblada de tota la taula.

SELECT MAX(Population) AS maxPopulation 
FROM city;


-- Mostra la quantitat de ciutats, juntament amb la quantitat de noms diferents de ciutats.
SELECT COUNT(*) AS quantitatCiutats, COUNT(DISTINCT name) FROM city;
