/*
Crea un bucle LOOP que mostre els números del 10 al 100, augmentant de 
10 en 10. Has d'emprar la sintaxi EXIT WHEN.
*/

DO
$$
DECLARE
    i NUMERIC(4) := 10;
BEGIN
    LOOP
        RAISE NOTICE '%', i;
        EXIT WHEN i >= 100;
        i := i + 10;
    END LOOP;
END;
$$
