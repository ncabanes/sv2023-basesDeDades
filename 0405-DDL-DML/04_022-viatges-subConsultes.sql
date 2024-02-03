CREATE TABLE viatges ( 
  codi VARCHAR(5) PRIMARY KEY, 
  nom VARCHAR(25),
  preu NUMERIC(5),
  dies NUMERIC(3)
);

INSERT INTO viatges VALUES ('dp', 'Disneyland Paris', 118, 3);
INSERT INTO viatges VALUES ('pr', 'Praga', 194, 3);
INSERT INTO viatges VALUES ('na', 'Nápoles', NULL, NULL);
INSERT INTO viatges VALUES ('ro', 'Roma', 191, 3);
INSERT INTO viatges VALUES ('lp', 'Laponia', 1730, 5);
INSERT INTO viatges VALUES ('ri', 'Riviera Maya', 772, 9);
INSERT INTO viatges VALUES ('rm', 'Roma', 460, 4);

-- Ciutat i dies del viatge més car

-- 1. = MAX (subquery)

SELECT nom, dies FROM viatges 
WHERE preu = (SELECT MAX(preu) FROM viatges);

-- 2. >= ALL
-- (No en SQLite)

SELECT nom, dies FROM viatges 
WHERE preu >= ALL 
(
    SELECT preu FROM viatges 
    WHERE preu IS NOT NULL
);

-- 3. NOT EXISTS >

SELECT nom, dies FROM viatges v1
WHERE NOT EXISTS 
(
    SELECT preu FROM viatges v2
    WHERE v2.preu > v1.preu
)
AND v1.preu IS NOT NULL;

-- 4. ORDER BY + LIMIT

-- 4a (Amb sintaxi de SQLite i MySQL)

SELECT nom, dies FROM viatges 
ORDER BY preu DESC LIMIT 1;

-- 4a (Amb sintaxi de Oracle)

SELECT nom, dies FROM viatges 
ORDER BY preu DESC 
FETCH NEXT 1 ROWS ONLY;


-- ---------------------------------------------

-- Detalls dels viatges a la "ciutat favorita" (a la ciutat que més viatges té)

-- Pas 1: ciutat amb més viatges

SELECT nom
FROM viatges
GROUP BY nom
ORDER BY COUNT(*) DESC LIMIT 1;

-- Pas 2: viatges a eixa ciutat

-- No en MySQL, sí en SQLite

SELECT *
FROM viatges
WHERE nom = 
(
    SELECT nom
    FROM viatges
    GROUP BY nom
    ORDER BY COUNT(*) DESC LIMIT 1
);

-- Si pot haver-hi diverses ciutats amb eixa quantitat de viatges,
-- serà més robust usar "IN" en comptes de "=":

SELECT *
FROM viatges
WHERE nom IN 
(
    SELECT nom
    FROM viatges
    GROUP BY nom
    ORDER BY COUNT(*) DESC LIMIT 1
);


-- Alternativa difícil, amb diverses subconsultes

-- Pas 1: quantitat de viatges

SELECT COUNT(*) as quantitat
FROM viatges
GROUP BY nom;

-- Pas 2: Màxim d'eixa quantitat de viatges

SELECT MAX(quantitat)
FROM 
(
    SELECT COUNT(*) as quantitat
    FROM viatges
    GROUP BY nom
);

-- Pas 3: nom de les ciutats amb eixa quantitat de viatges

SELECT nom
FROM viatges
GROUP BY nom
HAVING COUNT(*) = 
(
    SELECT MAX(quantitat)
    FROM 
    (
        SELECT COUNT(*) as quantitat
        FROM viatges
        GROUP BY nom
    )
);

-- Pas 4: viatges a eixes ciutats

SELECT *
FROM viatges
WHERE nom IN 
(
    SELECT nom
    FROM viatges
    GROUP BY nom
    HAVING COUNT(*) = 
    (
        SELECT MAX(quantitat)
        FROM 
        (
            SELECT COUNT(*) as quantitat
            FROM viatges
            GROUP BY nom
        )
    )
);

