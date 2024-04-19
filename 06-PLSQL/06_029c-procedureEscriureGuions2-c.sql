-- Crea un procediment "EscriureGuions" millorat, que escriga 
-- diversos guions en l'eixida de la base de dades, tants com 
-- s'indiquen en un paràmetre numèric (d'entrada). Si s'indica
-- un número superior a 100, només escriurà 100.

-- Variant 3: EXIT

CREATE OR REPLACE PROCEDURE EscriureGuion(num IN NUMBER) 
IS
    almacena VARCHAR2(100) := '';
BEGIN 
    FOR i IN 1 .. num LOOP  
        almacena := almacena || '-';
        EXIT WHEN i = 100;
    END LOOP;
    dbms_output.put_line(almacena);
END EscriureGuion;

-- Bloc anònim

BEGIN
  EscriureGuion(103);
END;

-- Sense bloc anònim (Execute)

EXECUTE EscriureGuion(100);
