-- Crea un bucle FOR que mostre els números del 20 al 30.

DO
$$
BEGIN
    FOR num IN 20 .. 30 LOOP
        RAISE NOTICE '%', num;
    END LOOP;
END;
$$
