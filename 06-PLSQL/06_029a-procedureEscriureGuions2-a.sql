-- Crea un procediment "EscriureGuions" millorat, que escriga 
-- diversos guions en l'eixida de la base de dades, tants com 
-- s'indiquen en un paràmetre numèric (d'entrada). Si s'indica
-- un número superior a 100, només escriurà 100.

-- Variant 1: IF i variable auxiliar

CREATE OR REPLACE PROCEDURE EscriureGuions(
    numGuions IN NUMBER) 
IS
    guions VARCHAR2(100) := '';
    cantGuions NUMBER;
BEGIN
    IF numGuions > 100 THEN
        cantGuions := 100;
    ELSE
        cantGuions := numGuions;
    END IF;
        
    FOR i IN 1 .. cantGuions LOOP
        guions := guions || '-';
    END LOOP;
    
    dbms_output.put_line(guions);
END EscriureGuions;

EXECUTE EscriureGuions(10);
