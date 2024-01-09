-- Dades del país (country) amb codi ("code") “BGR”.

SELECT * FROM country WHERE code = 'BGR';

-- Nom (name) del país (country) amb codi ("code") "BHS".

SELECT name FROM country WHERE code = 'BHS';

-- Nom (name) i població (population) dels països (country) amb 20 habitants o menys.

SELECT name, population FROM country WHERE population <= 20;

-- Nom (name) dels països (country) el nom dels quals conté "fr".

SELECT name FROM country WHERE name LIKE '%fr%';

-- Nom (name) dels països (country) l'any d'independència (IndepYear) dels quals no es coneix.

SELECT name FROM country WHERE IndepYear IS NULL;

-- Nom (name) dels països (country) l'any d'independència (IndepYear) dels quals es troba entre 1965 i 1970.

SELECT name FROM country WHERE IndepYear BETWEEN 1965 AND 1970;
