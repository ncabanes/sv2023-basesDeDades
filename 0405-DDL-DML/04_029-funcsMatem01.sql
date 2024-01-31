-- A partir de les dades de països, has de mostrar:


--Població en milions de persones

SELECT name, population/1000000 AS milions FROM country;

-- Resta de dividir cada població entre 1000

SELECT name, MOD(population,1000) AS resta FROM country;

-- Cada GNP elevat al quadrat

SELECT name, POWER(gnp,2) AS quadratPIB FROM country;

-- Arrel cuadrada de cada superfície (surfaceArea)

SELECT name, SQRT(surfaceArea) AS arrelSuperf FROM country;
