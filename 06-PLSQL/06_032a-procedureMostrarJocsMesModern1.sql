CREATE OR REPLACE PROCEDURE MostrarJocMesModern (nomPlataf IN
    VARCHAR2)
IS
    nomJocMesModern jocs.nom % TYPE;
    quantitatPlataf NUMBER(2);
BEGIN
    SELECT COUNT(*)
    INTO quantitatPlataf
    FROM plataformes
    WHERE plataformes.nom = nomPlataf;

    IF quantitatPlataf = 0 THEN
        dbms_output.put_line('No trobada');
    ELSE
        SELECT jocs.nom
        INTO nomJocMesModern
        FROM jocs JOIN plataformes
        ON jocs.codiPlataforma = plataformes.codi
        AND plataformes.nom = nomPlataf
        AND jocs.anyLlancament = (
            SELECT MAX(anyLlancament)
            FROM jocs j2 JOIN plataformes p2
            ON j2.codiPlataforma = p2.codi
            AND p2.nom = nomPlataf
        );

        dbms_output.put_line(nomJocMesModern);
    END IF;
END;

BEGIN
    MostrarJocMesModern('Playstation 3');
END;
