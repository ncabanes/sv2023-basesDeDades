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
INSERT INTO mascotes VALUES (6,'Raul','Periquito',NULL);


-- Noms de propietaris i de mascotes, en una única columna

SELECT nom FROM propietaris
UNION
SELECT nom FROM mascotes;

-- Mascotes que es diuen com algun propietari (4 formes)

SELECT nom FROM mascotes
INTERSECT
SELECT nom FROM propietaris;

SELECT mascotes.nom FROM mascotes, propietaris
WHERE mascotes.nom = propietaris.nom;

SELECT nom FROM mascotes
WHERE EXISTS
(
  SELECT nom FROM propietaris
  WHERE mascotes.nom = propietaris.nom
)

SELECT nom FROM mascotes
WHERE nom = ANY
(
  SELECT nom FROM propietaris
);

-- Mascotes que no es diguen com cap propietari

SELECT nom FROM mascotes
MINUS
SELECT nom FROM propietaris;

SELECT nom FROM mascotes
EXCEPT
SELECT nom FROM propietaris;

SELECT nom FROM mascotes
WHERE NOT EXISTS
(
  SELECT nom FROM propietaris
  WHERE mascotes.nom = propietaris.nom
);

SELECT nom FROM mascotes
WHERE nom <> ALL
(
  SELECT nom FROM propietaris
);

-- Noms de mascotes, noms de propietaris excepte els que coincidisquen

