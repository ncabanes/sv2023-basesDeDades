-- - Taula CATEGORIA (codi, nom, codCategPare)
-- - Taula PROGRAMA (codi, nom, descripc, codCategoria)


-- 1a.- Crea un procediment LlistarProgramesICategories, que, per
-- a cada programa, mostre el seu nom i el nom de la categoria a  
-- la qual pertany (o "(Sense categoritzar)", si és el cas). En
-- el teu cursor, hauràs d'emprar un bucle FOR.


-- 1b.- Crea una variant del procediment anterior, que es dirà 
-- LlistarProgramesICategories2, i que usarà un bucle LOOP.


-- 1c.- Crea una variant del procediment anterior, que es dirà 
-- LlistarProgramesICategories3, i que usarà un bucle WHILE.


-- ==========================================================


CREATE TABLE Categoria ( 
    codi VARCHAR2(5) PRIMARY KEY,
    nom VARCHAR2(50),
    codCategPare VARCHAR2(5)
);

CREATE TABLE Programa (
    codi VARCHAR2(5) PRIMARY KEY,
    nom VARCHAR2(50),
    descripc VARCHAR2(50),
    codCategoria VARCHAR2(5)
);

INSERT INTO CATEGORIA VALUES ('so', 'Sistemes operatius', NULL);
INSERT INTO CATEGORIA VALUES ('soco', 'Sistemes operatius de codi obert', 'so');
INSERT INTO CATEGORIA VALUES ('sop', 'Sistemes operatius propietaris', 'so');

INSERT INTO PROGRAMA VALUES ('wi10', 'Windows 10', 'Windows 10', 'sop');
INSERT INTO PROGRAMA VALUES ('WP55', 'WordPerfect 5.5', NULL, NULL);
