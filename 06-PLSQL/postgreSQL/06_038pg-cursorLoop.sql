/* Crea un script PL/SQL similar a l'anterior (nom de cada plataforma i
quantitat de jocs o, si és zero, la paraula "Cap"), però en aquesta
ocasió hauràs d'utilitzar un bucle LOOP, juntament amb la clàusula EXIT
*/

DO
$$
DECLARE
    cursorJocs CURSOR FOR
        SELECT p.nom, COUNT(codiPlataforma)
        FROM plataformes p LEFT JOIN jocs j
        ON p.codi = codiPlataforma
        GROUP BY p.nom
        ORDER BY nom;

    vNomPlataforma plataformes.nom%TYPE;
    vQuantitat NUMERIC;

BEGIN
    OPEN cursorJocs;

    LOOP
        FETCH cursorJocs INTO vNomPlataforma, vQuantitat;

        EXIT WHEN NOT FOUND;

        IF vQuantitat = 0 THEN
            RAISE NOTICE '%', vNomPlataforma || ' - Cap';
        ELSE
            RAISE NOTICE '%', vNomPlataforma || ' - ' || vQuantitat;
        END IF;
    END LOOP;

    CLOSE cursorJocs;
END;
$$
