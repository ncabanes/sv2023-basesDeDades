-- Crea un bucle FOR que mostre els números del 20 al 200, 
-- augmentant de 10 en 10.

-- Forma que "funciona sempre"

DO
$$
DECLARE
    contador NUMERIC(4);
BEGIN 
    FOR i IN 2 .. 20 LOOP   
        RAISE NOTICE '%', i*10;
    END LOOP;
END;
$$

-- Forma alternativa, amb "BY", Ok en PostgreSQL

DO
$$
DECLARE
    contador NUMERIC(4);
BEGIN 
    FOR i IN 20 .. 200 BY 10 LOOP   
        RAISE NOTICE '%', i;
    END LOOP;
END;
$$
