-- Repàs SQL + PL/SQL 02

-- PL/SQL 1: Escriu "David, no t'alces" des de PL/SQL

DO
$$
BEGIN
    RAISE NOTICE '%', 'David, no t''alces';
END;
$$

-- PLSQL 2: Obtingues el nom de la plataforma de codi "epic", guarda-ho en una variable i mostra-ho

DO
$$
DECLARE
    nomP VARCHAR(30);
BEGIN
    SELECT nom 
    INTO nomP
    FROM plataformes
    WHERE UPPER(codi) = 'EPIC';
    
    RAISE NOTICE '%', nomP;
END;
$$
