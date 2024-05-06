-- Crea un procediment "EscriureGuions" millorat, que escriga 
-- diversos guions en l'eixida de la base de dades, tants com 
-- s'indiquen en un paràmetre numèric (d'entrada). Si s'indica
-- un número superior a 100, només escriurà 100.

-- Variant 3: EXIT

CREATE OR REPLACE PROCEDURE EscriureGuions(quantitat IN NUMERIC) 
LANGUAGE plpgsql
AS
$$
DECLARE
    almacena VARCHAR(100) := '';
BEGIN 
    FOR i IN 1 .. quantitat LOOP  
        almacena := almacena || '-';
        EXIT WHEN i = 100;
    END LOOP;
    RAISE NOTICE '%', almacena;
END;
$$

-- 

CALL EscriureGuions(100);
