-- Crea, amb %ROWTYPE, una versió en PL/SQL 
-- de la següent consulta:

-- SELECT nom, anyLlancament
-- FROM jocs WHERE anyLlancament =
-- (
--     SELECT MAX(anyLlancament) FROM jocs
-- );

DECLARE
    v_joc jocs % ROWTYPE;
BEGIN

    SELECT * 
    INTO v_joc
    FROM jocs WHERE anyLlancament =
    (
        SELECT MAX(anyLlancament) FROM jocs
    );
    
    dbms_output.put_line(v_joc.nom 
        || ' ' || v_joc.anyLlancament);
END;
