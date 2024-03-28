/*
Crea un bucle WHILE que mostre els números del 10 al 100, 
augmentant de 10 en 10.
*/

DECLARE
    contador NUMBER(3) := 10;
BEGIN
    WHILE contador <=100 LOOP 
        dbms_output.put_line(contador);
        contador := contador+10;
    END LOOP; 
END;
