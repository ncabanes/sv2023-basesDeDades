-- Crea un bucle FOR que mostre els números del 10 al 1, 
-- descomptant d'1 en 1.

BEGIN
    FOR num IN REVERSE 1 .. 10 LOOP
        dbms_output.put_line(num);
    END LOOP;
END;
