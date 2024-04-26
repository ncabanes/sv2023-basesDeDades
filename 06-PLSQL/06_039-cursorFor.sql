/* Crea un script PL/SQL similar a l'anterior (nom de cada plataforma i 
quantitat de jocs o, si és zero, la paraula "Cap"), però en aquesta 
ocasió hauràs d'utilitzar un bucle FOR. 
*/

DECLARE
    CURSOR cursorJocs IS
        SELECT p.nom, COUNT(codiPlataforma) AS quantitat
        FROM plataformes p LEFT JOIN jocs j
        ON p.codi = codiPlataforma
        GROUP BY p.nom
        ORDER BY nom;

BEGIN
    FOR vRegistro IN cursorJocs LOOP 
        IF vRegistro.quantitat = 0 THEN
            dbms_output.put_line(vRegistro.nom || ' - Cap');
        ELSE
            dbms_output.put_line(vRegistro.nom || ' - ' || 
                vRegistro.quantitat);
        END IF;

    END LOOP;
END;
