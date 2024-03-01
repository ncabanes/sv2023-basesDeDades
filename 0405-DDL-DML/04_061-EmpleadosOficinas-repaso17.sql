-- Extracto (retocado) de:
-- https://gist.githubusercontent.com/josejuansanchez/c408725e848afd64dd9a20ab37fba8c9/raw/94f317604fda43e5dc7b5e859be82307c62c4488/jardineria.sql

CREATE TABLE oficina (
  codigo_oficina VARCHAR(10) NOT NULL,
  ciudad VARCHAR(30) NOT NULL,
  pais VARCHAR(20) NOT NULL,
  valoracion NUMERIC(3,1),
  PRIMARY KEY (codigo_oficina)
);

CREATE TABLE empleado (
  codigo_empleado NUMERIC(6) NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  apellido1 VARCHAR(30) NOT NULL,
  codigo_oficina VARCHAR(10) NOT NULL,
  codigo_jefe NUMERIC(6) DEFAULT NULL,
  puesto VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (codigo_empleado),
  FOREIGN KEY (codigo_oficina) REFERENCES oficina (codigo_oficina),
  FOREIGN KEY (codigo_jefe) REFERENCES empleado (codigo_empleado)
);

-- Datos
INSERT INTO oficina VALUES ('BCN-ES','Barcelona','España', 7.4);
INSERT INTO oficina VALUES ('BOS-USA','Boston','EEUU', 7.7);
INSERT INTO oficina VALUES ('LON-UK','Londres','Inglaterra', 8.2);
INSERT INTO oficina VALUES ('MAD-ES','Madrid','España', 9.8);
INSERT INTO oficina VALUES ('PAR-FR','Paris','Francia', 6.4);
INSERT INTO oficina VALUES ('SFC-USA','San Francisco','EEUU', 8.9);
INSERT INTO oficina VALUES ('SYD-AU','Sydney','Australia', 8.7);
INSERT INTO oficina VALUES ('TAL-ES','Talavera de la Reina','España', 8.4);
INSERT INTO oficina VALUES ('TOK-JP','Tokyo','Japón', 7.7);

INSERT INTO empleado VALUES (1,'Marcos','Magaña','TAL-ES',NULL,'Director Gen.');
INSERT INTO empleado VALUES (2,'Ruben','López','TAL-ES',1,'Subdirector Mark.');
INSERT INTO empleado VALUES (3,'Alberto','Soria','TAL-ES',2,'Subdirector Ven.');
INSERT INTO empleado VALUES (4,'Maria','Solís','TAL-ES',2,'Secretaria');
INSERT INTO empleado VALUES (5,'Felipe','Rosas','TAL-ES',3,'Representante');
INSERT INTO empleado VALUES (6,'Juan Carlos','Martínez','TAL-ES',3,'Representante');
INSERT INTO empleado VALUES (7,'Carlos','Soria','MAD-ES',3,'Director');
INSERT INTO empleado VALUES (8,'Mariano','López','MAD-ES',7,'Representante');
INSERT INTO empleado VALUES (9,'Lucio','Campoamor','MAD-ES',7,'Representante');
INSERT INTO empleado VALUES (10,'Hilario','Rodriguez','MAD-ES',7,'Representante');
INSERT INTO empleado VALUES (11,'Emmanuel','Magaña','BCN-ES',3,'Director');
INSERT INTO empleado VALUES (12,'José Manuel','Martinez','BCN-ES',11,'Representante');
INSERT INTO empleado VALUES (13,'David','Palma','BCN-ES',11,'Representante');
INSERT INTO empleado VALUES (14,'Oscar','Palma','BCN-ES',11,'Representante');
INSERT INTO empleado VALUES (15,'Francois','Fignon','PAR-FR',3,'Director');
INSERT INTO empleado VALUES (16,'Lionel','Narvaez','PAR-FR',15,'Representante');
INSERT INTO empleado VALUES (17,'Laurent','Serra','PAR-FR',15,'Representante');
INSERT INTO empleado VALUES (18,'Michael','Sydney','SFC-USA',3,'Director');
INSERT INTO empleado VALUES (19,'Walter Santiago','Castillo','SFC-USA',18,'Representante');
INSERT INTO empleado VALUES (20,'Hilary','Washington','BOS-USA',3,'Director');
INSERT INTO empleado VALUES (21,'Marcus','Paxton','BOS-USA',20,'Representante');


