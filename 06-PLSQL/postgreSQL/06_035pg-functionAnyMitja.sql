-- Crea una funció anomenada "AnyMitja", que reba com a paràmetre el 
-- codi d'una plataforma de jocs i retorne la mitjana dels anys de 
-- llançament dels jocs que pertanyen a aqueixa plataforma. 
-- Mostra el seu valor per a la plataforma amb codi "cpc".


CREATE OR REPLACE FUNCTION AnyMitja(
    codiPlataf IN CHAR
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
DECLARE
    mitjanaAnys NUMERIC(4);

BEGIN
    SELECT AVG(anyLlancament)
    INTO mitjanaAnys
    FROM jocs
    WHERE codiPlataforma = codiPlataf;

    RETURN mitjanaAnys;

END;
$$

-- 

SELECT AnyMitja('cpc');
