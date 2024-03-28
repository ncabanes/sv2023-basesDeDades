-- Jocs el nom dels quals no coincidisca amb el d'una plataforma

-- 1. IN / NOT IN

SELECT nom FROM jocs
WHERE nom NOT IN(
    SELECT nom
    FROM plataformes
);

-- 2. ALL / ANY

SELECT nom FROM jocs
WHERE nom <> ALL(
    SELECT nom
    FROM plataformes
);

-- 3. EXISTS / NOT EXISTS

SELECT nom FROM jocs
WHERE NOT EXISTS(
    SELECT 'Wiwi'
    FROM plataformes
    WHERE plataformes.nom = jocs.nom
);

-- 4. Conjuntos

SELECT nom FROM jocs
MINUS
SELECT nom FROM plataformes;

-- PL/SQL: Cerca l'any del joc més modern i respon 
-- si és 2020, anterior o posterior

DECLARE 
    anyModern jocs.anyLlancament%TYPE;
BEGIN
    SELECT MAX(anyLlancament)
    INTO anyModern
    FROM jocs;
    
    IF anyModern > 2020 THEN
        dbms_output.put_line('És posterior a 2020');
    ELSIF anyModern < 2020 THEN
        dbms_output.put_line('És anterior a 2020');
    ELSE
        dbms_output.put_line('És de 2020');
    END IF;
END;