-- Inspirado en:
-- https://josejuansanchez.org/bd/ejercicios-consultas-sql/index.html#jardiner%C3%ADa

-- 1. Devuelve el puesto, nombre, apellido y ciudad en la que trabaja el empleado 1, empleando INNER JOIN.

SELECT puesto, nombre, apellido1, ciudad 
FROM empleado INNER JOIN oficina
ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE codigo_empleado = 1;


-- 2. Devuelve el puesto, nombre, apellido y ciudad en la que trabaja el empleado 1, empleando WHERE.

SELECT puesto, nombre, apellido1, ciudad 
FROM empleado, oficina
WHERE empleado.codigo_oficina = oficina.codigo_oficina
AND codigo_empleado = 1;


-- 3. Nombre de los puestos disponibles (sin repeticiones).

SELECT DISTINCT puesto
FROM empleado;


-- 4. Nombre de cada puesto y cantidad de empleados que ocupan ese puesto, ordenado alfabéticamente.

SELECT puesto, COUNT(*) 
FROM empleado
GROUP BY puesto
ORDER BY puesto;


-- 5. Nombre de cada ciudad y cantidad de empleados que trabajan en ella (quizá 0), ordenado de mayor a menor cantidad de empleados, y en caso de coincidir esta, por nombre de ciudad (de al A a la Z).

SELECT ciudad, COUNT(*)
FROM oficina LEFT JOIN empleado
ON empleado.codigo_oficina = oficina.codigo_oficina
GROUP BY ciudad
ORDER BY COUNT(codigo_empleado) DESC, ciudad ASC;

SELECT ciudad, COUNT(codigo_empleado)
FROM oficina LEFT JOIN empleado
ON empleado.codigo_oficina = oficina.codigo_oficina
GROUP BY ciudad
ORDER BY COUNT(codigo_empleado) DESC, ciudad ASC;

SELECT ciudad, COUNT(*) AS cantidad
FROM oficina LEFT JOIN empleado
ON empleado.codigo_oficina = oficina.codigo_oficina
GROUP BY ciudad
ORDER BY cantidad DESC, ciudad ASC;



-- 6. Nombre y apellido de los empleados cuyo código está entre el 10 y el 20 (inclusive), y cuyo puesto además contiene el fragmento "repre" (quizá con mayúsculas distintas).

SELECT nombre, apellido1
FROM empleado
WHERE codigo_empleado BETWEEN 10 AND 20
AND UPPER(puesto) LIKE '%REPRE%';

SELECT nombre, apellido1
FROM empleado
WHERE codigo_empleado >= 10 
AND codigo_empleado <= 20
AND UPPER(puesto) LIKE '%REPRE%';


-- 7. Nombre y apellido de los empleados cuyo apellido coincida con el nombre de una ciudad, usando IN o =.

SELECT nombre, apellido1
FROM empleado
WHERE apellido1 IN
(
    SELECT ciudad FROM oficina
);


-- 8. Nombre y apellido de los empleados cuyo apellido coincida con el nombre de una ciudad, usando ALL o ANY.

SELECT nombre, apellido1
FROM empleado
WHERE apellido1 = ANY
(
    SELECT ciudad FROM oficina
);


-- 9. Nombre y apellido de los empleados cuyo apellido coincida con el nombre de una ciudad, usando EXISTS o NOT EXISTS.

