-- A partir de la següent estructura de taules sobre llenguatges de programació i compiladors (en la qual, per simplificar, suposarem que cada compilador és per a un únic llenguatge):
-- 
-- Llenguatges(codi, nom, anyCreació)
-- Compiladors(codiCompilador, nom, codiLlenguatge)
-- VersionsDeCompiladors(codiCompilador, númeroVersió, dataLlançament)
-- 
-- i les següents dades d'exemple:

CREATE TABLE llenguatges (
  codi VARCHAR(4) PRIMARY KEY,
  nom VARCHAR(20),
  anyCreacio NUMBER(4)
);

CREATE TABLE compiladors (
  codi VARCHAR(6) PRIMARY KEY,
  nom VARCHAR(30),
  codiLlenguatge VARCHAR(4)
);

CREATE TABLE versionsCompiladors (
  codiComp VARCHAR(6),
  numVersio VARCHAR(10),
  dataLlanc NUMBER(4),
  PRIMARY KEY (codiComp, numVersio)
);

INSERT INTO llenguatges VALUES ('cob', 'COBOL', 1959);
INSERT INTO llenguatges VALUES ('bas', 'BASIC', 1964);
INSERT INTO llenguatges VALUES ('pas', 'Pascal', 1970);
INSERT INTO llenguatges VALUES ('c', 'C', 1972);
INSERT INTO llenguatges VALUES ('cpp', 'C++', 1983);
INSERT INTO llenguatges VALUES ('py', 'Python', 1991);
INSERT INTO llenguatges VALUES ('cs', 'C#', 2000);

INSERT INTO compiladors VALUES ('tp', 'Turbo Pascal', 'pas');
INSERT INTO compiladors VALUES ('fp', 'Free Pascal', 'pas');
INSERT INTO compiladors VALUES ('tc', 'Turbo C', 'c');
INSERT INTO compiladors VALUES ('bc', 'Borland C++', 'cpp');
INSERT INTO compiladors VALUES ('owa', 'Open Watcom C++', 'cpp');
INSERT INTO compiladors VALUES ('vs', 'Visual Studio', 'cs');

INSERT INTO versionsCompiladors VALUES ('tp', '1.0', 1983);
INSERT INTO versionsCompiladors VALUES ('tp', '7.0', 1992);
INSERT INTO versionsCompiladors VALUES ('fp', '3.2.2', 2021);
INSERT INTO versionsCompiladors VALUES ('bc', '3.1', 1992);
INSERT INTO versionsCompiladors VALUES ('owa', '1.9', 2010);
INSERT INTO versionsCompiladors VALUES ('vs', '2022 ', 2021);


-- 1.- Crea una vista "LlenguatgesICompiladors" que mostre tota la informació,  
-- donant prioritat als llenguatges: haurà d'aparéixer cada llenguatge (codi, 
-- nom i any) al costat de cada compilador (codi i nom) i cada versió (número 
-- i data de llançament). 

CREATE VIEW LlenguatgesICompiladors AS
    SELECT llenguatges.codi AS codiL, llenguatges.nom AS nomL, llenguatges.anyCreacio AS anyL,
        compiladors.codi AS codiC, compiladors.nom as nomC,
        versionsCompiladors.numVersio, versionsCompiladors.dataLlanc
    FROM llenguatges 
        LEFT JOIN compiladors ON compiladors.codiLlenguatge = llenguatges.codi
        LEFT JOIN versionsCompiladors ON versionsCompiladors.codiComp = compiladors.codi
    ORDER BY nomL, nomC, numVersio;

SELECT * FROM LlenguatgesICompiladors;


-- 2.- Crea un bloc anònim que mostre, de cada llenguatge, la quantitat de 
-- compiladors (sense tindre en compte les seues diferents versions) dels quals 
-- tenim constància. En cas que d'algun no tinguem cap compilador, haurà 
-- d'aparéixer "(Cap)" en comptes del número 0.

-- Prova prèvia

SELECT llenguatges.nom, COUNT(compiladors.codi)
FROM llenguatges LEFT JOIN compiladors
ON compiladors.codiLlenguatge = llenguatges.codi
GROUP BY llenguatges.nom
ORDER BY llenguatges.nom;

-- Solució

DECLARE
    CURSOR cursor_llenguatges IS
        SELECT llenguatges.nom, COUNT(compiladors.codi) AS quantitat
        FROM llenguatges LEFT JOIN compiladors
        ON compiladors.codiLlenguatge = llenguatges.codi
        GROUP BY llenguatges.nom
        ORDER BY llenguatges.nom;

BEGIN
    FOR l in cursor_llenguatges LOOP
        IF l.quantitat = 0 THEN
            dbms_output.put_line(l.nom || ': (Cap)');
        ELSE
            dbms_output.put_line(l.nom || ': ' || l.quantitat);
        END IF;
    END LOOP;
END;


-- 3.- Crea una funció "AnyMitjaCompilador" que retorne l'any mitjà d'un cert 
-- compilador, el codi del qual se li passarà com a paràmetre. Si aqueix 
-- compilador no existeix, retornarà -1. Prova-la.

-- Prova prèvia

SELECT AVG(dataLlanc) 
    FROM versionsCompiladors
    WHERE codiComp = 'tp';
-- Si la dada no existeix, retorna NULL
    
-- Funció

CREATE OR REPLACE FUNCTION AnyMitjaCompilador (v_codi IN VARCHAR2)
RETURN NUMBER
AS
    v_mitja NUMBER;
BEGIN
    SELECT AVG(dataLlanc) 
    INTO v_mitja
    FROM versionsCompiladors
    WHERE codiComp = v_codi;
    
    IF v_mitja IS NULL THEN
        RETURN -1;
    ELSE
        RETURN v_mitja;
    END IF;
END;

-- Prova

BEGIN
    dbms_output.put_line('tp: ' || AnyMitjaCompilador('tp'));
    dbms_output.put_line('xp: ' || AnyMitjaCompilador('xp'));
END;


-- 4.- Crea un procediment "MostrarCompiladors", que a partir del nom d'un 
-- llenguatge que se li passarà com a paràmetre (i que potser està totalment en 
-- majúscules o totalment en minúscules), mostre els compiladors que tenim per a 
-- aqueix llenguatge, incloent-hi versions. Si no existeix cap compilador, o no 
-- existeix aqueix llenguatge, no escriurà res. Empra un bucle "FOR".

CREATE OR REPLACE PROCEDURE MostrarCompiladors (v_nomLleng IN VARCHAR2)
AS
    CURSOR cursor_compiladors IS
        SELECT * 
        FROM LlenguatgesICompiladors
        WHERE UPPER(nomL) = UPPER(v_nomLleng);
BEGIN
    FOR comp in cursor_compiladors LOOP
        dbms_output.put_line(comp.codiC
             || ' - ' || comp.nomC
             || ' - ' || comp.numVersio
             || ' - ' || comp.DataLlanc);
    END LOOP;
END;

-- Prova

BEGIN
    dbms_output.put_line('-pascal:');
    MostrarCompiladors('pascal');
    
    dbms_output.put_line('-go:');
    MostrarCompiladors('go');
END;
