-- Afig dues dades de jocs d'exemple. 
-- Després, bolca'ls a la còpia de seguretat.

INSERT INTO jocs (codi, nom) VALUES ('CB3','Call of Duty Black Ops 3');
INSERT INTO jocs (codi, nom) VALUES ('CB2','Call of Duty Black Ops 2');

SELECT * FROM jocs;

INSERT INTO copiaJocs
SELECT * FROM jocs WHERE nom LIKE 'Call%';

SELECT * FROM copiajocs;
