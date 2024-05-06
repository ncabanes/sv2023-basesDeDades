-- Crea una taula de còpia de seguretat per a les plataformes,
-- a la qual s'enviaran les plataformes que s'esborren. 
-- Comprova que es comporta correctament.


------------------------------

CREATE TABLE PlataformesCopia(
    codi CHAR(4) PRIMARY KEY,
    nom VARCHAR(30)
);

--

CREATE OR REPLACE FUNCTION guardarPlatEsborr()
RETURNS TRIGGER 
LANGUAGE PLPGSQL
AS
$$
BEGIN
    INSERT INTO PlataformesCopia
    VALUES (OLD.*);

    RETURN OLD;
END;
$$

--

CREATE TRIGGER PlataformesCopiaSeguritat
AFTER DELETE ON plataformes
FOR EACH ROW
EXECUTE FUNCTION guardarPlatEsborr();

--

DELETE FROM plataformes
WHERE codi = 'psx';

--

SELECT * FROM plataformescopia;

