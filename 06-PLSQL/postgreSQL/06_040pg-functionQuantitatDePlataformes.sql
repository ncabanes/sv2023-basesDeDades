-- Crea una funció "QuantitatDePlataformes", que retorne el text "cap", 
-- "una", més d'una", segons quantes plataformes hi haja en la nostra base 
-- de dades. Has d'emprar COUNT.

CREATE OR REPLACE FUNCTION QuantitatDePlataformes()
RETURNS VARCHAR
LANGUAGE plpgsql
AS
$$
DECLARE
    quantitat NUMERIC(4);

BEGIN
    SELECT COUNT(*)
    INTO quantitat
    FROM plataformes;
    
    IF quantitat = 0 THEN
        RETURN 'cap';
    ELSIF quantitat = 1 THEN
        RETURN 'una';
    ELSE
        RETURN 'més d''una';
    END IF;

END;
$$

--

SELECT QuantitatDePlataformes();

