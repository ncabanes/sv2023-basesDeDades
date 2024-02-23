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

-- 6. Mostra la quantitat d'apartats que té cada exercici.

-- 7. Afig un nou concepte, detallant tots els camps en l'orde INSERT: EX - EXIST / NOT EXIST

INSERT INTO conceptes (codi, nom) VALUES ('4.058', 'Actors');


-- 8. Has de corregir el concepte "EX": ha de ser "EXISTS / NOT EXISTS".

-- 9, 10, 11, 12. Mostra el nom de l'exercici que més apartats tinga, de 4 formes diferents.

-- 13. Modifica la taula "apartats" per a afegir un camp "descripcio".

-- 14. Mostra els apartats per als quals encara no tenim descripció.

-- 15, 16. Mostra els apartats el número dels quals estiga entre 1 i 5 i pertanguen a l'exercici 4.058, de 2 formes diferents

-- 17. Esborra el concepte "F1", si existix.

-- 18. Mostra el codi i nom de l'exercici, juntament amb el nom de l'apartat, per als repassos del concepte CREATE TABLE.

-- 19, 20, 21. Mostra els conceptes que comencen per "CREA" (potser amb majúscules diferents), de 3 formes diferents.

-- 22. Mostra nom i codi dels dos últims exercicis (segons orde alfabètic)
