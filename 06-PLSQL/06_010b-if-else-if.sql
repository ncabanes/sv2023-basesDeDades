/*
Crea una versió millorada de l'exercici anterior: a partir de les dades 
de la taula de jocs, crea un script que guarde en una variable la 
quantitat de jocs que tenim de la plataforma el codi de la qual és 
"ps3". En una altra variable, guarda la quantitat de jocs que tenim de 
la plataforma el codi de la qual és "ps4". Finalment, mostra el 
missatge "Tenim més jocs de PS3 que de PS4", o bé "Tenim més jocs de 
PS4 que de PS3", o "Tenim la mateixa quantitat de jocs de PS3 que de 
PS4", segons corresponga.

Versió 2: ELSE + IF (l'alternativa millorable)
*/

DECLARE
    jocsPs3 NUMBER(5);
    jocsPs4 NUMBER(5);

BEGIN
    SELECT COUNT(codi)
        INTO jocsPs3
        FROM jocs
        WHERE codiPlataforma = 'ps3';

    SELECT COUNT(codi)
        INTO jocsPs4
        FROM jocs
        WHERE codiPlataforma ='ps4';

    IF jocsPs3 > jocsPs4 THEN
        dbms_output.put_line('Tenim mes jocs de ps3 que de ps4');
    ELSE 
        IF jocsPs4 > jocsPs3 THEN
            dbms_output.put_line('Tenim mes jocs de ps4 que de ps4');
        ELSE
            dbms_output.put_line('Tenim la mateixa quantitat');
        END IF;
    END IF;
END;
