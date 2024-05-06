/* Crea un script PL/SQL similar a l'anterior (nom de cada plataforma i 
quantitat de jocs o, si és zero, la paraula "Cap"), però en aquesta 
ocasió hauràs d'utilitzar un bucle FOR. 
*/

DO
$$
DECLARE
    cursorJocs CURSOR FOR
        SELECT p.nom, COUNT(codiPlataforma) AS quantitat
        FROM plataformes p LEFT JOIN jocs j
        ON p.codi = codiPlataforma
        GROUP BY p.nom
        ORDER BY nom;

BEGIN
    FOR vRegistro IN cursorJocs LOOP 
        IF vRegistro.quantitat = 0 THEN
            RAISE NOTICE '%', vRegistro.nom || ' - Cap';
        ELSE
            RAISE NOTICE '%', vRegistro.nom || ' - ' || 
                vRegistro.quantitat;
        END IF;

    END LOOP;
END;
$$