SELECT nombre, apellido1
FROM empleado
WHERE EXISTS
(
    SELECT ciudad FROM oficina
    WHERE ciudad = empleado.apellido1
);


-- 10. Nombre y apellido de los empleados cuyo apellido coincida con el nombre de una ciudad, usando INNER JOIN.

SELECT nombre, apellido1
FROM empleado INNER JOIN oficina
ON apellido1 = ciudad;


-- 11, 12, 13. Nombre de las ciudades en las que aún no nos aparezcan ningún empleado, de 3 formas distintas.

-- NOT IN

SELECT DISTINCT ciudad FROM oficina
WHERE codigo_oficina NOT IN
(
    SELECT codigo_oficina FROM empleado
);

-- NOT EXISTS

SELECT DISTINCT ciudad FROM oficina
WHERE NOT EXISTS
(
    SELECT codigo_oficina FROM empleado
    WHERE empleado.codigo_oficina = oficina.codigo_oficina
);


-- LEFT JOIN y COUNT

SELECT ciudad
FROM oficina LEFT JOIN empleado
ON empleado.codigo_oficina = oficina.codigo_oficina
GROUP BY ciudad
HAVING COUNT(codigo_empleado) = 0;


-- LEFT JOIN y NULL

SELECT ciudad
FROM oficina LEFT JOIN empleado
ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE codigo_oficina IS NULL;


-- ALL

SELECT ciudad
FROM oficina
WHERE codigo_oficina <> ALL
(
    SELECT codigo_oficina FROM empleado
);


-- 14. Nombre y apellido de cada empleado, junto con el nombre de la ciudad, usando NATURAL JOIN.

SELECT nombre, apellido1, ciudad
FROM empleado NATURAL JOIN oficina;


-- 15. Nombre (y apellido) de cada empleado junto con el nombre (y apellido) de su jefe, si existe.

SELECT 
    subordinado.nombre AS nomSub, subordinado.apellido1 AS apellSub, 
    jefe.nombre AS nomJef, jefe.apellido1 AS apellJef
FROM empleado subordinado LEFT JOIN empleado jefe
ON subordinado.codigo_jefe = jefe.codigo_empleado;


-- 16. Nombre (y apellido) de cada empleado junto con el nombre (y apellido) de su jefe, si existe, y el nombre (y apellido) del jefe de su jefe, si existe.

SELECT 
    subordinado.nombre AS nomSub, subordinado.apellido1 AS apellSub, 
    jefe.nombre AS nomJef, jefe.apellido1 AS apellJef,
    director.nombre AS nomDir, director.apellido1 AS apellDir
FROM empleado subordinado 
    LEFT JOIN empleado jefe
    ON subordinado.codigo_jefe = jefe.codigo_empleado
        LEFT JOIN empleado director
        ON jefe.codigo_jefe = director.codigo_empleado;


-- 17, 18, 19. Nombre de las ciudades que coincidan con el nombre o apellido de algún empleado, de 3 formas distintas.

-- IN + UNION

SELECT ciudad FROM oficina
WHERE ciudad IN
(
    SELECT nombre FROM empleado
    UNION
    SELECT apellido1 FROM empleado
);

-- IN + OR

SELECT ciudad FROM oficina
WHERE ciudad IN
(
    SELECT nombre FROM empleado
)
OR ciudad IN
(
    SELECT apellido1 FROM empleado
);

-- EXISTS

SELECT ciudad FROM oficina
WHERE EXISTS
(
    SELECT nombre FROM empleado
    WHERE nombre = ciudad OR apellido1 = ciudad
);

-- INNER JOIN

SELECT ciudad
FROM oficina INNER JOIN empleado
ON ciudad = nombre OR ciudad = apellido1;

-- ANY

SELECT ciudad FROM oficina
WHERE ciudad = ANY
(
    SELECT nombre FROM empleado
    UNION
    SELECT apellido1 FROM empleado
);

-- Union "largo"

