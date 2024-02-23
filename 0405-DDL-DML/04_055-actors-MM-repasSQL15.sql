-- Pel·lícules
-- 
-- Pel·lícules. Per a simplificar, suposarem que cada pel·lícula té un 
-- únic director. Cada director pot dirigir diverses pel·lícules. També 
-- volem informació sobre actors (varis en cada pel·lícula, i cadascun pot 
-- participar en més e una pel·lícula).
-- 
-- Les dades inicials que usarem per a proves són:
-- 
-- - Titanic, de James Cameron, 1997, valoració 7.9, amb Kate Winslet i Leonardo DiCaprio
-- - Avatar, de James Cameron, 2009, valoració 7.9, amb Sam Worthington, Zoe Saldana i Sigourney Weaver
-- - Forrest Gump, de Robert Zemeckis, 1994, v. 8.8, amb Tom Hanks
-- - Regreso al futuro, de Robert Zemeckis, 1985, v. 8.5, amb Michael J. Fox i Christopher Lloyd
-- - El caballero oscuro, de Christopher Nolan, 2009, v. 9.0, amb Christian Bale i Heath Ledger
-- - La guerra de las galaxias, de George Lucas, 1977, v. 8.6, amb Mark Hamill, Harrison Ford i Carrie Fisher
-- - Interstellar, de Christopher Nolan, 2014, v. 8.6, amb Matthew McConaughey, Anne Hathaway i Jessica Chastain
-- - Àlien, el huité passatger, de Ridley Scott, 1979, v. 8.5, amb Sigourney Weaver
-- - Blade Runner, de Ridley Scott, 1982, v. 8.1, amb Harrison Ford i Ruther Hauer.
-- - Seven (encara no coneixem més dades)
-- 
-- També volem anotar a l'actor Matt Damon i al director Tony Scott, si bé encara no tenim més dades sobre ells. 

-- ---------------------------------

-- Películas
-- 

-- Películas. Para simplificar, supondremos que cada película tiene un 
-- único director. Cada director puede dirigir varias películas. También 
-- queremos información sobre actores (varios en cada película, y cada uno 
-- puede participar en más e una película).
 
-- Los datos iniciales que usaremos para pruebas son:
-- 
-- - Titanic, de James Cameron, 1997, valoración 7.9, con Kate Winslet y Leonardo DiCaprio
-- - Avatar, de James Cameron, 2009, valoración 7.9, con Sam Worthington, Zoe Saldana y Sigourney Weaver
-- - Forrest Gump, de Robert Zemeckis, 1994, v. 8.8, con Tom Hanks
-- - Regreso al futuro, de Robert Zemeckis, 1985, v. 8.5, con Michael J. Fox y Christopher Lloyd
-- - El caballero oscuro, de Christopher Nolan, 2009, v. 9.0, con Christian Bale y Heath Ledger
-- - La guerra de las galaxias, de George Lucas, 1977, v. 8.6, con Mark Hamill, Harrison Ford y Carrie Fisher
-- - Interstellar, de Christopher Nolan, 2014, v. 8.6, con Matthew McConaughey, Anne Hathaway y Jessica Chastain
-- - Alien, el octavo pasajero, de Ridley Scott, 1979, v. 8.5, con Sigourney Weaver
-- - Blade Runner, de Ridley Scott, 1982, v. 8.1, con Harrison Ford y Ruther Hauer.
-- - Seven (aún no conocemos más datos)
-- 
-- También queremos anotar al actor Matt Damon y al director Tony Scott, aunque aún no tenemos más datos sobre ellos. 

-- ---------------------------------

