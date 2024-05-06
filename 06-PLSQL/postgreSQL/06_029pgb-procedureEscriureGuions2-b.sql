-- Crea un procediment "EscriureGuions" millorat, que escriga 
-- diversos guions en l'eixida de la base de dades, tants com 
-- s'indiquen en un paràmetre numèric (d'entrada). Si s'indica
-- un número superior a 100, només escriurà 100.

-- Variant 2: Variable auxiliar amb valor prefixat

CREATE OR REPLACE PROCEDURE EscriureGuions(quantitat IN NUMERIC)
LANGUAGE plpgsql
AS
$$
DECLARE
    guions VARCHAR(100):='';
    nguions_aux NUMERIC(3) := quantitat;
BEGIN
    
    IF nguions_aux>100 THEN
        nguions_aux := 100;
    END IF;

    FOR i IN 1..nguions_aux LOOP
        guions:= guions || '-';
    END LOOP;

    RAISE NOTICE '%', guions;

END;
$$

--

CALL EscriureGuions(300);