SELECT ciudad FROM oficina
WHERE ciudad IN
(
    SELECT nombre FROM empleado
)
UNION 
SELECT ciudad FROM oficina
WHERE ciudad IN
(
    SELECT apellido1 FROM empleado
);


-- 20. Nombre de los países en los que trabajen al menos 5 personas.

SELECT pais
FROM oficina LEFT JOIN empleado
ON empleado.codigo_oficina = oficina.codigo_oficina
GROUP BY pais
HAVING COUNT(codigo_empleado) >= 5;


-- 21. Ciudad de cada oficina y cantidad de empleados que trabajan en ella.

SELECT ciudad, COUNT(codigo_empleado)
FROM oficina LEFT JOIN empleado
ON empleado.codigo_oficina = oficina.codigo_oficina
GROUP BY ciudad;


-- 22. Cantidad media de empleados que trabajan en cada ciudad.

SELECT COUNT(*) / COUNT(DISTINCT codigo_oficina) 
FROM empleado;

-- Si aparece sin decimales:

SELECT 1.0 * COUNT(*) / COUNT(DISTINCT codigo_oficina) 
FROM empleado;

-- Alternativa: con nombre de ciudad

SELECT o.ciudad, AVG(e.codigo_empleado)
FROM oficina o, LEFT JOIN empleado e
ON o.codigo_oficina = e.codigo_oficina
GROUP BY o.ciudad;


-- 23. Ciudades que no se llamen como el apellido de ningún empleado, usando operaciones de conjuntos.

SELECT ciudad FROM oficina
MINUS
SELECT apellido1 FROM empleado;

SELECT ciudad FROM oficina
EXCEPT
SELECT apellido1 FROM empleado;


-- 24. Ciudad y país de las dos oficinas con más empleados.

-- Basado en 21

-- Versión de SQLite

SELECT ciudad, pais, COUNT(codigo_empleado)
FROM oficina LEFT JOIN empleado
ON empleado.codigo_oficina = oficina.codigo_oficina
GROUP BY ciudad, pais
ORDER BY COUNT(codigo_empleado) DESC
LIMIT 2;

-- Versión de Oracle

SELECT ciudad, pais, COUNT(codigo_empleado)
FROM oficina LEFT JOIN empleado
ON empleado.codigo_oficina = oficina.codigo_oficina
GROUP BY ciudad, pais
ORDER BY COUNT(codigo_empleado) DESC
FETCH FIRST 2 ROWS ONLY;


-- 25, 26, 27, 28. Nombre de la ciudad en la que está la oficina que tiene la valoración más alta, de 4 formas distintas

-- Previo: valoración más alta

SELECT MAX(valoracion) FROM oficina;

-- 25. Subconsulta con =

SELECT ciudad FROM oficina
WHERE valoracion = (
    SELECT MAX(valoracion) FROM oficina
);

-- 26. ALL

SELECT ciudad FROM oficina
WHERE valoracion >= ALL (
    SELECT valoracion FROM oficina
);


-- 27. NOT EXISTS

SELECT ciudad FROM oficina o1
WHERE NOT EXISTS (
    SELECT ciudad FROM oficina o2
    WHERE o2.valoracion > o1.valoracion
);


-- 28a. Order by, sintaxis de SQLite

SELECT ciudad FROM oficina 
ORDER BY valoracion DESC
LIMIT 1;

-- 28b. Order by, sintaxis de Oracle

SELECT ciudad FROM oficina 
ORDER BY valoracion DESC
FETCH FIRST 1 ROWS ONLY;


-- 29. Código y ciudad de las oficinas que están en el mismo país que la oficina que tiene la valoración más alta.

-- A partir de cualquiera de 25-28

SELECT codigo_oficina, ciudad FROM oficina
WHERE pais = 
(
    SELECT pais FROM oficina
    WHERE valoracion = (
        SELECT MAX(valoracion) FROM oficina
    )
);


