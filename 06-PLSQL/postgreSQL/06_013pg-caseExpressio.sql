/*
A partir de les dades de la taula de plataformes (de jocs), crea un 
script que emplene una variable de text amb els valors "Zero", "Un", 
"Dos" o "Més de dos" segons la quantitat de jocs que tenim de la 
plataforma "ps4". Finalment, haurà de mostrar el valor d'aqueixa 
variable.
*/

DO
$$
DECLARE 
    cantidadJocs NUMERIC(3);
    resposta VARCHAR(20);
BEGIN
    SELECT COUNT(codi)
        INTO cantidadJocs
        FROM plataformes;

    resposta:= CASE cantidadJocs
        WHEN 0 THEN 'Zero'
        WHEN 1 THEN 'Un'
        WHEN 2 THEN 'Dos'
        ELSE 'mes de dos'
    END;

    RAISE NOTICE '%', resposta;
END;
$$
