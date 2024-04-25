/*
Crea una nova versió del procediment "MostrarPlataforma MillorValorada", 
que empre excepcions per a filtrar el cas que cap plataforma complisca 
els requisits.
*/

CREATE OR REPLACE PROCEDURE MostrarPlataformaMillorValorada (
    valMinima IN NUMBER,
    valMaxima IN NUMBER
)
IS
    nombre plataformes.nom%TYPE;
    mitjanaPlat NUMBER(4,2);
BEGIN
    SELECT p1.nom, AVG(j1.valoracio)
    INTO nombre, mitjanaPlat
    FROM plataformes p1 LEFT JOIN jocs j1 ON j1.codiPlataforma = p1.codi
    GROUP BY p1.nom
    HAVING AVG(j1.valoracio) BETWEEN valMinima AND valMaxima
    ORDER BY AVG(j1.valoracio) DESC
    FETCH FIRST 1 ROWS ONLY;

    dbms_output.put_line(nombre || ' ' || mitjanaPlat);

    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Plataforma no trobada');
END;

BEGIN
    MostrarPlataformaMillorValorada(5,10);
END;
