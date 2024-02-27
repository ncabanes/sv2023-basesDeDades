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

-- Afig tres dades d'exemple

INSERT INTO estudiantsData 
(nia, nom, cognoms, dataNaixement)
VALUES (33, 'Larry', 'Bird',  TO_DATE( '07-12-1956', 'DD-MM-YYYY')); 

INSERT INTO estudiantsData 
VALUES (6, 'LeBron', 'James',  TO_DATE( '30-1984-12', 'DD-YYYY-MM'), NULL); 


-- Mostra totes les dades

SELECT * FROM estudiantsData;


-- Mostra nom, cognoms i data de naixement, ordenats del més jove al més vell

SELECT nom, cognoms, dataNaixement 
FROM estudiantsData
ORDER BY dataNaixement DESC;