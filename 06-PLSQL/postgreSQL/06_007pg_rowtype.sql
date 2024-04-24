-- Crea, amb %ROWTYPE, una versió en PL/SQL 
-- de la següent consulta:

-- SELECT nom, anyLlancament
-- FROM jocs WHERE anyLlancament =
-- (
--     SELECT MAX(anyLlancament) FROM jocs
-- );

DO
$$
DECLARE
    v_joc jocs % ROWTYPE;
BEGIN

    SELECT * 
    INTO v_joc
    FROM jocs WHERE anyLlancament =
    (
        SELECT MAX(anyLlancament) FROM jocs
    );
    
    RAISE NOTICE '%', v_joc.nom 
        || ' ' || v_joc.anyLlancament;
END;
$$
