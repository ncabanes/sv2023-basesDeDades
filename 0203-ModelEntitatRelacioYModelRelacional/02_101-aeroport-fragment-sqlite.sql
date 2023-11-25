-- AEROPORT(codi, nom, ciutat)
-- CP: codi

CREATE TABLE aeroport (
    codi VARCHAR(10) PRIMARY KEY,
    nom VARCHAR(40),
    ciutat VARCHAR(40)
);

-- PROGRAMA_VOL(codi, diaSetmana, hora, codiAeropEnlaira, codiAeropAterra)
-- CP: codi
-- CAl: codiAeropEnlaira -> AEROPORT
-- CAl: codiAeropAterra -> AEROPORT
-- VNN: codiAeropEnlaira
-- VNN: codiAeropAterra

CREATE TABLE programaVol (
    codi VARCHAR(8) PRIMARY KEY,
    diaSetmana CHAR(1),
    hora CHAR(5),
    codiAeropEnlaira VARCHAR(10) NOT NULL,
    codiAeropAterra VARCHAR(10) NOT NULL,
    FOREIGN KEY (codiAeropEnlaira) REFERENCES aeroport(codi),
    FOREIGN KEY (codiAeropAterra) REFERENCES aeroport(codi)
);

-- PROGRAMA_VOL_AMB_ESCALES(codiProgramaVol)
-- CP: codiProgramaVol
-- CAl: codiProgramaVol -> PROGRAMA_VOL

CREATE TABLE programaVolAmbEscales (
    codi VARCHAR(8) PRIMARY KEY,
    FOREIGN KEY (codi) REFERENCES programaVol(codi)
);

-- PROGRAMA_VOL_DIRECTE(codiProgramaVol)
-- CP: codiProgramaVol
-- CAl: codiProgramaVol -> PROGRAMA_VOL

CREATE TABLE programaVolDirecte (
    codi VARCHAR(8) PRIMARY KEY,
    FOREIGN KEY (codi) REFERENCES programaVol(codi)
);

-- ESCALA(codiProgramaVolAmbEscales, numero, nom)
-- CP(codiProgramaVolAmbEscales, numero)
-- CAl: codiProgramaVolAmbEscales -> PROGRAMA_VOL_AMB_ESCALES

CREATE TABLE escala (
    codiProgVolAE VARCHAR(8),
    numero NUMERIC(2),
    nom VARCHAR(50),
    PRIMARY KEY(codiProgVolAE, numero),
    FOREIGN KEY (codiProgVolAE) REFERENCES programaVolAmbEscales(codi)
);
    
-- Dades de prova

INSERT INTO aeroport VALUES ('MAD', 'Madrid - Barajas', 'Madrid');
INSERT INTO aeroport VALUES ('ALC', 'Alicante - El Altet', 'Alicante');
INSERT INTO aeroport VALUES ('DUS', 'Düsseldorf', 'Düsseldorf');

INSERT INTO programaVol VALUES ('DAW1', 'L', '09:45', 'ALC', 'DUS');
INSERT INTO programaVolAmbEscales VALUES ('DAW1');
INSERT INTO escala VALUES ('DAW1',1,'París');

INSERT INTO programaVol VALUES ('DAW2', 'V', '11:OO', 'ALC', 'MAD');
INSERT INTO programaVolDirecte VALUES ('DAW2');

-- Ciutat de partida del vol directe DAW2

SELECT aeroport.ciutat
FROM programaVol, programaVolDirecte, aeroport
WHERE programaVol.codi = programaVolDirecte.codi
AND programaVol.codiAeropEnlaira = aeroport.codi
AND programaVolDirecte.codi = 'DAW2';

-- Ciutat de partida del vol amb escales que fa escala a París

SELECT aeroport.ciutat
FROM programaVol, programaVolAmbEscales, escala, aeroport
WHERE programaVol.codi = programaVolAmbEscales.codi
AND programaVol.codiAeropEnlaira = aeroport.codi
AND programaVolAmbEscales.codi = escala.codiProgVolAE
AND escala.nom = 'París';
