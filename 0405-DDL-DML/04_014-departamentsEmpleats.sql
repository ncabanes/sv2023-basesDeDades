CREATE TABLE departaments 
( 
  codi NUMERIC(3) PRIMARY KEY, 
  nom VARCHAR(20)
);

CREATE TABLE empleats 
( 
  codi VARCHAR(5) PRIMARY KEY, 
  nom VARCHAR(25),
  codiDepartament NUMERIC(3)
);

-- -------

INSERT INTO departaments VALUES (11, 'Vendes');
INSERT INTO departaments VALUES (12, 'Enginyeria');
INSERT INTO departaments VALUES (13, 'Producció');
INSERT INTO departaments VALUES (14, 'Màrqueting');

INSERT INTO empleats VALUES ('jo', 'Joan', 14);
INSERT INTO empleats VALUES ('la', 'Laia', 11);
INSERT INTO empleats VALUES ('ar', 'Ariadna', 15);
INSERT INTO empleats VALUES ('al', 'Albert', NULL);

-- -------

-- A partir d'eixes dues taules, mostra:
-- 
-- 1. Noms dels empleats el codi de departament dels quals siga el 11, ordenats alfabèticament.

SELECT nom 
FROM empleats
WHERE codidepartament = 11
ORDER BY nom;


-- 2. Nom i codi dels empleats el nom dels quals comença per "A".

SELECT nom, codi 
FROM empleats
WHERE nom LIKE 'A%';


-- 3. Nom dels empleats per als quals no coneixem el departament.

SELECT nom
FROM empleats
WHERE codidepartament IS NULL;


-- 4 i 5. Codi i nom dels departaments el codi dels quals està entre 12 i 20, de 2 formes diferents.

SELECT codi, nom
FROM departaments
WHERE codi >= 12 AND codi <= 20;

SELECT codi, nom
FROM departaments
WHERE codi BETWEEN 12 AND 20;


-- 6. Quantitat d'empleats.

SELECT COUNT(*)
FROM empleats;


-- 7. Codis de departament en els quals realment hi ha empleats, sense duplicats.

SELECT DISTINCT(codidepartament)
FROM empleats
WHERE codidepartament IS NOT NULL;

-- Preferible

SELECT DISTINCT(codidepartament)
FROM empleats;


-- 8. Codi de cada departament que apareix en la taula d'empleats, juntament amb la quantitat d'empleats que conté.

SELECT codidepartament, COUNT(*)
FROM empleats
GROUP BY codidepartament;


-- 9. Codi de cada departament que apareix en la taula d'empleats, juntament amb la quantitat d'empleats que conté, però només per als departaments amb 2 o més empleats.

SELECT codidepartament, COUNT(*)
FROM empleats
GROUP BY codidepartament
HAVING COUNT(*) >= 2;


-- 10. Nom de cada empleat i nom del departament en el qual treballa.

SELECT empleats.nom, departaments.nom
FROM empleats, departaments
WHERE empleats.codiDepartament = departaments.codi;

-- Amb Oracle

SELECT 
    empleats.nom AS nomEmpleat, 
    departaments.nom AS nomDepart
FROM empleats, departaments
WHERE empleats.codiDepartament = departaments.codi;


-- ---

-- A partir de esas dos tablas, muestra:
-- 
-- 1. Nombres de los empleados cuyo código de departamento sea el 11, ordenados alfabéticamente.
-- 
-- 2. Nombre y código de los empleados cuyo nombre empieza por "A".
-- 
-- 3. Nombre de los empleados para los que no conocemos el departamento.
-- 
-- 4 y 5. Código y nombre de los departamentos cuyo código está entre 12 y 20, de 2 formas distintas.
-- 
-- 6. Cantidad de empleados.
-- 
-- 7. Códigos de departamento en los que realmente hay empleados, sin duplicados.
-- 
-- 8. Código de cada departamento que aparece en la tabla de empleados, junto con la cantidad de empleados que contiene.
-- 
-- 9. Código de cada departamento que aparece en la tabla de empleados, junto con la cantidad de empleados que contiene, pero sólo para los departamentos con 2 o más empleados.
-- 
-- 10. Nombre de cada empleado y nombre del departamento en el que trabaja.
-- 
