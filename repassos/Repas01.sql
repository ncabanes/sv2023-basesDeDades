-- R1.01. Crea una taula que ens permeta fer un seguiment de preus 
-- d'articles de Amazon: codi (12 lletres), nom (fins a 50 lletres), data 
-- de comprovació (data) i preu (número amb 5 xifres abans de la coma i 2 
-- xifres després). Suposarem que un mateix article pot tindre diferents 
-- preus (o no tindria sentit el nostre sistema d'informació), però només 
-- anotarem un preu en cada dia. Usa sintaxi de Oracle i crea la taula amb 
-- la clau primària que consideres adequada.

CREATE TABLE SeguimentPreus (
    codi VARCHAR2(12),
    nom VARCHAR2(50),
    dataComprovacio DATE , 
    preu NUMBER(7,2) NOT NULL,
    CONSTRAINT pk_SeguimentPreus PRIMARY KEY (codi,dataComprovacio) 
);



-- R1.02. Introduïx almenys 3 dades. Per exemple el "Crucial X6 2TB SSD 
-- Portàtil", amb codi "B08FSNKNSV" té un preu de 126,54 el 2 d'abril de 
-- 2024. Tria altres dos articles (o més).

-- Oracle

INSERT INTO SeguimentPreus VALUES ('B08FSNKNSV','Crucial X6 2TB SSD Portàtil',TO_DATE ('2024-04-02','YYYY-MM-DD'),126.54);
INSERT INTO SeguimentPreus VALUES ('QUMOX ','Mando a Distancia Control Remoto',TO_DATE ('2024-02-25','YYYY-MM-DD'),21.19);
INSERT INTO SeguimentPreus VALUES ('ACNHNS','Animal Crossing: New Horizons(Nintendo Switch)',TO_DATE ('2022-03-05','YYYY-MM-DD'),45.99);

-- SQLite, MySQL

INSERT INTO SeguimentPreus VALUES ('B08FSNKNSV','Crucial X6 2TB SSD Portàtil','2024-04-02',126.54);
INSERT INTO SeguimentPreus VALUES ('QUMOX ','Mando a Distancia Control Remoto','2024-02-25',21.19);
INSERT INTO SeguimentPreus VALUES ('ACNHNS','Animal Crossing: New Horizons(Nintendo Switch)','2022-03-05',45.99);



-- R1.03. Afig una dada addicional: el "Crucial X6 2TB SSD Portàtil", 
-- amb codi "B08FSNKNSV" va tindre un preu de 100,00 el 6 de gener de 2024.

-- Oracle

INSERT INTO SeguimentPreus VALUES ('B08FSNKNSV','Crucial X6 2TB SSD Portàtil',TO_DATE ('2024-01-06','YYYY-MM-DD'),100.00);

-- SQLite, MySQL

INSERT INTO SeguimentPreus VALUES ('B08FSNKNSV','Crucial X6 2TB SSD Portàtil','2024-01-06',100.00);



--Emprant SQL:

-- R1.04. Cerca el menor preu del qual tenim constància per a l'article 
-- amb codi "B08FSNKNSV".

SELECT MIN(preu) as PreuMesBarat FROM SeguimentPreus WHERE codi ='B08FSNKNSV';



-- R1.05. Mostra la diferència entre el preu actual i el menor preu 
-- del qual tenim constància, per a l'article amb codi "B08FSNKNSV".

SELECT MAX(preu)-MIN(preu) FROM SeguimentPreus WHERE codi ='B08FSNKNSV';



-- R1.06. Comprova quants preus ens apareixen per a l'article amb 
-- codi "B08FSNKNSV".

SELECT COUNT(preu) FROM SeguimentPreus WHERE codi ='B08FSNKNSV';



-- R1.07. Mostra en quines dates va aconseguir el seu preu mínim 
-- l'article amb codi "B08FSNKNSV".

SELECT dataComprovacio FROM SeguimentPreus 
WHERE codi ='B08FSNKNSV' AND preu =
(
    SELECT MIN(preu) FROM SeguimentPreus WHERE codi ='B08FSNKNSV'
);


-- R1.08. Mostra l'article el preu del qual haja baixat més, 
-- de tots els que tenim en la base de dades.

-- 1. Articles i preus

SELECT nom, preu FROM SeguimentPreus;

-- 2. Articles, preu mínim i preu màxim

SELECT nom, MAX(preu), MIN(preu) FROM SeguimentPreus
GROUP BY nom;

-- 3. Articles i diferència de preus, ordenat

SELECT nom, MAX(preu) - MIN(preu) AS dif FROM SeguimentPreus
GROUP BY nom
ORDER BY dif DESC;

-- 4a. Resposta final, Oracle

SELECT nom FROM SeguimentPreus
GROUP BY nom
ORDER BY MAX(preu) - MIN(preu) DESC
FETCH NEXT 1 ROWS ONLY;

-- 4a. Resposta final, SQLite i MySQL

SELECT nom FROM SeguimentPreus
GROUP BY nom
ORDER BY MAX(preu) - MIN(preu) DESC
LIMIT 1;
