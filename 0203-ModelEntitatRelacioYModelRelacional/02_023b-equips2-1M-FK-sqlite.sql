-- Equip + jugador, amb clau aliena

.open equipsV2

CREATE TABLE equip (
    codi VARCHAR(8) PRIMARY KEY,
    nom VARCHAR(40)
);

CREATE TABLE jugador (
    codi VARCHAR(10) PRIMARY KEY,
    nom VARCHAR(60), 
    codiEquip VARCHAR(8),
    FOREIGN KEY (codiEquip) REFERENCES equip(codi)
);

INSERT INTO equip VALUES('rs','Real Sanvi');
INSERT INTO equip VALUES('aa','Athletic de Agost');

INSERT INTO jugador VALUES('cl','Cruz LopeDeVega','rs');
INSERT INTO jugador VALUES('mi','María Irene','aa');

-- La següent inserció fallaria en Oracle
INSERT INTO jugador VALUES('nv','Nacho Vanessa','rm');

SELECT * FROM equip;

SELECT * FROM jugador WHERE codiEquip = 'rs';

SELECT nom FROM jugador;

SELECT * FROM equip, jugador
WHERE equip.codi = jugador.codiEquip;

SELECT jugador.nom, equip.nom 
FROM equip, jugador
WHERE equip.codi = jugador.codiEquip;

