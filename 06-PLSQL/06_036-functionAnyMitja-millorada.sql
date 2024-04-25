-- Crea una funció anomenada "AnyMitja", que reba com a paràmetre el 
-- codi d'una plataforma de jocs i retorne la mitjana dels anys de 
-- llançament dels jocs que pertanyen a aqueixa plataforma. 
-- Si no existix cap dada d'eixa plataforma, retornarà -1
-- Mostra el seu valor per a la plataforma amb codi "cpc".

CREATE OR REPLACE FUNCTION AnyMitja(
    codiPlataf IN CHAR
)
RETURN NUMBER AS

    mitjanaAnys NUMBER(4);

BEGIN
    SELECT AVG(anyLlancament)
    INTO mitjanaAnys
    FROM jocs
    WHERE codiPlataforma = codiPlataf;
    
    IF mitjanaAnys IS NULL THEN
        mitjanaAnys := -1;
    END IF;

    RETURN mitjanaAnys;

END AnyMitja;

BEGIN
    dbms_output.put_line('Any mitjà de DAW: '|| AnyMitja('DAW'));
END;

-- Alternativa

SELECT AnyMitja('DAW') FROM dual;
