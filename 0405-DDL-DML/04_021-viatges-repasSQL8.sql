CREATE TABLE viatges ( 
  codi VARCHAR(5) PRIMARY KEY, 
  nom VARCHAR(25),
  preu NUMERIC(5),
  dies NUMERIC(3)
);

INSERT INTO viatges VALUES ('dp', 'Disneyland Paris', 118, 3);
INSERT INTO viatges VALUES ('pr', 'Praga', 194, 3);
INSERT INTO viatges VALUES ('na', 'Nápoles', NULL, NULL);
INSERT INTO viatges VALUES ('ro', 'Roma', 191, 3);
INSERT INTO viatges VALUES ('lp', 'Laponia', 1730, 5);
INSERT INTO viatges VALUES ('ri', 'Riviera Maya', 772, 9);
INSERT INTO viatges VALUES ('rm', 'Roma', 460, 4);

-- 1. Mostra els viatges (nom i preu) de 5 dies o més.

SELECT nom, preu
FROM viatges
WHERE dies >= 5;

-- 2. Mostra el codi i el nom dels viatges que no siguen de 3 dies, ordenat per nom.

SELECT codi, nom
FROM viatges
WHERE dies <> 3
ORDER BY nom;


-- 3. Obtingues el nom dels viatges per als quals no coneixem preu.

SELECT nom
FROM viatges
WHERE preu IS NULL;


-- 4. Mostra els viatges que siguen a Roma o a Nápoles.

SELECT *
FROM viatges
WHERE nom = 'Roma' OR nom = 'Nápoles';

SELECT *
FROM viatges
WHERE nom IN ('Roma', 'Nápoles');

-- 5. Mostra els viatges a ciutats que comencen per P i que costen 
no més de 200 euros.

SELECT *
FROM viatges
WHERE nom LIKE 'P%'
AND preu <= 200;

SELECT *
FROM viatges
WHERE nom LIKE 'P%'
AND NOT preu > 200;


-- 6. Mostra la quantitat de viatges i la seua duració mitjana.

SELECT COUNT(*), AVG(dies)
FROM viatges;


-- 7. Mostra els noms de les ciutats, sense duplicats, ordenats.

SELECT DISTINCT nom
FROM viatges
ORDER BY nom;


-- 8. Mostra, per a cada viatge, el nom de la ciutat, juntament amb el preu per dia.

SELECT nom, preu / dies AS preuPerDia
FROM viatges;

-- 9. Mostra la quantitat de viatges que tenim a cada ciutat.

SELECT nom, COUNT(*)
FROM viatges
GROUP BY nom;

-- 10. Mostra la quantitat de viatges que tenim a cada ciutat, però només per a les ciutats en les quals hi haja més d'un viatge disponible.

SELECT nom, COUNT(*)
FROM viatges
GROUP BY nom
HAVING COUNT(*) > 1;



--------

-- 1. Muestra los viajes (nombre y precio) de 5 días o más.
-- 2. Muestra el código y el nombre de los viajes que no sean de 3 días, ordenado por nombre.
-- 3. Obtén el nombre de los viajes para los que no conocemos precio.
-- 4. Muestra los viajes que sean a Roma o a Nápoles.
-- 5. Muestra los viajes a ciudades que empiecen por P y que cuesten no más de 200 euros.
-- 6. Muestra la cantidad de viajes y su duración media.
-- 7. Muestra los nombres de las ciudades, sin duplicados, ordenados.
-- 8. Muestra, para cada viaje, el nombre de la ciudad, junto con el precio por día.
-- 9. Muestra la cantidad de viajes que tenemos a cada ciudad.
-- 10. Muestra la cantidad de viajes que tenemos a cada ciudad, pero sólo para las ciudades en las que haya más de un viaje disponible.
