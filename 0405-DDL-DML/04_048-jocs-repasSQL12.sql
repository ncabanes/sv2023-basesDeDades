-- Repàs 12 (jocs + plataformes)

CREATE TABLE plataformes(
    codi CHAR(4),
    nom VARCHAR2(25) NOT NULL,
    CONSTRAINT pk_plataformes PRIMARY KEY (codi),
    CONSTRAINT uk_plataformes_nom UNIQUE(nom)
);

CREATE TABLE Jocs(
    codi CHAR(5),
    nom VARCHAR2(50) NOT NULL, 
    descripcion VARCHAR2(1000), 
    dataLlan DATE,
    espaiOcupat NUMBER(7,3),
    codiPlataforma CHAR(4),
    CONSTRAINT pk_jocs PRIMARY KEY(codi),
    CONSTRAINT ck_jocs_codi CHECK(codi = UPPER(codi)),
    CONSTRAINT ck_jocs_espaiOcupat CHECK(espaiOcupat <= 500),
    CONSTRAINT fk_jocs_plataformes FOREIGN KEY(codiPlataforma)
        REFERENCES plataformes(codi)   
);

INSERT INTO plataformes VALUES ('PS3','PlayStation3');
INSERT INTO plataformes VALUES ('X360','Xbox 360');
INSERT INTO plataformes VALUES ('PCS', 'Steam');

INSERT INTO jocs(codi, nom,codiPlataforma) VALUES('GT5', 'Gran Turismo 5','PS3');
INSERT INTO jocs(codi, nom,codiPlataforma) VALUES('TLOU', 'The Last of Us','PS3');

INSERT INTO jocs(codi, nom,codiPlataforma) VALUES('HL', 'Half Life','PCS');
INSERT INTO jocs(codi, nom,codiPlataforma) VALUES('SV', 'Stardew Valley','PCS');
INSERT INTO jocs(codi, nom,codiPlataforma) VALUES('TF2', 'Team Fortress 2','PCS');

-- 1. Nombre de cada juego y nombre de la plataforma a la que pertenece, enlazando tablas con WHERE.

SELECT j.nom AS nomJoc, p.nom AS nomPlat
FROM jocs j, plataformes p
WHERE j.codiPlataforma = p.codi;

-- 2. Nombre de cada juego y nombre de la plataforma a la que pertenece, enlazando tablas con JOIN.

SELECT j.nom AS nomJoc, p.nom AS nomPlat
FROM jocs j JOIN plataformes p
ON j.codiPlataforma = p.codi;

-- 3. Nombre de cada plataforma y cantidad de juegos que tenemos para ella.

SELECT p.nom AS nomPlat, COUNT(j.codi) AS quantitat
FROM plataformes p LEFT JOIN jocs j
ON j.codiPlataforma = p.codi
GROUP BY p.nom;

-- 4, 5, 6. Plataformas que contengan una B en segunda posición

SELECT nom
FROM PLATAFORMES
WHERE INSTR(UPPER(nom),'B') = 2;

SELECT nom
FROM PLATAFORMES
WHERE UPPER(SUBSTR(nom,2,1)) = 'B';

SELECT nom
FROM plataformes
WHERE UPPER(nom) LIKE '_B%';

-- 7, 8, 9, 10. Plataformas que se llamen igual que algún juego.

INSERT INTO jocs (codi, nom) VALUES ('PCS', 'Steam');

-- Operaciones de conjuntos

SELECT nom FROM plataformes
INTERSECT
SELECT nom FROM jocs;

-- = / IN

SELECT nom
FROM PLATAFORMES
WHERE nom IN 
(
    SELECT nom FROM jocs
);

-- ALL / ANY (No en SQLite)

SELECT nom
FROM PLATAFORMES
WHERE nom = ANY
(
    SELECT nom FROM jocs
);

-- EXISTS / NOT EXISTS

SELECT nom
FROM PLATAFORMES p
WHERE EXISTS
(
    SELECT nom FROM jocs j WHERE p.nom = j.nom
);


-- 11, 12, 13, 14. Plataformas que se llamen de forma distinta a todos los juegos.

-- Oracle

SELECT nom FROM plataformes
MINUS
SELECT nom FROM jocs;

-- Oracle y SQLite

SELECT nom FROM plataformes
EXCEPT
SELECT nom FROM jocs;

-- NOT IN

SELECT nom
FROM PLATAFORMES
WHERE nom NOT IN 
(
    SELECT nom FROM jocs
);

-- ALL / ANY

SELECT nom
FROM PLATAFORMES
WHERE nom <> ALL
(
    SELECT nom FROM jocs
);

-- EXISTS / NOT EXISTS

SELECT nom
FROM PLATAFORMES p
WHERE NOT EXISTS
(
    SELECT nom FROM jocs j WHERE p.nom = j.nom
);

-- 15. Juegos de la plataforma con más juegos.

-- Forma 1: Oracle, ALL

-- Paso 1.1: Cantidad de juegos por plataforma

SELECT COUNT(j.codi) 
FROM plataformes p JOIN jocs j ON j.codiPlataforma = p.codi 
GROUP BY p.codi;

-- Paso 1.2: Cödigo de ese plataforma (Oracle)

SELECT p.codi 
FROM plataformes p JOIN jocs j ON j.codiPlataforma = p.codi 
GROUP BY p.codi HAVING COUNT(j.codi) >= ALL
(
    SELECT COUNT(j.codi) 
    FROM plataformes p JOIN jocs j ON j.codiPlataforma = p.codi 
    GROUP BY p.codi
);

-- Paso 1.3: Juegos de la plataforma que tiene ese código

SELECT *
FROM jocs
WHERE codiPlataforma =
(
    SELECT p.codi 
    FROM plataformes p JOIN jocs j ON j.codiPlataforma = p.codi 
    GROUP BY p.codi HAVING COUNT(j.codi) >= ALL
    (
        SELECT COUNT(j.codi) 
        FROM plataformes p JOIN jocs j ON j.codiPlataforma = p.codi 
        GROUP BY p.codi
    )
);

-- Forma 2: SQLite, LIMIT

-- Paso 2.1: Cantidad de juegos por plataforma, ordenado descendente

SELECT p.codi, COUNT(j.codi) 
FROM plataformes p LEFT JOIN jocs j ON j.codiPlataforma = p.codi 
GROUP BY p.codi
ORDER BY COUNT(j.codi) DESC;

-- Paso 2.2: Juegos de la plataforma que tiene como código el primero de esa lista

SELECT *
FROM jocs
WHERE codiPlataforma =
(
    SELECT p.codi
    FROM plataformes p LEFT JOIN jocs j ON j.codiPlataforma = p.codi 
    GROUP BY p.codi
    ORDER BY COUNT(j.codi) DESC
    LIMIT 1
);
