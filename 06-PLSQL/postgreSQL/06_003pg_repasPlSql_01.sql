-- Repàs SQL + PL/SQL 01

-- PL/SQL 1: Escriu "Antonio safugao" des de PL/SQL

DO
$$
BEGIN
    RAISE NOTICE '%', 'Antonio safugao';
END;
$$

-- PL/SQL 2: Obtingues l'any més recent, guarda'l en una variable i mostra'l

DO
$$
DECLARE 
    anyModern NUMERIC(4);
BEGIN
    SELECT MAX(anyLlancament)
        INTO anyModern 
        FROM jocs;
    RAISE NOTICE 'Any més modern: %', anyModern;
END;
$$
