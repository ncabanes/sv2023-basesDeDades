-- Exercicis (codi i nom)
-- Apartats en cada exercici (número + restricció d'identificador)
-- Conceptes (codi i nom)
-- Relació "és de" (M:M) entre apartats i conceptes: 
--   cada apartat pot tractar d'un o diversos conceptes, 
--   i cada concepte es pot repassar en diversos apartats

-- 1.- Crea la taula de exercicis

CREATE TABLE exercicis (
    codi VARCHAR2(5),
    nom VARCHAR2(50),
    CONSTRAINT pk_exercicis PRIMARY KEY(codi)
);


-- 2.- Crea la taula d`apartats

CREATE TABLE apartats (
    codi_exercici VARCHAR2(5),
    num NUMBER(3),
    CONSTRAINT pk_apartats PRIMARY KEY(codi_exercici, num),
    CONSTRAINT fk_apartats_exercicis FOREIGN KEY(codi_exercici)
        REFERENCES exercicis(codi)
);


-- 3.- Crea la taula de "és de", per a relacionar amb esta taula de conceptes

CREATE TABLE conceptes (
    codi VARCHAR(5) PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE esDe (
    codi_exercici VARCHAR2(5),
    num_apartat NUMBER(3),
    codi_concepte VARCHAR2(5),
    CONSTRAINT pk_esDe PRIMARY KEY(codi_exercici, num_apartat),
    CONSTRAINT fk_esDe_exercicis1 FOREIGN KEY(codi_exercici)
        REFERENCES exercicis(codi),
    CONSTRAINT fk_esDe_exercicis2 FOREIGN KEY(codi_exercici)
        REFERENCES exercicis(codi),
    CONSTRAINT fk_esDe_conceptes FOREIGN KEY(codi_concepte)
        REFERENCES conceptes(codi)
);


-- 4. Afig les següents dades:
-- 
--     Conceptes: CT - CREATE TABLE, SC - SUBCONSULTES
--     Exercicis: 4.058 - Actors
--     Apartats: 4.058 - 1
--     És de: 4.058 - 1 - CT

INSERT INTO exercicis VALUES ('4.058', 'Actors');

INSERT INTO conceptes VALUES 
('CT', 'CREATE TABLE'),
('SC', 'SUBCONSULTES');

INSERT INTO apartats VALUES ('4.058', '1');

INSERT INTO esDe VALUES ('4.058', '1', 'CT');


-- 5. Mostra els noms de conceptes, ordenats alfabèticament.

SELECT nom
FROM conceptes 
ORDER BY nom;


-- 6. Mostra la quantitat d'apartats que té cada exercici.

SELECT nom, COUNT(*) AS Quantitat_Apartats
FROM exercicis JOIN apartats 
ON exercicis.codi = apartats.codi_exercici 
GROUP BY nom;


-- 7. Afig un nou concepte, detallant tots els camps en l'orde INSERT: EX - EXIST / NOT EXIST

INSERT INTO conceptes(codi, nom) VALUES ('EX', 'EXIST / NOT EXIST');


-- 8. Has de corregir el concepte "EX": ha de ser "EXISTS / NOT EXISTS".

UPDATE conceptes 
SET nom = 'EXISTS / NOT EXISTS'
WHERE codi = 'EX';


-- 9, 10, 11, 12. Mostra el nom de l'exercici que més apartats tinga, de 4 formes diferents.

-- 9a LIMIT (SQLite)

SELECT nom
FROM exercicis JOIN apartats 
ON exercicis.codi = apartats.codi_exercici 
GROUP BY nom
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 9b FETCH (Oracle)

SELECT nom
FROM exercicis JOIN apartats 
ON exercicis.codi = apartats.codi_exercici 
GROUP BY nom
ORDER BY COUNT(*) DESC
FETCH NEXT 1 ROWS ONLY;

-- 10 COUNT = MAX

SELECT nom 
FROM exercicis JOIN apartats 
ON exercicis.codi = apartats.codi_exercici 
GROUP BY nom 
HAVING COUNT(*) =
(
    SELECT MAX(quantitat)  FROM (
        SELECT COUNT(*) AS quantitat
        FROM exercicis JOIN apartats 
        ON exercicis.codi = apartats.codi_exercici 
        GROUP BY nom 
    )
);

-- 11 ALL (No en SQLite)ç

SELECT nom
FROM exercicis JOIN apartats 
ON exercicis.codi = apartats.codi_exercici 
GROUP BY nom 
HAVING COUNT(*) >= ALL
(
    SELECT COUNT(*)
    FROM exercicis JOIN apartats 
    ON exercicis.codi = apartats.codi_exercici 
    GROUP BY nom 
);

-- 12 Not Exists

SELECT e1.nom
FROM exercicis e1 JOIN apartats a1
ON e1.codi = a1.codi_exercici 
GROUP BY e1.nom 
HAVING NOT EXISTS
(
    SELECT e2.nom
    FROM exercicis e2 JOIN apartats a2
    ON e2.codi = a2.codi_exercici 
    GROUP BY e2.nom 
    HAVING COUNT(a2.num) > COUNT(a1.num)
);


-- 13. Modifica la taula "apartats" per a afegir un camp "descripcio".

-- Oracle

ALTER TABLE apartats ADD (descripcio VARCHAR2(50));

-- SQLite

ALTER TABLE apartats ADD COLUMN descripcio VARCHAR2(50);


-- 14. Mostra els apartats per als quals encara no tenim descripció.

SELECT descripcio 
FROM apartats 
WHERE descripcio IS NULL;


-- 15, 16. Mostra els apartats el número dels quals estiga entre 1 i 5 i pertanguen a l'exercici 4.058, de 2 formes diferents

SELECT num 
FROM apartats 
WHERE num BETWEEN 1 AND 5 AND codi_exercici = '4.058';

SELECT num 
FROM apartats 
WHERE num >= 1 AND num <= 5 AND codi_exercici = '4.058';


-- 17. Esborra el concepte "F1", si existix.

DELETE FROM conceptes WHERE codi = 'F1';


-- 18. Mostra el codi i nom de l'exercici, juntament amb el nom de l'apartat, per als repassos del concepte CREATE TABLE.

SELECT e.codi, a.num, e.nom 
FROM exercicis e JOIN apartats a
ON e.codi = a.codi_exercici 
JOIN esde 
ON a.codi_exercici = esde.codi_exercici AND a.num = esde.num_apartat
JOIN conceptes c
ON esde.codi_concepte = c.codi 
WHERE UPPER(c.nom) = 'CREATE TABLE';


-- 19, 20, 21. Mostra els conceptes que comencen per "CREA" (potser amb majúscules diferents), de 3 formes diferents.

--Substring

SELECT *
FROM conceptes 
WHERE UPPER(SUBSTR(nom,1,4)) = 'CREA';

--Instr

SELECT *
FROM conceptes 
WHERE INSTR(UPPER(nom),'CREA') = 1;

--Like

SELECT *
FROM conceptes 
WHERE UPPER(nom) LIKE 'CREA%';


-- 22. Mostra nom i codi dels dos últims exercicis (segons orde alfabètic)

-- Oracle

SELECT nom, codi
FROM exercicis 
ORDER BY nom DESC
FETCH NEXT 2 ROWS ONLY;

-- SQLite

SELECT nom, codi
FROM exercicis 
ORDER BY nom DESC
LIMIT 2;
