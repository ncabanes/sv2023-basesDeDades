CREATE TABLE esdeveniments 
(
  codi VARCHAR2(5),
  nom VARCHAR2(40),
  data_ini DATE,
  data_fi DATE,
  CONSTRAINT pk_esdeveniments PRIMARY KEY(codi)
);

INSERT INTO esdeveniments VALUES('jdm',
    'Quedada coches japoneses', 
    TO_DATE('2024-02-24', 'YYYY-MM-DD'), 
    TO_DATE('2024-02-25', 'YYYY-MM-DD'));

INSERT INTO esdeveniments VALUES('jwm',
    'Japan Weekend Madrid', 
    TO_DATE('2024-02-16', 'YYYY-MM-DD'), 
    TO_DATE('2024-02-18', 'YYYY-MM-DD'));

-- Comprovació

SELECT * FROM esdeveniments;

-- Esdeveniments acabats, prefixant la data

SELECT * FROM esdeveniments
WHERE data_fi < TO_DATE('2024-02-23', 'YYYY-MM-DD');

-- Esdeveniments acabats, amb funcions del sistema (Oracle)

SELECT * FROM esdeveniments
WHERE data_fi < CURRENT_DATE;

-- Duració dels esdeveniments (Oracle)

SELECT nom, data_fi - data_ini AS duracio FROM esdeveniments;
