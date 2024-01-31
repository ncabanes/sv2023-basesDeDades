-- A partir de les dades de sèries i canals de televisió:

CREATE TABLE canals ( 
  codi VARCHAR(4) PRIMARY KEY, 
  nom VARCHAR(15)
);

CREATE TABLE series ( 
  codi VARCHAR(5) PRIMARY KEY, 
  nom VARCHAR(20),
  temporades NUMERIC(3),
  codiCanal VARCHAR(4),
  FOREIGN KEY (codiCanal) REFERENCES canals(codi)
);

INSERT INTO canals VALUES ('hbo', 'HBO Max');
INSERT INTO canals VALUES ('d+', 'Disney+');
INSERT INTO canals VALUES ('nf', 'Netflix');
INSERT INTO canals VALUES ('amz', 'Amazon');

INSERT INTO series VALUES ('si', 'Los Simpsons', 34, 'd+');
INSERT INTO series VALUES ('man', 'The mandalorian', 2, 'd+');
INSERT INTO series VALUES ('ar', 'Arcane', 1, 'nf');
INSERT INTO series VALUES ('ryan', 'Jack Ryan', 3, 'amz');
INSERT INTO series VALUES ('exp', 'The expanse', 6, 'amz');
INSERT INTO series VALUES ('ro', 'Roswell, New Mexico', 4, 'hbo');
INSERT INTO series VALUES ('strng', 'Stranger Things', NULL, NULL);
INSERT INTO series VALUES ('boys', 'The boys', 3, 'amz');

-- -----------

-- 1. Canvia el codi de canal a NULL per a la sèrie anomenada "The expanse", que no s'emet ja.

UPDATE series SET codicanal = NULL WHERE series.nom = 'The expanse';


-- 2. Anota que la sèrie de codi "man" té 3 temporades.

UPDATE series SET temporades = 3 WHERE codi = 'man';


-- 3. Incrementa en 1 la quantitat de temporades de la sèrie anomenada "Los Simpsons"

UPDATE series SET temporades = temporades + 1 WHERE nom = 'Los Simpsons';


-- 4. Afig una sèrie amb codi "bear", nom "Bear", de 2 temporades i que no sabem en quin canal s'emet.

INSERT INTO series VALUES ('bear', 'Bear', 2, NULL);

-- Aternatiu, detallant tots els camps:

INSERT INTO series(codi, nom, temporades)
VALUES('bear', 'Bear', 2);


-- 5. Modifica alhora el nom (a "The Bear") i la quantitat de temporades (a 1) de la sèrie de codi "bear". Fes-ho de 2 formes diferents: amb UPDATE i, si el teu gestor de bases de dades ho permet, amb REPLACE.

UPDATE series SET nom = 'The Bear', temporades = 1 WHERE CODI = 'bear';

-- Alternatiu, no en tots els gestors: REPLACE

REPLACE INTO series VALUES ('bear', 'The Bear', 1, NULL);

-- També, detallant tots els camps:

REPLACE INTO series(codi, nom, temporades)
VALUES('bear','The Bear', 1);


-- 6. Esborra la sèrie de codi "exp".

DELETE FROM series WHERE codi = 'exp';


-- -----------

-- (Enunciado en castellano)

-- 1. Cambia el código de canal a NULL para la serie llamada "The expanse", que no se emite ya.
-- 2. Anota que la serie de código "man" tiene 3 temporadas.
-- 3. Incrementa en 1 la cantidad de temporadas de la serie llamada "Los Simpsons"
-- 4. Añade una serie con código "bear", nombre "Bear", de 2 temporadas y que no sabemos en qué canal se emite.
-- 5. Modifica a la vez el nombre (a "The Bear") y la cantidad de temporadas (a 1) de la serie de código "bear". Hazlo de 2 formas distintas: con UPDATE y, si tu gestor de bases de datos lo permite, con REPLACE.
-- 6. Borra la serie de código "exp".
