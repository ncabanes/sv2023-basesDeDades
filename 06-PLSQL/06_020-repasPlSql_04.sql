REATE TABLE editorials(
    codi CHAR(4),
    nom VARCHAR2(40),
    CONSTRAINT pk_editorials PRIMARY KEY(codi)
);

CREATE TABLE autors(
    codi CHAR(4),
    nom VARCHAR2(60),
    CONSTRAINT pk_autors PRIMARY KEY(codi)
);

CREATE TABLE llibres(
    codi CHAR(5),
    titol VARCHAR2(50),
    anyEdicio NUMBER(4),
    codiEditorial CHAR(4),
    codiAutor CHAR(4),
    CONSTRAINT pk_llibres PRIMARY KEY(codi),
    CONSTRAINT fk_llib_ed FOREIGN KEY (codiEditorial) REFERENCES editorials(codi),
    CONSTRAINT fk_llib_aut FOREIGN KEY (codiAutor) REFERENCES autors(codi)
);

INSERT INTO editorials VALUES('UMB', 'Umbriel');
INSERT INTO editorials VALUES('RSOP', 'Ramón Sopena');
INSERT INTO editorials VALUES('PLJ', 'Plaza & Janés');
INSERT INTO editorials VALUES('EDMA', 'Edimat');
INSERT INTO editorials VALUES('CIRC', 'Círculo de lectores');
INSERT INTO editorials VALUES('ALF', 'Alfaguara');

INSERT INTO autors VALUES('DBR', 'Dan Brown');
INSERT INTO autors VALUES('JVR', 'Julio Verne');
INSERT INTO autors VALUES('MCR', 'Michael Crichton');
INSERT INTO autors VALUES('SKN', 'Stephen King');
INSERT INTO autors VALUES('RKP', 'Rudyard Kipling');
INSERT INTO autors VALUES('GAB', 'Gustavo Adolfo Bécquer');
INSERT INTO autors VALUES('APR', 'Arturo Pérez Reverte');

INSERT INTO llibres VALUES('ECDV', 'El código Da Vinci',2004, 'UMB', 'DBR');
INSERT INTO llibres VALUES('MILL', 'Veinte mil leguas de viaje submarino',1954, 'RSOP', 'JVR');
INSERT INTO llibres VALUES('PARK', 'Parque Jurásico',1993, 'PLJ','MCR');
INSERT INTO llibres VALUES('OJOS', 'Ojos de fuego',1990, 'PLJ', 'SKN');
INSERT INTO llibres VALUES('ZON', 'La zona muerta',1985,'PLJ','SKN');
INSERT INTO llibres VALUES('SELV', 'El libro de la selva',2004, 'EDMA','RKP');
INSERT INTO llibres VALUES('RIM', 'Rimas y leyendas',1987, 'CIRC','GAB');
INSERT INTO llibres VALUES('DUM', 'El club dumas',1999,'ALF','APR');
INSERT INTO llibres VALUES('FLAN', 'La tabla de Flandes',2007, 'ALF','APR');


-- Mostra l'any del llibre més modern que ja hem introduït.


-- Cerca el llibre (títol, any i nom d'autor) més antic que ja hem 
-- introduït en el sistema, usant dos consultes consecutives.


-- Mostra la quantitat d'editorials el nom de les quals coincidix amb 
-- el títol d'un llibre. Si la quantitat és 0, en comptes d'escriure 
-- el número 0, escriuràs "Cap".


-- Obtingues la quantitat d'autors dels quals no tenim llibres. Segons 
-- el cas, escriu "Cap autor sense llibres", "Un autor sense llibres: " 
-- o "Més d'un autor sense llibres", emprant CASE.


