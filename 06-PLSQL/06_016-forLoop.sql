-- Crea un bucle FOR que mostre els números del 20 al 30.

BEGIN
    FOR num IN 20 .. 30 LOOP
        dbms_output.put_line(num);
    END LOOP;
END;
