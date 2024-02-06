-- Crea també una taula Jocs0, amb camps:

-- Codi, de 5 lletres, clau
-- Nom, de fins a 50 lletres, no nul
-- Descripció, de fins a 1000 lletres
-- Data de llançament, data
-- Espai ocupat en GB, 4 xifres abans de la coma i 3 després
-- Codi de plataforma, clau aliena a la taula anterior.

CREATE TABLE Jocs0 (
	codi CHAR(5),
	nom VARCHAR2(50) NOT NULL,
	descripcio VARCHAR2(1000),
	dataLlancament DATE,
	espaiOcupat NUMBER(7,3),
	codiPlataforma CHAR(4),
	CONSTRAINT pk_codi PRIMARY KEY (codi),
	CONSTRAINT fk_codiPlataforma FOREIGN KEY (codiPlataforma) 
		REFERENCES Plataformes0(codi)
);
