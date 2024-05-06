-- Crea un procediment "EscriureGuions", que escriga diversos 
-- guions en l'eixida de la base de dades, tants com s'indiquen 
-- en un paràmetre numèric (d'entrada).

CREATE OR REPLACE PROCEDURE EscriureGuions(
    quantitat IN NUMERIC) 
LANGUAGE plpgsql
AS
$$
DECLARE
   guions  VARCHAR(200) := '';
BEGIN
   FOR i IN 1 .. quantitat LOOP
       guions := guions || '-';
   END LOOP;

   RAISE NOTICE '%', guions;
END;
$$

-- Ús 

CALL EscriureGuions(5);
