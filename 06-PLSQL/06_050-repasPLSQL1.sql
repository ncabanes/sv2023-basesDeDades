-- A partir d'una taula com aquesta:
-- 
-- CREATE TABLE ingredients(
--     codi CHAR(4) PRIMARY KEY, 
--     nom VARCHAR2(30),
--     preuKg NUMBER(7,5)
-- );


-- 1.- Crea un procediment "MostrarMesCars", que mostre els noms i preus 
-- dels ingredients el preu dels quals està per damunt de la mitjana.

-- Previ 1: Creació i inserció de dades d'exemple

CREATE TABLE ingredients(
    codi CHAR(4) PRIMARY KEY, 
    nom VARCHAR2(30),
    preuKg NUMBER(7,5)
);

INSERT INTO ingredients VALUES ('lim', 'Limones', 1.89);
INSERT INTO ingredients VALUES ('cha', 'Champiñones', 4.76);

-- Previ 2: Consulta SQL

SELECT nom, preuKg FROM ingredients
WHERE preuKg > (SELECT AVG(preuKg) FROM ingredients)
ORDER BY nom;

-- Previ 3: Resposta completa 1, amb FOR però encara sense PROCEDURE

DECLARE
    CURSOR cursorIngred IS
        SELECT nom, preuKg FROM ingredients
        WHERE preuKg > (SELECT AVG(preuKg) FROM ingredients)
        ORDER BY nom;
BEGIN
    FOR i IN cursorIngred LOOP
        dbms_output.put_line(i.nom || ', ' || i.preuKg);
    END LOOP;
END;


-- Resposta real, PROCEDURE a partir del FOR

CREATE OR REPLACE PROCEDURE MostrarMesCars AS
    CURSOR cursorIngred IS
        SELECT nom, preuKg FROM ingredients
        WHERE preuKg > (SELECT AVG(preuKg) FROM ingredients)
        ORDER BY nom;
BEGIN
    FOR i IN cursorIngred LOOP
        dbms_output.put_line(i.nom || ', ' || i.preuKg);
    END LOOP;
END MostrarMesCars;

-- Resposta real, part 2: exemple d'ús

EXECUTE MostrarMesCars;


-- 2.- Crea una funció "PreuMitja", que reba com a paràmetre un cert text 
-- i retorne el preu mitjà dels ingredients que contenen aqueix text com a 
-- part del seu nom (potser amb majúscules diferents). Si no existeix cap, 
-- retornarà 0.

-- Previ: prova de la consulta SQL

SELECT AVG(preuKg) FROM ingredients
WHERE UPPER(nom) LIKE '%ON%';

-- Resposta real, FUNCTION a partir d'aqueixa consulta

CREATE OR REPLACE FUNCTION PreuMitja(v_text IN VARCHAR2)
RETURN NUMBER
AS
    v_preu NUMBER;

BEGIN 
    SELECT AVG(preuKg) INTO v_preu    
    FROM ingredients
    WHERE UPPER(nom) LIKE '%' || UPPER(v_text) || '%';
    
    IF v_preu IS NULL THEN
        RETURN 0;
    ELSE
        RETURN v_preu;
    END IF;
END PreuMitja;

-- Prova

EXECUTE dbms_output.put_line(PreuMitja('ON'));
EXECUTE dbms_output.put_line(PreuMitja('on'));
EXECUTE dbms_output.put_line(PreuMitja('os'));


-- 3.- Usa un cursor i un bucle LOOP per a mostrar els noms dels 
-- ingredients per als quals no coneixem el preu, ordenats alfabèticament.

-- Previ 1: dades addicionals de prova

INSERT INTO ingredients VALUES ('nar', 'Naranjas', NULL);
INSERT INTO ingredients VALUES ('mel', 'Melocotones', NULL);

-- Previ 2: consulta SQL per a comprovar

SELECT * FROM ingredients WHERE preuKg IS NULL ORDER BY nom;

-- Resposta real, amb bloc anònim, cursor i LOOP

DECLARE
    CURSOR cursorIngred IS
        SELECT nom
        FROM ingredients
        WHERE preuKg IS NULL
        ORDER BY nom;

    v_nom ingredients.nom%TYPE;

