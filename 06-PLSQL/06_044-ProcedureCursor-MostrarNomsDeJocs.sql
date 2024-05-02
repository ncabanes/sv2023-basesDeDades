CREATE OR REPLACE PROCEDURE MostrarNomsDeJocs(codiPlat IN CHAR) 
AS
    CURSOR c_cursor IS
        SELECT nom, espaiOcupatMB
        FROM jocs
        WHERE codiPlat = codiPlataforma
        ORDER BY nom;
    nomJoc jocs.nom %TYPE;
    espaiJoc jocs.espaiOcupatMb %TYPE;
    v_espaiOcupat jocs.espaiOcupatMb %TYPE := 0;

BEGIN
    OPEN c_cursor;
        FETCH c_cursor INTO nomJoc, espaiJoc;
        WHILE c_cursor %FOUND LOOP
            v_espaiOcupat := v_espaiOcupat + espaiJoc;
            dbms_output.put_line(nomJoc || ' ' || v_espaiOcupat);
            FETCH c_cursor INTO nomJoc, espaiJoc;
        END LOOP;   
    CLOSE c_cursor;
END;

BEGIN
    MostrarNomsDeJocs('cpc');
END;
