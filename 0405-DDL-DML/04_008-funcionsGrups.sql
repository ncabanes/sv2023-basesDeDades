nader Antón - 1º DAW

--Quantitat de dades introduïdes
SELECT COUNT(code) FROM country;

-- Població(Population) del país més poblat
SELECT MAX(Population) FROM country;

-- Població del país menys poblat
SELECT MIN(Population) FROM country;

--Població mitjana dels països de la base de dades
SELECT AVG(Population) AS PopAverage FROM country;

--Població total entre tots els països registrats
SELECT SUM(Population) AS PopSum FROM country;
