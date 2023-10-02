.open clinicaV1

CREATE TABLE especialitat (
    codi VARCHAR(6) PRIMARY KEY, 
    descripcio VARCHAR(20)
);

CREATE TABLE metge (
    numCol VARCHAR(6) PRIMARY KEY,
    nom VARCHAR(15), 
    codiEspecialitat VARCHAR(6),
    FOREIGN KEY (codiEspecialitat) REFERENCES especialitat(codi)
);

CREATE TABLE pacient(
    dni VARCHAR(9) PRIMARY KEY,
    nom VARCHAR(15)
); 

CREATE TABLE aten(
    numColMetge VARCHAR(6), 
    dniPacient VARCHAR(9),
    diamesany VARCHAR(10),
    motiu VARCHAR(100),
    diagnostic VARCHAR(100), 
    PRIMARY KEY (numColMetge, dniPacient, diamesany, motiu),
    FOREIGN KEY (numColMetge) REFERENCES metge(numCol),
    FOREIGN KEY (dniPacient) REFERENCES pacient(dni)
);


INSERT INTO especialitat VALUES('ur','Urgencies');
INSERT INTO especialitat VALUES('ped','Pediatria');

INSERT INTO metge VALUES('111111','Roberto Ruíz Garcia','ur');
INSERT INTO metge VALUES('222222','Paula Pérez Fernández','ped');

INSERT INTO pacient VALUES('11111A','Laura García García');
INSERT INTO pacient VALUES('22222B','Luis Martínez Pacheco');

INSERT INTO aten VALUES('111111', '11111A', '12/03/2023', 'Ansietat', 'Pressió en el pit 
i dificultat respiratòria');
INSERT INTO aten VALUES('222222', '22222B', '14/03/2023', 'Revisió', 'Revisió mèdica.');
INSERT INTO aten VALUES('111111', '22222B', '15/04/3023', 'Grip', 'Fiebre i mal de cap.');

SELECT * FROM especialitat;

SELECT nom FROM pacient; 

SELECT pacient.nom, metge.nom, aten.motiu
FROM pacient, metge, aten
WHERE metge.numCol = aten.numColMetge
AND pacient.dni = aten.dniPacient;
