CREATE TABLE canals (
  codi VARCHAR(4) PRIMARY KEY,
  nom VARCHAR(15)
);

CREATE TABLE series (
  codi VARCHAR(5) PRIMARY KEY,
  nom VARCHAR(20),
  temporades NUMERIC(3),
  codiCanal VARCHAR(4),
  FOREIGN KEY (codiCanal) REFERENCES canals(codi)
);

INSERT INTO canals VALUES ('hbo', 'HBO Max');
INSERT INTO canals VALUES ('d+', 'Disney+');
INSERT INTO canals VALUES ('nf', 'Netflix');
INSERT INTO canals VALUES ('amz', 'Amazon');

INSERT INTO series VALUES ('si', 'Los Simpsons', 34, 'd+');
INSERT INTO series VALUES ('man', 'The mandalorian', 2, 'd+');
INSERT INTO series VALUES ('ar', 'Arcane', 1, 'nf');
INSERT INTO series VALUES ('ryan', 'Jack Ryan', 3, 'amz');
INSERT INTO series VALUES ('exp', 'The expanse', 6, 'amz');
INSERT INTO series VALUES ('ro', 'Roswell, New Mexico', 4, 'hbo');
INSERT INTO series VALUES ('strng', 'Stranger Things', NULL, NULL);
INSERT INTO series VALUES ('boys', 'The boys', 3, 'amz');

-------------

-- 1. Mostra els noms de les sèries de Amazon, ordenades alfabèticament.

SELECT series.nom 
FROM series, canals 
WHERE canals.codi = series.codiCanal
AND canals.nom = 'Amazon'
ORDER BY series.nom;

SELECT series.nom 
FROM series JOIN canals 
ON canals.codi = series.codiCanal
WHERE canals.nom = 'Amazon'
ORDER BY series.nom;


-- 2. Mostra els noms de les sèries que no contenen una "a" en el seu nom.

SELECT nom FROM series WHERE nom NOT LIKE '%a%';

SELECT nom FROM series WHERE nom NOT LIKE '%a%' AND nom NOT LIKE '%A%';
SELECT nom FROM series WHERE UPPER(nom) NOT LIKE '%A%';


-- 3. Mostra els noms de les sèries i els noms del canal que les emeten, per a les sèries de 2 temporades o 4 temporades.

SELECT series.nom, canals.nom 
FROM series, canals 
WHERE canals.codi = series.codiCanal
AND (temporades = 2 OR temporades = 4);

SELECT series.nom, canals.nom
FROM series JOIN canals 
ON canals.codi = series.codiCanal
WHERE temporades = 2 OR temporades = 4;

-- Oracle

SELECT series.nom AS nomSerie, canals.nom AS nomCanal
FROM series JOIN canals 
ON canals.codi = series.codiCanal
WHERE temporades = 2 OR temporades = 4;


-- 4. Noms de les sèries per a les quals coneixem la cadena que les emet.

SELECT nom FROM series WHERE codiCanal IS NOT NULL;

-- 5. Duració mitjana i màxima (en temporades) de les sèries que coneixem.

SELECT AVG(temporades), MAX(temporades) FROM series;

-- 6. Nom de cada canal i quantitat de sèries que coneixem per a aqueix canal.

SELECT canals.nom, COUNT(*)
FROM series JOIN canals 
ON canals.codi = series.codiCanal
GROUP BY canals.nom;


-- 7. Nom de cada canal i temporades de la sèrie amb més temporades per a aqueix canal.

SELECT canals.nom, MAX(series.temporades)
FROM series JOIN canals 
ON canals.codi = series.codiCanal
GROUP BY canals.nom;


-- 8. Quantitats de temporades i sèries que duren aqueixa quantitat de setmanes (per exemple, per a 34 setmanes tenim 1 sèrie, i per a 3 setmanes tenim 2 sèries).

SELECT temporades, COUNT(*)
FROM series
GROUP BY temporades;


-- 9. Noms de les sèries  i dels canals, en una única columna, ordenats alfabèticament.

SELECT * FROM
(
	SELECT nom FROM series 
	UNION
	SELECT nom FROM canals
)
ORDER BY nom;


-- 10. Nom de cada canal i quantitat de sèries que coneixem per a aqueix canal, però només per als canals en els quals coneixem més d'una sèrie.

SELECT canals.nom, COUNT(*)
FROM series JOIN canals 
ON canals.codi = series.codiCanal
GROUP BY canals.nom
HAVING COUNT(*) > 1;


-------------

-- (Enunciado en castellano)

-- 1. Muestra los nombres de las series de Amazon, ordenadas alfabéticamente.
-- 2. Muestra los nombres de las series que no contienen una "a" en su nombre.
-- 3. Muestra los nombres de las series y los nombres del canal que las emiten, para las series de 2 temporadas o 4 temporadas.
-- 4. Nombres de las series para las que conocemos la cadena que las emite.
-- 5. Duración media y máxima (en temporadas) de las series que conocemos.
-- 6. Nombre de cada canal y cantidad de series que conocemos para ese canal.
-- 7. Nombre de cada canal y temporadas de la serie con más temporadas para ese canal.
-- 8. Cantidades de temporadas y series que duran esa cantidad de semanas (por ejemplo, para 34 semanas tenemos 1 serie, y para 3 semanas tenemos 2 series).
-- 9. Nombres de las series y de los canales, en una única columna, ordenados alfabéticamente.
-- 10. Nombre de cada canal y cantidad de series que conocemos para ese canal, pero sólo para los canales en los que conocemos más de una serie.

-------------