/*
Crea una versió millorada de l'exercici anterior: a partir de les dades 
de la taula de jocs, crea un script que guarde en una variable la 
quantitat de jocs que tenim de la plataforma el codi de la qual és 
"ps3". En una altra variable, guarda la quantitat de jocs que tenim de 
la plataforma el codi de la qual és "ps4". Finalment, mostra el 
missatge "Tenim més jocs de PS3 que de PS4", o bé "Tenim més jocs de 
PS4 que de PS3", o "Tenim la mateixa quantitat de jocs de PS3 que de 
PS4", segons corresponga.

Versió 1: ELSIF (l'alternativa raonable)
*/

DO
$$
DECLARE
    jocsPS3 jocs.codiPlataforma%type;
    jocsPS4 jocs.codiPlataforma%type;
BEGIN
    SELECT COUNT(*) 
        INTO jocsPS3
        FROM jocs
        WHERE codiPlataforma= 'PS3';

    SELECT COUNT(*) 
        INTO jocsPS4
        FROM jocs
        WHERE codiPlataforma= 'PS4';

    IF jocsPS3>jocsPS4 THEN
        RAISE NOTICE 'Tenim mes jocs de ps3 que de ps4';
    ELSIF jocsPS3<jocsPS4 THEN
        RAISE NOTICE 'Tenim mes jocs de ps4 que de ps3';
    ELSE
        RAISE NOTICE 'Tenim la mateixa quantitat de ps3 que de ps4';
    END IF;
END;
$$
