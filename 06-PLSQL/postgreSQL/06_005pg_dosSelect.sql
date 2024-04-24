-- Fes en dos passos, en PL/SQL, l'equivalent a:

-- SELECT nom FROM jocs WHERE anyLlancament =
-- (
--     SELECT MAX(anyLlancament) FROM jocs
-- );

DO
$$
DECLARE
    anyModern NUMERIC(4);
    nomJoc VARCHAR(50);
BEGIN
    SELECT max(anyLlancament)
        INTO anyModern
        FROM jocs;
        
    SELECT nom
        INTO nomJoc
        FROM jocs
        WHERE anyLlancament = anyModern;
    
    RAISE NOTICE '%', nomJoc;
END;
$$
