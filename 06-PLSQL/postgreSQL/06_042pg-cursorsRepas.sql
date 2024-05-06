/* Usant un cursor, mostra el nom de cada plataforma i l'espai ocupat 
per tots els seus jocs, o el text "Sense jocs", en cas que no hi haja 
jocs per a eixa plataforma.

Fes-ho de tres formes com a part d'un mateix script: primer amb WHILE, 
després amb LOOP i finalment amb FOR. */

DO
$$
DECLARE
    cursorJocs CURSOR FOR
        SELECT p.nom, SUM(espaiOcupatMb) AS espai
        FROM plataformes p LEFT JOIN jocs j
        ON p.codi = codiPlataforma
        GROUP BY p.nom
        ORDER BY nom;

    vNomPlataforma   plataformes.nom%TYPE;
    vEspai           NUMERIC;

BEGIN

    RAISE NOTICE '----- WHILE -----';
    
    OPEN cursorJocs;

    FETCH cursorJocs INTO vNomPlataforma, vEspai;
    WHILE FOUND LOOP

        IF vEspai = 0 OR vEspai IS NULL THEN
            RAISE NOTICE '%', vNomPlataforma || ' - Sense jocs';
        ELSE
            RAISE NOTICE '%', vNomPlataforma || ' - ' || vEspai;
        END IF;

        FETCH cursorJocs INTO vNomPlataforma, vEspai;
    END LOOP;

    CLOSE cursorJocs;
    
    RAISE NOTICE '----- LOOP -----';

    OPEN cursorJocs;

    LOOP
        FETCH cursorJocs INTO vNomPlataforma, vEspai;

        EXIT WHEN NOT FOUND;

        IF vEspai = 0 OR vEspai IS NULL THEN
            RAISE NOTICE '%', vNomPlataforma || ' - Sense jocs';
        ELSE
            RAISE NOTICE '%', vNomPlataforma || ' - ' || vEspai;
        END IF;
    END LOOP;

    CLOSE cursorJocs;
    
    RAISE NOTICE '----- FOR -----';
    
    FOR vRegistro IN cursorJocs LOOP 
        IF vRegistro.espai = 0 OR vRegistro.espai IS NULL THEN
            RAISE NOTICE '%', vRegistro.nom || ' - Sense jocs';
        ELSE
            RAISE NOTICE '%', vRegistro.nom || ' - ' || 
                vRegistro.espai;
        END IF;

    END LOOP;
END;
$$
