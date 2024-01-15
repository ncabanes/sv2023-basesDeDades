CREATE TABLE propietaris 
(
    codi NUMERIC(5) PRIMARY KEY, 
    nom VARCHAR(50), 
    cognoms VARCHAR(100), 
    telefon NUMERIC(9)
);

CREATE TABLE mascotes 
(
    codi NUMERIC(5) PRIMARY KEY,
    nom VARCHAR(50),
    tipus VARCHAR(60),
    codiPropietari VARCHAR(5)
);

INSERT INTO propietaris VALUES (1,'Fernando','Garcia',654123851);
INSERT INTO propietaris VALUES (2,'Andrea','Perez',654165851);
INSERT INTO propietaris VALUES (3,'Angel','Rodriguez',663175851);
INSERT INTO propietaris VALUES (4,'Raul','Sanchez',663167851);
INSERT INTO propietaris VALUES (5,'Josep','Garcia',663157851);

INSERT INTO mascotes VALUES (1,'Nieve','Pastor aleman',2);
INSERT INTO mascotes VALUES (2,'Pluto','Mezcla',1);
INSERT INTO mascotes VALUES (3,'Coco','Pastor Belga',3);
INSERT INTO mascotes VALUES (4,'Tara','Podenco',4);
INSERT INTO mascotes VALUES (5,'Ricky','Pastor aleman',2);

-- 1. Nom i cognoms dels propietaris.

SELECT nom, cognoms
FROM propietaris;

-- 2. Nom i cognoms dels propietaris amb un codi inferior al 3.

SELECT nom, cognoms
FROM propietaris
WHERE codi < 3;

-- 3. Nom i cognoms dels propietaris amb un codi que no siga 2.

SELECT nom, cognoms
FROM propietaris
WHERE codi <> 2;

-- 4. Noms de les mascotes el nom de les quals no comença per P.

SELECT nom
FROM mascotes
WHERE nom NOT LIKE 'P%';

-- 5. Noms de les mascotes, al costat dels noms dels seus propietaris.

SELECT mascotes.nom AS nom_mascotes, propietaris.nom AS nom_propietari
FROM mascotes, propietaris
WHERE mascotes.codipropietari = propietaris.codi;

-- 6. Noms de les mascotes de "Raul".

SELECT mascotes.nom AS nom_mascotes, propietaris.nom AS nom_propietari
FROM mascotes, propietaris
WHERE mascotes.codipropietari = propietaris.codi
AND propietaris.nom = 'Raul';

-- 7. Noms de les mascotas que siguen algun tipus de "Pastor", ordenat alfabèticament.

SELECT nom
FROM mascotes
WHERE tipus LIKE 'Pastor%'
ORDER BY nom;

-- 8. Quantitat de mascotes.

SELECT COUNT(*)
FROM mascotes;

-- 9. Telèfon amb el número més baix.

SELECT MIN(telefon)
FROM propietaris;

-- 10. Noms dels tipus de mascotes que apareixen en la nostra base de dades 
-- (sense duplicats)

SELECT DISTINCT tipus
FROM mascotes;

-- 11. Quantitat de mascotes que tenim de cada tipus.

SELECT tipus, COUNT(tipus)
FROM mascotes
GROUP BY tipus;

-- 12. Tipus de mascotes de les quals tenim informació de 2 o més animals.

SELECT tipus, COUNT(tipus) as quantitat
FROM MASCOTES
GROUP BY tipus
HAVING quantitat >=2;

-- 13. Cognom i nom de cada propietari, juntament amb la seua quantitat de mascotes.

SELECT cognoms, p.nom, COUNT(m.CODIPROPIETARI)
FROM MASCOTES m, PROPIETARIS p
WHERE p.codi = codipropietari
GROUP BY p.nom, cognoms;

-- 14. Quantitat de cognoms (diferents) que apareixen en la nostra base de dades.

SELECT COUNT(DISTINCT cognoms)
FROM propietaris;

-- 15. Cognoms que apareixen repetits en la nostra base de dades.

SELECT cognoms
FROM propietaris
GROUP BY cognoms
HAVING COUNT(cognoms) > 1;
