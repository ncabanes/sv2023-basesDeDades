-- A partir de les dades de països, has de mostrar:

-- Les quatre primeres lletres de les regions.

SELECT SUBSTR(region,1,4) FROM country;


-- Regions, reemplaçant "Europe" per "Eu.".

SELECT REPLACE(region, 'Europe', 'Eu.') FROM country;

-- Nota: no es guarden els canvis. Es podrien fer canvis permanents amb:

-- UPDATE country
-- SET region = REPLACE(region, 'Europe', 'Eu.');


-- Regions, reemplaçant "Europe" per "Eu." i "America" per "Am.".

-- Previ:

-- SELECT REPLACE(region, 'Europe', 'Eu.') FROM country;
-- SELECT REPLACE(region, 'America', 'Am.') FROM country;

SELECT REPLACE( 
	REPLACE(region, 'America', 'Am.'),
	'Europe', 'Eu.') 
FROM country;
