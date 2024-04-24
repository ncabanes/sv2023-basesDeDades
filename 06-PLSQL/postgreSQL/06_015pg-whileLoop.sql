/*
Crea un bucle WHILE que mostre els números del 10 al 100, 
augmentant de 10 en 10.
*/

DO
$$
DECLARE
    contador NUMERIC(3) := 10;
BEGIN
    WHILE contador <=100 LOOP 
        RAISE NOTICE '%', contador;
        contador := contador+10;
    END LOOP; 
END;
$$
