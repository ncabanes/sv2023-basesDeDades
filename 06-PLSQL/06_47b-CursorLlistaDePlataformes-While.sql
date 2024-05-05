-- Crea una funció "Llista De Plataformes", que empre un 
-- cursor per a obtindre la llista de totes les plataformes, 
-- en una mateixa línia, ordenades alfabèticament i separades 
-- per " - " (espai, guió, espai).

-- V2: Cursor + WHILE

CREATE OR REPLACE FUNCTION LlistaDePlataformes
RETURN VARCHAR2 AS
    CURSOR cursorPlats AS
        SELECT nom FROM plataformes ORDER BY nom;
    nomP plataformes.nom%TYPE;
    cadena VARCHAR2(200) := '';

BEGIN
    OPEN cursorPlats;
    FETCH cursorPlats INTO nomP;
    
    WHILE cursorPlats % FOUND LOOP
        cadena := cadena || nomP || ' - ';
        FETCH cursorPlats INTO nomP;
    END LOOP;
    CLOSE cursorPlats;
    RETURN cadena;
END LlistaDePlataformes;

--

BEGIN
    dbms_output.put_line(LlistaDePlataformes);
END;
