-- Afig una nova dada en la taula "anotacions" i comprova 
-- el seu número de registre amb "RETURNING".

DECLARE
    ContadorAnotacions NUMBER(5);
BEGIN
    INSERT INTO anotacions (num, descripcio)
    VALUES(contadorNum.NEXTVAL, 'Example ' || contadorNum.NEXTVAL)
    RETURNING num INTO ContadorAnotacions;
END;
