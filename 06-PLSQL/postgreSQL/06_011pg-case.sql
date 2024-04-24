/*
A partir de les dades de la taula de plataformes (de jocs), crea un 
script que escriba "No tenim dades de plataformes basades en 
Playstation", "Tenim dades d'1 plataforma basada en Playstation", 
"Tenim dades de 2 plataformes basades en Playstation" o "Tenim dades de 
més de 2 plataformes basades en Playstation", segons corresponga, 
emprant CASE.
*/

DO
$$
DECLARE
    numPlataformes NUMERIC(2);
BEGIN
    SELECT count(codi)
        INTO numPlataformes
        FROM plataformes
        WHERE codi LIKE 'ps%';

    CASE numPlataformes
        WHEN 0 THEN
            RAISE NOTICE 'No tenim dades de plataformes basades en Playstation';
        WHEN 1 THEN
            RAISE NOTICE 'Tenim dades d''1 plataforma basada en Playstation';
        WHEN 2 THEN
            RAISE NOTICE 'Tenim dades de 2 plataformes basades en Playstation';
        ELSE
            RAISE NOTICE 'Tenim dades de més de 2 plataformes basades en Playstation';
    END CASE;
END;
$$

