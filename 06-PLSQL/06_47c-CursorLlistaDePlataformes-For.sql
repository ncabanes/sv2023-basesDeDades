-- Crea una funció "Llista De Plataformes", que empre un 
-- cursor per a obtindre la llista de totes les plataformes, 
-- en una mateixa línia, ordenades alfabèticament i separades 
-- per " - " (espai, guió, espai).

-- V3: Cursor + FOR

CREATE OR REPLACE FUNCTION LlistaDePlataformes
RETURN VARCHAR2 AS
    CURSOR cursorPlats AS
        SELECT nom FROM plataformes ORDER BY nom;
    cadena VARCHAR2(200) := '';

BEGIN
    FOR v_cursor IN cursorPLats LOOP
        cadena := cadena || v_cursor.nom || ' - ';
    END LOOP;
    RETURN cadena;
END LlistaDePlataformes;

--

BEGIN
    dbms_output.put_line(LlistaDePlataformes);
END;
