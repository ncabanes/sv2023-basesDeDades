/*
Crea un procediment "MostrarPlataformaMillorValorada", que mostre el 
nom i, separat per un espai, la valoració mitjana, de la plataforma els 
jocs de la qual estiguen (com a mitjana) millor valorats. Com a 
paràmetre rebrà la valoració mínima i la màxima que ha de tindre eixa 
plataforma a mostrar. Si cap plataforma complix els requisits, mostrarà 
"Plataforma no trobada".
*/

CREATE OR REPLACE PROCEDURE MostrarPlataformaMillorValorada (
    valMinima IN NUMBER,
    valMaxima IN NUMBER
)
IS
    nombre plataformes.nom%TYPE;
    mitjanaPlat NUMBER(4,2);
    quantitat NUMBER;
BEGIN
    SELECT COUNT(*) INTO quantitat FROM
    (
        SELECT p1.nom, AVG(j1.valoracio)
        FROM plataformes p1 LEFT JOIN jocs j1 ON j1.codiPlataforma = p1.codi
        GROUP BY p1.nom    
        HAVING AVG(j1.valoracio) BETWEEN valMinima AND valMaxima
    );
    
    IF quantitat = 0 THEN
        dbms_output.put_line('Plataforma no trobada');
    ELSE

        SELECT p1.nom, AVG(j1.valoracio)
        INTO nombre, mitjanaPlat
        FROM plataformes p1 LEFT JOIN jocs j1 ON j1.codiPlataforma = p1.codi
        GROUP BY p1.nom
        HAVING AVG(j1.valoracio) BETWEEN valMinima AND valMaxima
        ORDER BY AVG(j1.valoracio) DESC
        FETCH FIRST 1 ROWS ONLY;

        dbms_output.put_line(nombre || ' ' || mitjanaPlat);
    END IF;
END;

BEGIN
    MostrarPlataformaMillorValorada(5,10);
END;
