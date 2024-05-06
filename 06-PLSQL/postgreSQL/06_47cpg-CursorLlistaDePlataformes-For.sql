-- Crea una funció "Llista De Plataformes", que empre un 
-- cursor per a obtindre la llista de totes les plataformes, 
-- en una mateixa línia, ordenades alfabèticament i separades 
-- per " - " (espai, guió, espai).

-- V3: Cursor + FOR

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
    FOR v_cursor IN cursorPLats LOOP
        cadena := cadena || v_cursor.nom || ' - ';
    END LOOP;
    RETURN cadena;
END;
$$

--

SELECT LlistaDePlataformes();
