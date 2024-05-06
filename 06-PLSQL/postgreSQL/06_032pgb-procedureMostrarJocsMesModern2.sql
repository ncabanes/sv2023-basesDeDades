CREATE OR REPLACE PROCEDURE MostrarJocMesModern (nomPlataf IN
    VARCHAR)
LANGUAGE plpgsql
AS
$$
DECLARE
    nomJocMesModern jocs.nom % TYPE;
    codiPlataf      plataformes.codi % TYPE;
    quantitatPlataf NUMERIC(2);
BEGIN
    SELECT COUNT(*)
    INTO quantitatPlataf
    FROM plataformes
    WHERE plataformes.nom = nomPlataf;

    IF quantitatPlataf = 0 THEN
        RAISE NOTICE 'No trobada';
    ELSE
        SELECT codi
        INTO codiPlataf
        FROM plataformes
        WHERE nom = nomPlataf;

        SELECT nom
        INTO nomJocMesModern
        FROM jocs
        WHERE codiPlataforma = codiPlataf
        ORDER by anyLlancament DESC
        FETCH NEXT 1 ROWS ONLY;

        RAISE NOTICE '%', nomJocMesModern;
    END IF;
END;
$$

-- Ús

CALL MostrarJocMesModern('Playstation 3');
