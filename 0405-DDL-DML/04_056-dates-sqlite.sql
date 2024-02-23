CREATE TABLE esdeveniments 
(
  codi VARCHAR(5) PRIMARY KEY,
  nom VARCHAR(40),
  data_ini DATE,
  data_fi DATE
);

INSERT INTO esdeveniments VALUES('jdm',
    'Quedada coches japoneses', '2024-02-24', '2024-02-25');

-- En SQLite, no Mysql, per llegibilitat

.mode column

-- Comprovació

SELECT * FROM esdeveniments;

-- Dada addicional

INSERT INTO esdeveniments VALUES('jwm',
    'Japan Weekend Madrid', '2024-02-16', '2024-02-18');

-- Esdeveniments acabats, prefixant la data

SELECT * FROM esdeveniments
WHERE data_fi < '2024-02-23';

-- Esdeveniments acabats, amb funcions del sistema

-- SQLite

SELECT * FROM esdeveniments
WHERE data_fi < DATE('NOW');

-- MySQL

SELECT * FROM esdeveniments
WHERE data_fi < NOW();


-- Duració dels esdeveniments

-- SQLite

SELECT nom, JulianDay(data_fi) - JulianDay(data_ini) AS duracio FROM esdeveniments;

-- MySQL

SELECT nom, data_fi - data_ini AS duracio FROM esdeveniments;
