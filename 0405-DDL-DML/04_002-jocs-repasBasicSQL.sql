-- Jocs V1

-- Crea una taula per a guardar informació de jocs de videoconsola: 
-- codi, nom, plataforma i any de llançament

.open jocsV1

CREATE TABLE jocs
(
    codi CHAR(4) PRIMARY KEY,
    nom VARCHAR(20),
    plataforma VARCHAR(5),
    any_ll NUMERIC(4)
);

-- Afig tres dades d'exemple

INSERT INTO jocs VALUES ('tlou', 'The last of us', 'ps3', 2013);
INSERT INTO jocs VALUES ('rdr2', 'Read dead redemption 2', 'steam', 2019);
INSERT INTO jocs VALUES ('smg2', 'Super Mario Galaxy 2', 'wii', 2010);

-- Mostra el nom de tots els jocs

SELECT nom FROM jocs;

-- Mostra totes les dades dels jocs de la plataforma "*ps3"

SELECT * FROM jocs WHERE plataforma = 'ps3';
