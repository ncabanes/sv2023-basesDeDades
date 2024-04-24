/*
A partir de les dades de la taula de jocs, crea un script que guarde en 
una variable la quantitat de jocs que tenim de la plataforma el codi de 
la qual és "ps3". En una altra variable, guarda la quantitat de jocs 
que tenim de la plataforma el codi de la qual és "ps4". Finalment, 
mostra el missatge "Tenim més jocs de PS3 que de PS4" o bé "No tenim 
més jocs de PS3 que de PS4", segons corresponga
*/

DO
$$
DECLARE
    jocsPs3 NUMERIC(5);
    jocsPs4 NUMERIC(5);

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
        RAISE NOTICE 'Tenim mes jocs de ps3 que de ps4';
    ELSE
        RAISE NOTICE 'No tenim mes jocs de ps3 que de ps4';
    END IF;
END;
$$
