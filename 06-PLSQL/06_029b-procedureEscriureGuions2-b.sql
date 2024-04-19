-- Crea un procediment "EscriureGuions" millorat, que escriga 
-- diversos guions en l'eixida de la base de dades, tants com 
-- s'indiquen en un paràmetre numèric (d'entrada). Si s'indica
-- un número superior a 100, només escriurà 100.

-- Variant 2: Variable auxiliar amb valor prefixat

CREATE OR REPLACE PROCEDURE EscriureGuions(nGuions IN Number)
AS
    guions VARCHAR2(100):='';
    nguions_aux NUMBER(3):=nGuions;
BEGIN
    
    IF nguions_aux>100 THEN
        nguions_aux := 100;
    END IF;

    FOR i IN 1..nguions_aux LOOP
        guions:= guions || '-';
    END LOOP;

    dbms_output.put_line(guions);

END EscriureGuions;

--

EXECUTE EscriureGuions(300);
