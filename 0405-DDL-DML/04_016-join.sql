-- A partir de les dades de departaments i empleats:

CREATE TABLE departaments (
  codi NUMERIC(3) PRIMARY KEY,
  nom VARCHAR(20)
);

CREATE TABLE empleats (
  codi VARCHAR(5) PRIMARY KEY,
  nom VARCHAR(25),
  codiDepartament NUMERIC(3)
);

INSERT INTO departaments VALUES (11, 'Vendes');
INSERT INTO departaments VALUES (12, 'Enginyeria');
INSERT INTO departaments VALUES (13, 'Producció');
INSERT INTO departaments VALUES (14, 'Màrqueting');

INSERT INTO empleats VALUES ('jo', 'Joan', 14);
INSERT INTO empleats VALUES ('la', 'Laia', 11);
INSERT INTO empleats VALUES ('ar', 'Ariadna', 15);
INSERT INTO empleats VALUES ('al', 'Albert', NULL);

-- Mostra el nom de cada empleat i el del seu departament, 
-- emprant WHERE per a enllaçar les taules

select empleats.nom as nomE, departaments.nom as nomD
from empleats, departaments
where empleats.codiDepartament = departaments.codi;

-- Mostra el nom de cada empleat i el del seu departament 
-- (només per als empleats que tinguen departament), 
-- emprant JOIN per a enllaçar les taules

select empleats.nom as nomE, departaments.nom as nomD
from empleats join departaments
on empleats.codiDepartament = departaments.codi;

select empleats.nom as nomE, departaments.nom as nomD
from empleats inner join departaments
on empleats.codiDepartament = departaments.codi;

-- Mostra els noms de tots els empleats, juntament amb 
-- el del seu departament, si existeix

select empleats.nom as nomE, departaments.nom as nomD
from empleats left join departaments
on empleats.codiDepartament = departaments.codi;

-- Mostra els noms de tots els departaments, juntament amb 
-- el dels empleats que hi ha en ells, si n'hi ha

select empleats.nom as nomE, departaments.nom as nomD
from empleats right join departaments
on empleats.codiDepartament = departaments.codi;

select empleats.nom as nomE, departaments.nom as nomD
from departaments left join empleats
on empleats.codiDepartament = departaments.codi;

-- Mostra els noms de tots els empleats 
-- i els de tots els departaments, 
-- enllaçant-los on corresponga

select empleats.nom as nomE, departaments.nom as nomD
from empleats full  join departaments
on empleats.codiDepartament = departaments.codi;
