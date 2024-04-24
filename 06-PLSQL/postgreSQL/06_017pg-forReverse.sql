-- Crea un bucle FOR que mostre els números del 10 al 1, 
-- descomptant d'1 en 1.

DO
$$
BEGIN
    FOR num IN REVERSE 10 .. 1 LOOP  -- Atenció !
        RAISE NOTICE '%', num;
    END LOOP;
END;
$$
