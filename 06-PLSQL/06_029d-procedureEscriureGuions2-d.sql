-- Crea un procediment "EscriureGuions" millorat, que escriga 
-- diversos guions en l'eixida de la base de dades, tants com 
-- s'indiquen en un paràmetre numèric (d'entrada). Si s'indica
-- un número superior a 100, només escriurà 100.

-- Variant 4: Paràmetres "IN OUT"

CREATE OR REPLACE PROCEDURE EscriureGuions(num IN OUT NUMBER) 
IS
    guions VARCHAR2(100);
BEGIN
    IF num > 100 THEN
        num := 100;
    END IF;
    
    FOR i IN 1..num LOOP
        guions := guions || '-';
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(guions);

END EscriureGuions;

--

DECLARE
    num NUMBER := 150;
BEGIN
    EscriureGuions(num);
END;
