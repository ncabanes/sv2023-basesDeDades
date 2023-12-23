-- Mostra el nom ("name") de cada país (taula "country"), juntament amb la 
-- seua població ("population") en milions d'habitants. Has d'ordenar del 
-- país més poblat almenys poblat. En cas de coincidir la població, ordena 
-- alfabèticament per nom.

SELECT name, population / 1000000 AS popMillions 
FROM country
ORDER BY popMillions DESC, name ASC;
