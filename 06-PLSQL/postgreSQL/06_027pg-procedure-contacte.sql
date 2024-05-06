-- PROCEDURE, primer contacte

CREATE OR REPLACE PROCEDURE EscriureDestacat(cadena IN VARCHAR) 
LANGUAGE plpgsql
AS
$$
BEGIN
    RAISE NOTICE '%', '--- ' || cadena || ' ---';
END;
$$

-- Alternatiu

CREATE OR REPLACE PROCEDURE EscriureDestacat(cadena IN VARCHAR) 
AS
$$
BEGIN
    RAISE NOTICE '%', '--- ' || cadena || ' ---';
END;
$$ LANGUAGE plpgsql;

-- Llançar el procediment

CALL EscriureDestacat('Hola');
