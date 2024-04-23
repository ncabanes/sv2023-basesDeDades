CREATE OR REPLACE PROCEDURE MostrarJocMesModern (nomPlataf IN
    VARCHAR2)
IS
    nomJocMesModern jocs.nom % TYPE;
    codiPlataf      plataformes.codi % TYPE;
    quantitatPlataf NUMBER(2);
BEGIN
    SELECT COUNT(*)
    INTO quantitatPlataf
    FROM plataformes
    WHERE plataformes.nom = nomPlataf;

    IF quantitatPlataf = 0 THEN
        dbms_output.put_line('No trobada');
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

        dbms_output.put_line(nomJocMesModern);
    END IF;
END;

-- Ús 1

BEGIN
    MostrarJocMesModern('Playstation 3');
END;

-- Ús 2

EXECUTE  MostrarJocMesModern('Playstation 3');