-- 30. Código y ciudad de las oficinas que tengan la misma valoración que alguna otra.

SELECT o1.codigo_oficina, o1.ciudad 
FROM oficina o1, oficina o2
WHERE o1.valoracion = o2.valoracion
AND o1.codigo_oficina <> o2.codigo_oficina;


-- 31. Código y ciudad de las oficinas cuya valoración esté por encima de la media de su país.

-- Previo: Valoración media de cada país

SELECT pais, AVG(valoracion) FROM oficina
GROUP BY pais;

-- Consulta completa (Oracle, no en SQLite)

SELECT codigo_oficina, ciudad FROM oficina o1
WHERE valoracion > 
(
    SELECT AVG(valoracion) FROM oficina o2
    WHERE o1.pais = o2.pais
);


-- 32. Nombre y apellidos de los empleados que tienen jefe, pero cuyo jefe no tiene otro jefe por encima.

-- Tomando como base la 16 (exhaustiva)

SELECT 
    subordinado.nombre AS nomSub, subordinado.apellido1 AS apellSub
FROM empleado subordinado 
    LEFT JOIN empleado jefe
    ON subordinado.codigo_jefe = jefe.codigo_empleado
        LEFT JOIN empleado director
        ON jefe.codigo_jefe = director.codigo_empleado
WHERE jefe.codigo_empleado IS NOT NULL
AND director.codigo_empleado IS NULL;

-- Tomando como base la 15 (cuidado con el JOIN: no debe ser LEFT)

SELECT 
    subordinado.nombre AS nomSub, subordinado.apellido1 AS apellSub
FROM empleado subordinado INNER JOIN empleado jefe
ON subordinado.codigo_jefe = jefe.codigo_empleado
WHERE jefe.codigo_jefe IS NULL;


-- 33. Crea una tabla de "productos". Para cada producto querremos un código (5 letras), una descripción (hasta 50 letras), un importe (5 cifras a la izquierda de la coma decimal y 2 a su derecha) y una fecha de alta. El código actuará como clave primaria. Usa sintaxis de Oracle.

CREATE TABLE productos (
  codigo CHAR(5),
  descripcion VARCHAR2(50),
  importe NUMBER(7,2),
  fechaAlta DATE,
  CONSTRAINT pk_productos PRIMARY KEY (codigo)
);

-- 34. Añade a la tabla de productos la restricción de que la descripción debe ser única.

-- No en SQLite

ALTER TABLE productos
ADD CONSTRAINT uk_productos_descripcion UNIQUE(descripcion);


-- 35. Añade 3 datos de ejemplo en la tabla de productos. Para uno indicarás todos los campos, para otro no indicarás la fecha ayudándote de NULL y para el tercero no indicarás la fecha porque no detallarás todos los nombres de los campos.

-- Sintaxis de SQLite / MySQL

INSERT INTO productos VALUES('1', 'Ejemplo1', 5.25, '2023-03-02');

-- Sintaxis de Oracle

