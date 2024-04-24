-- Prepara una variant de l'exercici anterior, emprant %TYPE

DO
$$
DECLARE
    anyModern jocs.anyLlancament % TYPE;
    nomJoc jocs.nom % TYPE;
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
