-- Crea una taula Plataformes0, per a anotar dades de plataformes de videojocs (per exemple, consoles), amb camps:

-- Codi, de 4 lletres, clau
-- Nom, de fins a 30 lletres, no nul
-- Usa la sintaxi de Oracle.

CREATE TABLE Plataformes0 (
	codi CHAR(4),
	nom VARCHAR2(25) NOT NULL,
	CONSTRAINT pk_plataformes0 PRIMARY KEY (codi)
);
