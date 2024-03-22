-- Repàs SQL + PL/SQL 01

-- Taules (les mateixes de 6.000)

CREATE TABLE plataformes(
    codi CHAR(4), 
    nom VARCHAR2(30),
    CONSTRAINT pk_plataformes PRIMARY KEY (codi)
);

CREATE TABLE jocs(
    codi CHAR(5), 
    nom VARCHAR2(50),
    descripcio VARCHAR2(1000),
    anyLlancament NUMBER(4),
    espaiOcupatMb NUMBER(9,3), 
    codiPlataforma CHAR(4), 
    CONSTRAINT pk_jocs PRIMARY KEY (codi),
    CONSTRAINT fk_jocs_plataformes 
        FOREIGN KEY (codiPlataforma) REFERENCES plataformes(codi)
); 

INSERT INTO plataformes VALUES('cpc', 'Amstrad CPC');
INSERT INTO plataformes VALUES('pcw', 'Amstrad PCW');
INSERT INTO plataformes VALUES('msx', 'MSX');
INSERT INTO plataformes VALUES('spec', 'Sinclair ZX Spectrum');
INSERT INTO plataformes VALUES('psx', 'Playstation');
INSERT INTO plataformes VALUES('ps2', 'Playstation 2');
INSERT INTO plataformes VALUES('ps3', 'Playstation 3');
INSERT INTO plataformes VALUES('ps4', 'Playstation 4');
INSERT INTO plataformes VALUES('ps5', 'Playstation 5');
INSERT INTO plataformes VALUES('wii', 'Nintendo WII');
INSERT INTO plataformes VALUES('stea', 'PC + Steam');
INSERT INTO plataformes VALUES('epic', 'PC + Epic');

INSERT INTO jocs VALUES('efre', 'Electro Freddy', NULL, 1982, 0.2, 'cpc');
INSERT INTO jocs VALUES('mmic', 'Manic Miner', 'Plataformas sin scroll', 1983, 0.2, 'cpc');
INSERT INTO jocs VALUES('mmiz', 'Manic Miner', 'Plataformas sin scroll', 1983, 0.2, 'spec');
INSERT INTO jocs VALUES('aa', 'Ant Attack', NULL, 1983, 0.1, 'spec');
INSERT INTO jocs VALUES('ikaw', 'Ikari Warriors', 'Disparos, vista cenital', 1986, 0.2, 'msx');
INSERT INTO jocs VALUES('wsr', 'Wii Sports Resort', NULL, 2009, 0, 'wii');
INSERT INTO jocs VALUES('gt5', 'Gran Turismo 5', NULL, 2010, 0, 'ps3');
INSERT INTO jocs VALUES('last1', 'The last of US', NULL, 2013, NULL, 'ps3');
INSERT INTO jocs VALUES('fortn', 'Fortnite', 'FPS + Battle Royale', 2017, NULL, 'epic');
INSERT INTO jocs VALUES('aliso', 'Alien: Isolation', NULL, 2017, 35000, 'epic');
INSERT INTO jocs VALUES('cont', 'Control', 'Aventura', 2019, NULL, 'epic');
INSERT INTO jocs VALUES('batao', 'Batman: A.O.', NULL, 2013, 18250, 'stea');

-- Dades dels jocs, excepte del més modern, de 3 formes diferents

-- 1: MAX

SELECT * FROM jocs WHERE anyLlancament <>
(
    SELECT MAX(anyLlancament) FROM jocs
)
ORDER BY anyLlancament DESC;

-- 2: ALL / ANY

SELECT * FROM jocs WHERE anyLlancament < ANY
(
    SELECT anyLlancament FROM jocs
)
ORDER BY anyLlancament DESC;

--3a: EXISTS / NOT EXISTS

SELECT * FROM jocs j1 WHERE EXISTS 
(
    SELECT *  FROM jocs j2
     WHERE j1.anyLlancament < j2.anyLlancament
)
ORDER BY anyLlancament DESC;


-- 3b: FETCH

SELECT * FROM jocs 
ORDER BY anyLlancament DESC 
OFFSET 1 ROWS FETCH FIRST 1000 ROWS WITH TIES;


-- PL/SQL 1: Escriu "Antonio safugao" des de PL/SQL

BEGIN
    dbms_output.put_line('Antonio safugao');
END;

-- PL/SQL 2: Obtingues l'any més recent, guarda'l en una variable i mostra'l

DECLARE 
    anyModern NUMBER(4);
BEGIN
    SELECT MAX(anyLlancament)
        INTO anyModern 
        FROM jocs;
    dbms_output.put_line('Any més modern:' || anyModern);
END;
