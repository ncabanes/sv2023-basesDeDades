-- PROCEDURE, primer contacte

CREATE OR REPLACE PROCEDURE EscriureDestacat(cadena IN VARCHAR2) IS
BEGIN 
    dbms_output.put_line('--- ' || cadena || ' ---');
END EscriureDestacat;

-- Bloc anònim

BEGIN
EscriureDestacat('Hola');
END;

-- Sense bloc anònim (Execute)

EXECUTE EscriureDestacat('Hola');
