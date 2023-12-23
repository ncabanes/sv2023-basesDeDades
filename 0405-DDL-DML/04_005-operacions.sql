-- Mostra el nom ("name") de cada país (taula "country"), 
-- juntament amb la seua població ("population") en milions d'habitants.

SELECT name, population / 1000000 as popMillions 
FROM country;
