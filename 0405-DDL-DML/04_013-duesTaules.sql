-- A partir de la taula de països i la de ciutats:

-- Mostra el codi del país "Espanya" ("Spain")

SELECT code
FROM country
WHERE name='Spain';


-- Noms de ciutats d'Espanya (codi de país "ESP"), ordenades alfabèticament

SELECT name
FROM city
WHERE countryCode = 'ESP'
ORDER BY name;


-- Noms de ciutats d'Espanya (nom de país "Spain"), ordenades alfabèticament

-- Incorrecte (producte cartesià):

SELECT city.name
FROM city, country
WHERE country.name = 'Spain';

-- Correcte

SELECT city.name
FROM city, country
WHERE country.name = 'Spain'
AND country.code = city.countryCode
ORDER BY city.name;


-- Quantitat de ciutats de "Argentina"

SELECT COUNT(*)
FROM city, country
WHERE country.code = city.countryCode
AND country.name = 'Argentina';


-- Nom i població de les ciutats de "Estats Units" ("United States")
-- amb menys de 100.000 habitants, ordenat de la més poblada
-- a la menys poblada.

SELECT city.name, city.population
FROM city, country
WHERE country.code = city.countryCode
AND country.name = 'United States'
AND city.population < 100000
ORDER BY city.population DESC;



-- Per a cada país el nom del qual comença per "U", nom de cadascun 
-- dels districtes (city.district) que ho formen i població total 
-- cadascun d'eixos districtes.

(...)
