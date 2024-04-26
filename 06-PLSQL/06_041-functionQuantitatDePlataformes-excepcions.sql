-- Crea una nova versió de la funció "QuantitatDePlataformes", 
-- que retorne el text "cap", "una", més d'una", segons quantes 
-- plataformes hi haja en la nostra base de dades. 
-- No has d'emprar COUNT sinó EXCEPTION.

CREATE OR REPLACE FUNCTION QuantitatDePlataformes
RETURN VARCHAR AS

    vPlataforma plataformes.nom % TYPE;

BEGIN
    SELECT nom
    INTO vPlataforma
    FROM plataformes;
    
    RETURN 'una';
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'cap';
        WHEN TOO_MANY_ROWS THEN
            RETURN 'més d''una';
END QuantitatDePlataformes;

BEGIN
    dbms_output.put_line('Plataformes: '|| QuantitatDePlataformes);
END;

-- Alternativa

SELECT QuantitatDePlataformes FROM dual;
