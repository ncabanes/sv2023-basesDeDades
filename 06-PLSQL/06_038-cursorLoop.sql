/* Crea un script PL/SQL similar a l'anterior (nom de cada plataforma i
quantitat de jocs o, si és zero, la paraula "Cap"), però en aquesta
ocasió hauràs d'utilitzar un bucle LOOP, juntament amb la clàusula EXIT
*/

DECLARE
    CURSOR cursorJocs IS
        SELECT p.nom, COUNT(codiPlataforma)
        FROM plataformes p LEFT JOIN jocs j
        ON p.codi = codiPlataforma
        GROUP BY p.nom
        ORDER BY nom;

    vNomPlataforma plataformes.nom%TYPE;
    vQuantitat NUMBER;

BEGIN
    OPEN cursorJocs;

    LOOP
        FETCH cursorJocs INTO vNomPlataforma, vQuantitat;

        EXIT WHEN cursorJocs % NOTFOUND;

        IF vQuantitat = 0 THEN
            dbms_output.put_line(vNomPlataforma || ' - Cap');
        ELSE
            dbms_output.put_line(vNomPlataforma || ' - ' || vQuantitat);
        END IF;
    END LOOP;

    CLOSE cursorJocs;
END;