INSERT INTO productos VALUES('1', 'Ejemplo1', 5.25, TO_DATE('2023-03-02', 'YYYY-MM-DD');

-- Resto, sin fecha

INSERT INTO productos VALUES('2', 'Ejemplo2', 6.75, NULL);

INSERT INTO productos (codigo, descripcion, importe)
VALUES('3', "Ejemplo3", 9);


-- 36. Borra el tercer dato de ejemplo que has añadido en la tabla de productos, a partir de su código.

DELETE FROM productos WHERE codigo = '3';


-- 37. Modifica el segundo dato de ejemplo que has añadido en la tabla de productos, a partir de su código, para que su fecha de alta sea la de hoy (que puedes prefijar en vez de usar funciones de fecha del sistema).

-- Sintaxis de SQLite / MySQL

UPDATE productos 
SET fechaAlta = '2024-02-28'
WHERE codigo = 2;

-- Sintaxis de Oracle

UPDATE productos 
SET fechaAlta = TO_DATE('2024-02-28', 'YYYY-MM-DD')
WHERE codigo = 2;


-- 38. Crea una tabla "backup_productos", volcando en ella el código la descripción y el importe de los datos que hay en la tabla de productos.

CREATE TABLE backup_productos AS
SELECT codigo, descripcion, importe FROM productos;


-- 39. Vacía la tabla de productos, conservando su estructura.

-- No en SQLite

TRUNCATE TABLE productos;

-- Alternativa para SQLite

DELETE FROM productos;


-- 40. Elimina la tabla de productos.

DROP TABLE productos;


-- 41. Crea una vista que muestre el nombre de cada empleado, su apellido y, en caso de existir, la ciudad en la que está la oficina en que trabaja, ordenado por apellido y nombre.

CREATE VIEW v_empleado_ciudad AS
    SELECT nombre, apellido1, ciudad 
    FROM empleado LEFT JOIN oficina
    ON empleado.codigo_oficina = oficina.codigo_oficina;


-- 42. Usa la vista anterior para mostrar los empleados sin oficina (en caso de que existan).

SELECT * FROM v_empleado_ciudad
WHERE ciudad IS NULL;


-- 43. Crea un índice que permita acelerar las búsquedas por "ciudad", dentro de la tabla "oficina".

CREATE INDEX idx_oficina_ciudad ON oficina(ciudad);


-- 44, 45, 46. Nombres de las ciudades que comiencen por S, de 3 formas distintas.

-- 44. LIKE

SELECT ciudad FROM oficina
WHERE ciudad LIKE 'S%';

-- 45. SUBSTR

SELECT ciudad FROM oficina
WHERE SUBSTR(ciudad,1,1) = 'S';

-- 46. INSTR

SELECT ciudad FROM oficina
WHERE INSTR(ciudad, 'S') = 1;


-- 47. Nombres de las ciudades cuyo nombre tenga 5 letras.

SELECT ciudad FROM oficina
WHERE LENGTH(ciudad) = 5;

-- Alternativa menos deseable, más rebuscada

SELECT ciudad FROM oficina
WHERE ciudad LIKE '_____';

-- La siguiente es peligrosa: sólo funcionará si no hay ninguna
-- ciudad de menos de 5 letras

SELECT ciudad FROM oficina
WHERE ciudad = SUBSTR(ciudad,1,5);


-- 48. Nombre y país para las ciudades en las que estén oficinas cuya valoración, redondeada a una cifra decimal, sea 8.5 o superior.

SELECT ciudad, pais
FROM oficina 
WHERE ROUND(valoracion,1) >= 8.5;


-- 49. Inicial y nombre de las ciudades que están en países en los que tenemos más de una oficina.

SELECT SUBSTR(ciudad,1,1) AS inicial, ciudad
FROM oficina 
GROUP BY ciudad
HAVING COUNT(codigo_oficina) > 1;


-- 50. Nombre y apellidos de empleados cuyo nombre coincida con el de otro empleado que trabaje en la misma oficina.

SELECT e1.nombre, e1.apellido1 
FROM empleado e1 JOIN empleado e2
ON e1.codigo_oficina = e2.codigo_oficina
WHERE e1.nombre = e2.nombre AND e1.codigo_empleado <> e2.codigo_empleado;



-- Adicionales:

-- 51. Añade una clave primaria a la tabla "backup_productos" (debe ser el código)

-- 52. En la tabla "backup_productos", queremos que el "importe" pase a llamarse "precio".

-- 53. Renombra la tabla "backup_productos", para que pase a llamarse "productos".

-- 54, 55, 56. En la tabla "productos", muestra aquellos que se llamen igual, de al menos 3 formas distintas.

-- 57, 58. Empleados cuyo código no sea el 10 y que estén en la oficina de código "MAD-ES" o en "TOK-JP", de dos formas distintas.


