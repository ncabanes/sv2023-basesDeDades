-- Crea una taula de còpia de seguretat per a les plataformes,
-- a la qual s'enviaran les plataformes que s'esborren. 
-- Comprova que es comporta correctament.

CREATE TABLE PlataformesCopia(
    codi CHAR(4) PRIMARY KEY,
    nom VARCHAR2(30)
);

CREATE OR REPLACE TRIGGER PlataformesCopiaSeguritat
AFTER DELETE ON plataformes
FOR EACH ROW
BEGIN
    INSERT INTO PlataformesCopia
    VALUES (:OLD.codi, :OLD.nom);
END;

--

DELETE FROM plataformes
WHERE codi = 'psx';

SELECT * FROM plataformescopia;

