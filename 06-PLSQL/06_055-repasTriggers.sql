-- Si s'intenta afegir un programa el codi de categoria del qual no 
-- existisca, s'haurà de reemplaçar este codi de categoria per NULL.

CREATE OR REPLACE TRIGGER tProgramaNull
BEFORE INSERT ON programa
FOR EACH ROW

DECLARE
    comptador NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO comptador
    FROM Categoria
    WHERE codi = :NEW.codCategoria;

    IF comptador = 0 THEN
        :NEW.codCategoria := NULL;
    END IF;
END;

INSERT INTO programa VALUES ('wi11', 'Windows 11', 'Windows 11', 'jaja');

SELECT * FROM programa;
