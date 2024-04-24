DO
$$
DECLARE
    espaiMitja NUMERIC(9,3);
BEGIN 
    SELECT AVG(espaiOcupatMb)
        INTO espaiMitja
        FROM jocs;
    RAISE NOTICE '%', espaiMitja;
END;
$$
