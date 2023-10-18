.open relacio11

CREATE TABLE gerent (
    dni VARCHAR(10) PRIMARY KEY, 
    nom VARCHAR(40)
);

CREATE TABLE empresa (
    nif VARCHAR(10) PRIMARY KEY, 
    nom VARCHAR(40)
);

CREATE TABLE gestiona(
    dniGerent VARCHAR(10) PRIMARY KEY, 
    nifEmpresa VARCHAR(10) UNIQUE NOT NULL,
    FOREIGN KEY (dniGerent) REFERENCES gerent(dni),
    FOREIGN KEY (nifEmpresa) REFERENCES empresa(nif)
);

INSERT INTO gerent VALUES('g1','Gabriel');
INSERT INTO gerent VALUES('g2','Gerardo');

INSERT INTO empresa VALUES('e1','Everis');
INSERT INTO empresa VALUES('e2','Endesa');

INSERT INTO gestiona VALUES('g1','e1');
INSERT INTO gestiona VALUES('g2','e2');

-- No hauria de funcionar:

INSERT INTO gestiona VALUES('g1','e1');
INSERT INTO gestiona VALUES('g1','e2');
INSERT INTO gestiona VALUES('g2','e1');

-- Obtenció de dades:

SELECT * FROM gerent;

SELECT gerent.nom, empresa.nom
FROM gerent, empresa, gestiona
WHERE gerent.dni = gestiona.dniGerent
AND empresa.nif = gestiona.nifEmpresa;
