-- PL/SQL: Cerca l'any del joc més modern i respon 
-- si és 2020, anterior o posterior

DO
$$
DECLARE 
    anyModern jocs.anyLlancament%TYPE;
BEGIN
    SELECT MAX(anyLlancament)
    INTO anyModern
    FROM jocs;
    
    IF anyModern > 2020 THEN
        RAISE NOTICE 'És posterior a 2020';
    ELSIF anyModern < 2020 THEN
        RAISE NOTICE 'És anterior a 2020';
    ELSE
        RAISE NOTICE 'És de 2020';
    END IF;
END;
$$
