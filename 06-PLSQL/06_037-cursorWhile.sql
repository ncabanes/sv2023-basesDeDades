/* Crea un script PL/SQL que empre cursors per a obtindre la següent
informació a partir de la nostra base de dades de jocs i plataformes:
per a cadascuna de les plataformes, es mostrarà el seu nom i la
quantitat de jocs que tenim emmagatzemats. En cas que aqueixa quantitat
siga 0 per a alguna plataforma, no es mostrarà el número 0, sinó el
text "Cap". Usa un bucle WHILE, com en l'exemple. */

DECLARE
    CURSOR cursorJocs IS
        SELECT p.nom, COUNT(codiPlataforma)
        FROM plataformes p LEFT JOIN jocs j
        ON p.codi = codiPlataforma
        GROUP BY p.nom
        ORDER BY nom;

    vNomPlataforma   plataformes.nom%TYPE;
    vQuantitat       NUMBER;

BEGIN
    OPEN cursorJocs;

    FETCH cursorJocs INTO vNomPlataforma, vQuantitat;
    WHILE cursorJocs % FOUND LOOP

        IF vQuantitat = 0 THEN
            dbms_output.put_line(vNomPlataforma || ' - Cap');
        ELSE
            dbms_output.put_line(vNomPlataforma || ' - ' || vQuantitat);
        END IF;

        FETCH cursorJocs INTO vNomPlataforma, vQuantitat;
    END LOOP;

    CLOSE cursorJocs;
END;