BEGIN
    OPEN cursorIngred;
    LOOP
        FETCH cursorIngred INTO v_nom;
        EXIT WHEN cursorIngred % NOTFOUND;
        dbms_output.put_line(v_nom);
    END LOOP;
    CLOSE cursorIngred;
END;


-- 4.- Usa un cursor i un bucle WHILE per a mostrar els noms dels 
-- ingredients que tenim repetits (amb igual nom però diferent codi), 
-- ordenats alfabèticament.

-- Previ 1: dada addicional de prova

INSERT INTO ingredients VALUES ('naj', 'Naranjas', 1.89);

-- Previ 2: consulta SQL per a comprovar

SELECT nom FROM ingredients 
GROUP BY nom
HAVING COUNT(*) > 1
ORDER BY nom;

-- Resposta real, amb bloc anònim, cursor i WHILE

DECLARE
    CURSOR cursorIngred IS
        SELECT nom FROM ingredients 
        GROUP BY nom
        HAVING COUNT(*) > 1
        ORDER BY nom;

    v_nom ingredients.nom%TYPE;

BEGIN
    OPEN cursorIngred;
    FETCH cursorIngred INTO v_nom;
    WHILE cursorIngred % FOUND LOOP
        dbms_output.put_line(v_nom);
        FETCH cursorIngred INTO v_nom;
    END LOOP;
    CLOSE cursorIngred;
END;


-- 5.- Crea un procediment "MostrarDetalls", que reba com a paràmetre el 
-- nom d'un ingredient (potser amb majúscules diferents) i mostre el seu 
-- codi, nom i preu, o bé el text "No trobat" en cas que no existisca, o 
-- el text "Trobat més d'una vegada" en cas que estiga repetit. Has 
-- d'emprar excepcions.

CREATE OR REPLACE PROCEDURE MostrarDetalls (v_text IN VARCHAR2) 
AS
    v_ingred ingredients % ROWTYPE;
        
BEGIN
    SELECT * 
    INTO v_ingred
    FROM ingredients
    WHERE UPPER(nom) = UPPER(v_text)
    ORDER BY nom;
    
    dbms_output.put_line(v_ingred.codi 
        || ' - ' || v_ingred.nom || ' - ' || v_ingred.preuKg);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No trobat');
    WHEN TOO_MANY_ROWS THEN
        dbms_output.put_line('Trobat més d''una vegada');

END MostrarDetalls;

-- Prova 1: Dada no duplicada

EXECUTE MostrarDetalls('Limones');

-- Prova 2: Dada no existent

EXECUTE MostrarDetalls('Manzanas');

-- Prova 3: Dada duplicada

EXECUTE MostrarDetalls('Naranjas');



-------

-- A partir de una tabla como ésta:
-- 
-- CREATE TABLE ingredients(
--     codi CHAR(4) PRIMARY KEY, 
--     nom VARCHAR2(30),
--     preuKg NUMBER(7,5)
-- );
-- 
-- 1.- Crea un procedimiento "MostrarMesCars", que muestre los nombres y 
-- precios de los ingredientes cuyo precio está por encima de la media.
-- 
-- 2.- Crea una función "PreuMitja", que reciba como parámetro un cierto 
-- texto y devuelva el precio medio de los ingredientes que contienen ese 
-- texto como parte de su nombre (quizá con mayúsculas distintas). Si no 
-- existe ninguno, devolverá 0.
-- 
-- 3.- Usa un cursor y un bucle LOOP para mostrar los nombres de los 
-- ingredientes para los que no conocemos el precio, ordenados 
-- alfabéticamente.
-- 
-- 4.- Usa un cursor y un bucle WHILE para mostrar los nombres de los 
-- ingredientes que tenemos repetidos (con igual nombre pero distinto 
-- código), ordenados alfabéticamente.
-- 
-- 5.- Crea un procedimiento "MostrarDetalls", que reciba como parámetro 
-- el nombre de un ingrediente (quizá con mayúsculas distintas) y muestre 
-- su código, nombre y precio, o bien el texto "No encontrado" en caso de 
-- que no exista, o el texto "Encontrado más de una vez" en caso de que 
-- esté repetido. Debes emplear excepciones.
