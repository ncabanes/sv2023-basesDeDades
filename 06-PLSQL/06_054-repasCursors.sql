-- - Taula CATEGORIA (codi, nom, codCategPare)
-- - Taula PROGRAMA (codi, nom, descripc, codCategoria)

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


-- 1a.- Crea un procediment LlistarProgramesICategories, que, per
-- a cada programa, mostre el seu nom i el nom de la categoria a  
-- la qual pertany (o "(Sense categoritzar)", si és el cas). En
-- el teu cursor, hauràs d'emprar un bucle FOR.

CREATE OR REPLACE PROCEDURE LlistarProgramesICategories
IS
    CURSOR cursor_aux IS
        SELECT categoria.nom as nom_cat,
                programa.nom as nom_pro
                FROM programa LEFT JOIN categoria
                    ON codCategoria = categoria.codi;
BEGIN
    FOR i IN cursor_aux LOOP
        IF i.nom_cat IS NULL THEN
            DBMS_OUTPUT.PUT_LINE(i.nom_pro || ' Sense categoritzar');
        ELSE
            DBMS_OUTPUT.PUT_LINE(i.nom_pro || ' ' || i.nom_cat);
        END IF;
    END LOOP;
END LlistarProgramesICategories;

EXECUTE LlistarProgramesICategories;


-- 1b.- Crea una variant del procediment anterior, que es dirà 
-- LlistarProgramesICategories2, i que usarà un bucle LOOP.

CREATE OR REPLACE PROCEDURE LlistarProgramesICategories2
IS
    vNomCat categoria.nom%TYPE;
    vNomProg programa.nom%TYPE;

    CURSOR cursor_aux IS
        SELECT categoria.nom as nom_cat,
                programa.nom as nom_pro
                FROM programa LEFT JOIN categoria
                    ON codCategoria = categoria.codi;
BEGIN
    OPEN cursor_aux;
     LOOP
        FETCH cursor_aux INTO vNomCat, vNomProg;
        EXIT WHEN cursor_aux%NOTFOUND;
        IF vNomCat IS NULL THEN
            DBMS_OUTPUT.PUT_LINE(vNomProg || ' Sense categoritzar');
        ELSE
            DBMS_OUTPUT.PUT_LINE(vNomProg || ' ' || vNomCat);
        END IF;
    END LOOP;
    CLOSE cursor_aux;
END LlistarProgramesICategories2;

EXECUTE LlistarProgramesICategories2;


-- 1c.- Crea una variant del procediment anterior, que es dirà 
-- LlistarProgramesICategories3, i que usarà un bucle WHILE.

CREATE OR REPLACE PROCEDURE LlistarProgramesICategories3
IS
    vNomCat categoria.nom%TYPE;
    vNomProg programa.nom%TYPE;

    CURSOR cursor_aux IS
        SELECT categoria.nom as nom_cat,
                programa.nom as nom_pro
                FROM programa LEFT JOIN categoria
                    ON codCategoria = categoria.codi;
BEGIN
    OPEN cursor_aux;
    FETCH cursor_aux INTO vNomCat, vNomProg;
     while cursor_aux%FOUND LOOP
        IF vNomCat IS NULL THEN
            DBMS_OUTPUT.PUT_LINE(vNomProg || ' Sense categoritzar');
        ELSE
            DBMS_OUTPUT.PUT_LINE(vNomProg || ' ' || vNomCat);
        END IF;
        FETCH cursor_aux INTO vNomCat, vNomProg;
    END LOOP;
    CLOSE cursor_aux;
END LlistarProgramesICategories3;

EXECUTE LlistarProgramesICategories3;

