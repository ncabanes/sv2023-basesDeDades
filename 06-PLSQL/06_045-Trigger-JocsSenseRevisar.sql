-- Crea un trigger que anote "Sense revisar" 
-- en el nom d'un joc, en el cas que no s'haja 
-- indicat aquest nom 

CREATE OR REPLACE TRIGGER jocsSenseRevisar
BEFORE INSERT ON jocs
FOR EACH ROW
BEGIN
    IF :NEW.nom IS NULL THEN
        :NEW.nom := 'Sense revisar';
    END IF;
END;

---

INSERT INTO jocs(codi, nom) VALUES('suu', null);

SELECT * FROM jocs;
