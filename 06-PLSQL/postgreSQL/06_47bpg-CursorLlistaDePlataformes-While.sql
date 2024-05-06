-- Crea una funció "Llista De Plataformes", que empre un 
-- cursor per a obtindre la llista de totes les plataformes, 
-- en una mateixa línia, ordenades alfabèticament i separades 
-- per " - " (espai, guió, espai).

-- V2: Cursor + WHILE

CREATE OR REPLACE FUNCTION LlistaDePlataformes()
RETURNS VARCHAR
LANGUAGE plpgsql
AS
$$
DECLARE
    cursorPlats CURSOR FOR
        SELECT nom FROM plataformes ORDER BY nom;
    nomP plataformes.nom%TYPE;
    cadena VARCHAR(400) := '';

BEGIN
    OPEN cursorPlats;
    FETCH cursorPlats INTO nomP;
    
    WHILE FOUND LOOP
        cadena := cadena || nomP || ' - ';
        FETCH cursorPlats INTO nomP;
    END LOOP;
    CLOSE cursorPlats;
    RETURN cadena;
END;
$$

--

SELECT LlistaDePlataformes();
