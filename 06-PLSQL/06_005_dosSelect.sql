-- Fes en dos passos, en PL/SQL, l'equivalent a:

-- SELECT nom FROM jocs WHERE anyLlancament =
-- (
--     SELECT MAX(anyLlancament) FROM jocs
-- );

DECLARE
    anyModern NUMBER(4);
    nomJoc VARCHAR2(50);
BEGIN
    SELECT max(anyLlancament)
        INTO anyModern
        FROM jocs;
        
    SELECT nom
        INTO nomJoc
        FROM jocs
        WHERE anyLlancament = anyModern;
    
    dbms_output.put_line(nomJoc);
END;
