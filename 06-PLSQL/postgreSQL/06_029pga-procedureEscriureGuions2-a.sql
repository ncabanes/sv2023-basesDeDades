-- Crea un procediment "EscriureGuions" millorat, que escriga 
-- diversos guions en l'eixida de la base de dades, tants com 
-- s'indiquen en un paràmetre numèric (d'entrada). Si s'indica
-- un número superior a 100, només escriurà 100.

-- Variant 1: IF i variable auxiliar

CREATE OR REPLACE PROCEDURE EscriureGuions(
    quantitat IN NUMERIC) 
LANGUAGE plpgsql
AS
$$
DECLARE
    guions VARCHAR(100) := '';
    quantGuions NUMERIC;
BEGIN
    IF quantitat > 100 THEN
        quantGuions := 100;
    ELSE
        quantGuions := quantitat;
    END IF;
        
    FOR i IN 1 .. quantGuions LOOP
        guions := guions || '-';
    END LOOP;
    
    RAISE NOTICE '%', guions;
END;
$$

--

CALL EscriureGuions(10);
