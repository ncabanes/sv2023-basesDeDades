-- Afig una nova dada en la taula "anotacions" i comprova 
-- el seu número de registre amb "RETURNING".

DO
$$
DECLARE
    ContadorAnotacions NUMERIC(5);
BEGIN
    INSERT INTO anotacions (num, texto) VALUES(DEFAULT, 'Exemple')
    RETURNING num INTO ContadorAnotacions;
    
    RAISE NOTICE '%', ContadorAnotacions;
END;
$$

--

DO
$$
DECLARE
    ContadorAnotacions NUMERIC(5);
BEGIN
    INSERT INTO anotacions (texto) VALUES('Exemple 2')
    RETURNING num INTO ContadorAnotacions;
    
    RAISE NOTICE '%', ContadorAnotacions;
END;
$$

--

SELECT * FROM anotacions;
