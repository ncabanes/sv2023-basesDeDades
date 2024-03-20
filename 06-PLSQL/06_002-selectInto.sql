DECLARE
    espaiMitja NUMBER(9,3);
BEGIN 
    SELECT AVG(espaiOcupatMb)
        INTO espaiMitja
        FROM jocs;
    dbms_output.put_line(espaiMitja);
END;
