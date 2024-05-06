-- Crea un procediment "EscriureGuions" millorat, que escriga 
-- diversos guions en l'eixida de la base de dades, tants com 
-- s'indiquen en un paràmetre numèric (d'entrada). Si s'indica
-- un número superior a 100, només escriurà 100.

-- Variant 4: Paràmetres "IN OUT"

CREATE OR REPLACE PROCEDURE EscriureGuions(quantitat IN OUT NUMERIC) 
LANGUAGE plpgsql
AS
$$
DECLARE
    guions VARCHAR(100) := '';
BEGIN
    IF quantitat > 100 THEN
        quantitat := 100;
    END IF;
    
    FOR i IN 1..quantitat LOOP
        guions := guions || '-';
    END LOOP;

    RAISE NOTICE '%', guions;
END;
$$

--

DO
$$
DECLARE
    num NUMERIC := 150;
BEGIN
    CALL EscriureGuions(num);
END;
$$
