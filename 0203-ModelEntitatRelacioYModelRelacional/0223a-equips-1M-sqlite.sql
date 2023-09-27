-- Equip + jugador, sense clau aliena

.open equipsV1

CREATE TABLE equip (
    codi VARCHAR(8) PRIMARY KEY,
    nom VARCHAR(40)
);

CREATE TABLE jugador (
    codi VARCHAR(10) PRIMARY KEY,
    nom VARCHAR(60), 
    codiEquip VARCHAR(8)
);

INSERT INTO equip VALUES('rs','Real Sanvi');
INSERT INTO equip VALUES('aa','Athletic de Agost');

INSERT INTO jugador VALUES('cl','Cruz LopeDeVega','rs');
INSERT INTO jugador VALUES('mi','María Irene','aa');
INSERT INTO jugador VALUES('nv','Nacho Vanessa','rm');

SELECT * FROM equip;

SELECT * FROM jugador WHERE codiEquip = 'rs';

SELECT nom FROM jugador;

SELECT * FROM equip, jugador
WHERE equip.codi = jugador.codiEquip;

SELECT jugador.nom, equip.nom 
FROM equip, jugador
WHERE equip.codi = jugador.codiEquip;

