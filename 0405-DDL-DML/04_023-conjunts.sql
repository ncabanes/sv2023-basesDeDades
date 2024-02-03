-- A partir de les dades de països i ciutats...

-- Tots els noms, tant de ciutats com de països

SELECT name FROM city
UNION
SELECT name FROM country;

-- Tots els noms, tant de ciutats com de països... ordenats

SELECT * FROM 
(
  SELECT name FROM city
  UNION
  SELECT name FROM country
)
ORDER BY name;

-- Noms de ciutats que coincidisquen amb noms de països

SELECT name FROM city
INTERSECT
SELECT name FROM country;

-- Noms de ciutats que coincidisquen amb noms de països... ordenats

SELECT * FROM
(
  SELECT name FROM city
  INTERSECT
  SELECT name FROM country;
)
ORDER BY name;

-- Noms de països que no coincidisquen amb el nom d'una ciutat

-- Sintaxi de Oracle

SELECT name FROM country
MINUS
SELECT name FROM city;

-- En SQLite (també Oracle)

SELECT name FROM country
EXCEPT
SELECT name FROM city;


-- Noms de països i de presidents (!!!!) (HeadOfState), en una mateixa columna, ordenats


SELECT * FROM 
(
  SELECT name AS nom FROM country
  UNION
  SELECT HeadOfState AS nom FROM country
)
ORDER BY nom;

