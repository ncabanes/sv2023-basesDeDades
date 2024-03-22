-- Prepara una variant de l'exercici anterior, emprant %TYPE

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
    
    dbms_output.put_line(nomJoc);
END;
