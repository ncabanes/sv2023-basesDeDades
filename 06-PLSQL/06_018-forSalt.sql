-- Crea un bucle FOR que mostre els números del 20 al 200, 
-- augmentant de 10 en 10.

-- Forma que "funciona sempre"

DECLARE
    contador NUMBER(4);
BEGIN 
    FOR i IN 2 .. 20 LOOP   
        dbms_output.put_line(i*10);
    END LOOP;
END;

-- Forma alternativa, amb "BY"

DECLARE
    contador NUMBER(4);
BEGIN 
    FOR i IN 20 .. 200 BY 10 LOOP   
        dbms_output.put_line(i);
    END LOOP;
END;