CREATE TABLE persones (
    codi VARCHAR(5) PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE pellicules (
    codi VARCHAR(5) PRIMARY KEY,
    titol VARCHAR(50),
    anyLlancament NUMERIC(4),
    valoracio NUMERIC(3,1),
    codiDirector VARCHAR(5),
    FOREIGN KEY (codiDirector) REFERENCES persones(codi)
);

CREATE TABLE actuen (
    -- Has de completar-ho amb la sintaxi de Oracle
);

-- Directors
INSERT INTO persones VALUES ( 'JC', 'James Cameron');
INSERT INTO persones VALUES ( 'RZ', 'Robert Zemeckis');
INSERT INTO persones VALUES ( 'CN', 'Christopher Nolan');
INSERT INTO persones VALUES ( 'GL', 'George Lucas');
INSERT INTO persones VALUES ( 'RS', 'Ridley Scott');
INSERT INTO persones VALUES ( 'TS', 'Tony Scott');

-- Actors
INSERT INTO persones VALUES('KWI', 'Kate Winslet');
INSERT INTO persones VALUES('LDI', 'Leonardo DiCaprio');
INSERT INTO persones VALUES('SWO', 'Sam Worthington');
INSERT INTO persones VALUES('ZSA', 'Zoe Saldana');
INSERT INTO persones VALUES('SWE', 'Sigourney Weaver');
INSERT INTO persones VALUES('THA', 'Tom Hanks');
INSERT INTO persones VALUES('MFO', 'Michael J. Fox');
INSERT INTO persones VALUES('CLL', 'Christopher Lloyd');
INSERT INTO persones VALUES('CBA', 'Christian Bale');
INSERT INTO persones VALUES('HLE', 'Heath Ledger');
INSERT INTO persones VALUES('MHA', 'Mark Hamill');
INSERT INTO persones VALUES('HFO', 'Harrison Ford');
INSERT INTO persones VALUES('CFI', 'Carrie Fisher');
INSERT INTO persones VALUES('MMC', 'Matthew McConaughey');
INSERT INTO persones VALUES('AHA', 'Anne Hathaway');
INSERT INTO persones VALUES('JCH', 'Jessica Chastain');
INSERT INTO persones VALUES('RHA', 'Rutger Hauer');
INSERT INTO persones VALUES('MDA', 'Matt Damon');

-- Pel·lícules
INSERT INTO pellicules VALUES ('TITAN', 'Titanic', 1997, 7.9, 'JC');
INSERT INTO pellicules VALUES ('AVATA', 'Avatar', 2009, 7.9, 'JC');
INSERT INTO pellicules VALUES ('FORRE', 'Forrest Gump', 1994, 8.8, 'RZ');
INSERT INTO pellicules VALUES ('REGRE', 'Regreso al futuro', 1985, 8.5, 'RZ');
INSERT INTO pellicules VALUES ('CABAL', 'El caballero oscuro', 2009, 9, 'CN');
INSERT INTO pellicules VALUES ('GUERR', 'La guerra de las galaxias', 1977, 8.6, 'GL');
INSERT INTO pellicules VALUES ('INTER', 'Interstellar', 2014, 8.6, 'CN');
INSERT INTO pellicules VALUES ('ALIEN', 'Alien', 1979, 8.5, 'RS');
INSERT INTO pellicules VALUES ('BLADE', 'Blade Runner', 1982, 8.1, 'RS');
INSERT INTO pellicules VALUES ('SEVEN', 'Seven', NULL, NULL, NULL);

-- 1. Crea la taula "actuen"

-- 1a. Estándar

CREATE TABLE actuen (
    codiPersona VARCHAR(5),
    codiPellicula VARCHAR(5),
    PRIMARY KEY (codiPersona,codiPellicula),
    FOREIGN KEY (codiPersona) REFERENCES persones(codi), 
    FOREIGN KEY (codiPellicula) REFERENCES pellicules(codi) 
);

-- 1a. Oracle

CREATE TABLE actuen (
    codiPersona VARCHAR2(5),
    codiPellicula VARCHAR2(5),
    CONSTRAINT pk_actuen 
        PRIMARY KEY (codiPersona,codiPellicula),
    CONSTRAINT fk_actuen_persones 
        FOREIGN KEY (codiPersona) REFERENCES persones(codi), 
    CONSTRAINT fk_actuen_pellicules 
        FOREIGN KEY (codiPellicula) REFERENCES pellicules(codi) 
);

-- 2. Introduïx estes dades

INSERT INTO actuen VALUES('KWI', 'TITAN');
INSERT INTO actuen VALUES('LDI', 'TITAN');
INSERT INTO actuen VALUES('SWO', 'AVATA');
INSERT INTO actuen VALUES('ZSA', 'AVATA');
INSERT INTO actuen VALUES('SWE', 'AVATA');
INSERT INTO actuen VALUES('THA', 'FORRE');
INSERT INTO actuen VALUES('MFO', 'REGRE');
INSERT INTO actuen VALUES('CLL', 'REGRE');
INSERT INTO actuen VALUES('CBA', 'CABAL');
INSERT INTO actuen VALUES('HLE', 'CABAL');
INSERT INTO actuen VALUES('MHA', 'GUERR');
INSERT INTO actuen VALUES('HFO', 'GUERR');
INSERT INTO actuen VALUES('CFI', 'GUERR');
INSERT INTO actuen VALUES('MMC', 'INTER');
INSERT INTO actuen VALUES('AHA', 'INTER');
INSERT INTO actuen VALUES('JCH', 'INTER');
INSERT INTO actuen VALUES('SWE', 'ALIEN');
INSERT INTO actuen VALUES('HFO', 'BLADE');
INSERT INTO actuen VALUES('RHA', 'BLADE');

-- 3. Llista ordenada de pel·lícules (títol, any i valoració).


SELECT titol, anyLlancament, valoracio
FROM pellicules
ORDER BY titol, anyLlancament, valoracio;


-- 4. Pel·lícula (títol i any) posteriors 
-- al 2000 (però que no siguen de 2005) 
-- amb una valoració superior a 8.5.

SELECT titol, anyLlancament
FROM pellicules
WHERE anyLlancament > 2000
AND anyLlancament <> 2005
AND valoracio > 8.5;


-- 5. Llista de directors, juntament 
-- amb el nom de cadascuna de les 
-- seues pel·lícules


SELECT nom AS director, titol AS pellicula
FROM persones, pellicules
WHERE persones.codi = pellicules.codiDirector
ORDER BY director, pellicula;

SELECT nom AS director, titol AS pellicula
FROM persones JOIN pellicules
ON persones.codi = pellicules.codiDirector
ORDER BY director, pellicula;


-- 6. Nom de cada pel·lícula, juntament amb 
-- els noms de cadascun dels seus actors

SELECT titol AS pellicula, nom AS actor 
FROM persones, pellicules, actuen
WHERE actuen.codiPersona = persones.codi
AND actuen.codiPellicula = pellicules.codi
ORDER BY pellicula, actor;

SELECT titol AS pellicula, nom AS actor 
FROM pellicules JOIN actuen
ON actuen.codiPellicula = pellicules.codi
JOIN persones 
ON actuen.codiPersona = persones.codi
ORDER BY pellicula, actor;


-- 7. Nom de cada pel·lícula, juntament amb els 
-- noms de cadascun dels seus actors, fins i tot
-- per a les pel·lícules de les quals no coneixem
-- els actors

SELECT titol AS pellicula, nom AS actor 
FROM pellicules LEFT JOIN actuen
ON actuen.codiPellicula = pellicules.codi
LEFT JOIN persones 
ON actuen.codiPersona = persones.codi
ORDER BY pellicula, actor;


-- 8. Nom de tots els actors/directors i totes 
-- les pel·lícules, relacionats quan corresponga, 
-- ordenat en primer lloc per persona i en segon 
-- lloc per pel·lícula

SELECT nom, titol 
FROM pellicules FULL JOIN actuen
ON actuen.codiPellicula = pellicules.codi
FULL JOIN persones 
ON actuen.codiPersona = persones.codi
ORDER BY nom, titol;

-- 9. Llista de actors, ordenats alfabèticament,
-- i quantitat de pel·lícules en que han participat.

-- 9a. Actors i pel·lícules

SELECT nom, titol 
FROM persones JOIN actuen
ON persones.codi = actuen.codiPersona
JOIN pellicules 
ON actuen.codiPellicula = pellicules.codi
ORDER BY nom, titol;

-- 9b. Vista

CREATE VIEW v_actoresPellicules AS
    SELECT nom, titol 
    FROM persones JOIN actuen
    ON persones.codi = actuen.codiPersona
    JOIN pellicules 
    ON actuen.codiPellicula = pellicules.codi
    ORDER BY nom, titol;

SELECT * FROM v_actoresPellicules;

SELECT nom, COUNT(*)
FROM v_actoresPellicules
GROUP BY nom;

-- 9c. Alternativa compacta

SELECT nom, COUNT(*) 
FROM persones JOIN actuen
ON persones.codi = actuen.codiPersona
GROUP BY nom
ORDER BY nom;

-- 10. Actors que han treballat en pel·licules
-- dirigides per Ridley Scott

