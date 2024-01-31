-- A partir de les dades de països, has de mostrar:


--Nom i regió en majúscules

SELECT UPPER(name), UPPER(region) FROM country;


-- Regions en minúscule, sense repetits, precedides per "Regió: "

-- Oracle

SELECT DISTINCT CONCAT('Regió: ', LOWER(region)) FROM country;

-- SQLite

SELECT DISTINCT 'Regió: ' || LOWER(region) FROM country;


-- Caràcter 97 del codi ASCII

-- Oracle

SELECT CHR(97);

-- SQLite

SELECT CHAR(97);
