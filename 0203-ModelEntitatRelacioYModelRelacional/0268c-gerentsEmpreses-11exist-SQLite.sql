.open relacio11exist

CREATE TABLE gerent(
    dni VARCHAR(10) PRIMARY KEY, 
    nom VARCHAR(20)
);                        

CREATE TABLE empresa(
    nif VARCHAR(10) PRIMARY KEY, 
    nom VARCHAR(20),
    dniGerent VARCHAR(10) UNIQUE NOT NULL,
    FOREIGN KEY (dniGerent) REFERENCES gerent(dni)
);

  
INSERT INTO gerent VALUES('g1','Gabriel');
INSERT INTO gerent VALUES('g2','Gerardo'); 
INSERT INTO gerent VALUES('g3','Gustavo');
--No hauria de funcionar:
INSERT INTO gerent VALUES('g1','Gulliver');

INSERT INTO empresa VALUES('e1','Everis','g1');
INSERT INTO empresa VALUES('e2','Endesa','g3');  
INSERT INTO empresa VALUES('e3','Euler','g2');
--No hauria de funcionar:
INSERT INTO empresa VALUES('e1','NTTD','g1');
INSERT INTO empresa VALUES('e1','Everis','g2');
--No hauria de funcionar:
INSERT INTO empresa VALUES('e1','Everis',NULL);

.mode column

SELECT * FROM gerent;
SELECT * FROM empresa;

SELECT gerent.nom, empresa.nom
FROM gerent, empresa
WHERE gerent.dni=empresa.dniGerent;

SELECT empresa.nif, gerent.dni, gerent.nom 
FROM gerent, empresa
WHERE empresa.dniGerent=gerent.dni;
