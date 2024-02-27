CREATE TABLE estudiantsData ( 
  nia NUMERIC(10) PRIMARY KEY, 
  nom VARCHAR(25), 
  cognoms VARCHAR(50), 
  dataNaixement DATE,
  email VARCHAR(100)
);

INSERT INTO estudiantsData VALUES (23, 'Michael', 'Jordan', 
    TO_DATE( '1963-02-17', 'YYYY-MM-DD'), 'michael@jordan.com'); 

INSERT INTO estudiantsData VALUES (32, 'Earvin', 'Johnson', 
    TO_DATE( '1959-08-14','YYYY-MM-DD'), 'magic@johnson.com');


-- 1. Mostra els cognoms, el nom i la data que era 10 dies després que nasquera cada alumne.

SELECT nom, cognoms, dataNaixement + 10 AS diesDespres
FROM estudiantsData;


-- 2. Mostra (els cognoms, el nom i) la data que era 2 mesos després que nasquera cada alumne.

SELECT nom, cognoms, ADD_MONTHS(dataNaixement, 2) AS mesosDespres
FROM estudiantsData;


-- Mostra els mesos que han transcorregut entre la data actual i la data de naixement de cada estudiant.

SELECT nom, cognoms, 
	TRUNC(MONTHS_BETWEEN(SYSDATE, dataNaixement)) AS mesosViu
FROM estudiantsData;



-- Mostra l'edat que els alumnes tenen actualment.

SELECT nom, cognoms, 
	TRUNC(MONTHS_BETWEEN(SYSDATE, dataNaixement) / 12) AS edat
FROM estudiantsData;

SELECT nom, cognoms, 
	TRUNC((SYSDATE - dataNaixement) / 365) AS edat
FROM estudiantsData;


-- Mostra (els cognoms, el nom i) l'edat que els alumnes tenien el 2 de març de 2010. 

SELECT nom, cognoms, 
	TRUNC(MONTHS_BETWEEN(
		TO_DATE('02-03-2010', 'DD-MM-YYYY'), 
		dataNaixement) / 12) AS edat2010
FROM estudiantsData;


-- Mostra quants dies faltaven fins a final de mes quan van nàixer els estudiants.

SELECT nom, cognoms, 
	LAST_DAY(dataNaixement)- dataNaixement AS diesRestants
FROM estudiantsData;


-- Data del dilluns següent al seu naixement

SELECT nom, cognoms, 
	NEXT_DAY(dataNaixement, 'Monday') AS properDilluns
FROM estudiantsData;


-- Dia de la setmana de naixement

SELECT nom, cognoms, TO_CHAR(dataNaixement, 'DD') AS diaSetmana
FROM estudiantsData;

SELECT nom, cognoms, TO_CHAR(dataNaixement, 'Day') AS diaSetmana
FROM estudiantsData;
