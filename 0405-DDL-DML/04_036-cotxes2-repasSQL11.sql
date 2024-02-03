-- Cotxes

CREATE TABLE cotxes (
  codi NUMERIC (5) PRIMARY KEY, 
  marca VARCHAR (20), 
  model VARCHAR (20), 
  variant VARCHAR (20),
  potencia NUMERIC (4),
  anyLlancament NUMERIC (4)
);

INSERT INTO cotxes VALUES (1, 'Ford', 'Fiesta', '1.0 Ecoboost 140', 140, 2010);
INSERT INTO cotxes VALUES (2, 'Mercedes', 'A', '200', 163, 2019);
INSERT INTO cotxes VALUES (3, 'Toyota', 'Yaris', '120H e-CVT', 120, 2019);
INSERT INTO cotxes VALUES (4, 'Hyundai', 'Kona', '1.0 T-GDI', 120, 2019);
INSERT INTO cotxes VALUES (5, 'Mini', 'Countryman', 'Cooper', 136, 2018);
INSERT INTO cotxes VALUES (6, 'Honda', 'Civic', '1.5 VTEC TURBO CVT', 182, 2020);
INSERT INTO cotxes VALUES (7, 'Honda', 'Civic', '2.0 i-MMD Hybrid', 184, 2023);
INSERT INTO cotxes VALUES (8, 'Honda', 'HR-V', '1.5 i-MMD', 131, 2023);
INSERT INTO cotxes VALUES (9, 'Ford', 'Mustang', 'GT', 450, 2023);
INSERT INTO cotxes VALUES (10, 'Ford', 'Mustang', 'Mach-E', NULL, 2023);

-------------

-- 1. Marca, model i variant dels cotxes de 2023.

SELECT marca, model, variant
FROM cotxes
WHERE anyLlancament = 2023;

-- 2. Marca i model dels cotxes que no siguen Honda ni Ford.

SELECT marca, model
FROM cotxes
WHERE marca <> 'Honda' AND marca <> 'Ford';

SELECT marca, model
FROM cotxes
WHERE marca NOT IN ( 'Honda', 'Ford');

SELECT marca, model
FROM cotxes
WHERE NOT (marca = 'Honda' OR marca = 'Ford');

-- 3. Marques, sense repeticions, ordenades alfabèticament.

SELECT DISTINCT marca
FROM cotxes
ORDER BY marca;

-- 4. Models el nom dels quals comença per "C".

SELECT DISTINCT model
FROM cotxes
WHERE model LIKE 'C%';

SELECT DISTINCT model
FROM cotxes
WHERE SUBSTRING(model, 1, 1) ='C';

SELECT DISTINCT model
FROM cotxes
WHERE INSTR(model, 'C') =1;

-- 5 i 6. Model i variant, per als cotxes posteriors a 2005 i la variant dels quals conté una C (potser en minúscules), de 2 formes diferents.

SELECT model, variant
FROM cotxes
WHERE anyLlancament > 2005
AND (variant LIKE '%c%' OR variant LIKE '%C%');

SELECT model, variant
FROM cotxes
WHERE anyLlancament > 2005
AND UPPER(variant) LIKE '%C%';


-- 7 i 8. Marca i model per als cotxes entre 2020 i 2022, de 2 formes diferents.

SELECT marca, model
FROM cotxes
WHERE anyLlancament >= 2020 AND anyLlancament <= 2023;

SELECT marca, model
FROM cotxes
WHERE anyLlancament BETWEEN 2020 AND 2023;


-- 9. Quantitat de marques diferents que tenim anotades.

SELECT COUNT(DISTINCT marca)
FROM cotxes;


-- 10. Quantitat de cotxes que tenim de cada marca.

SELECT marca, COUNT(*)
FROM cotxes
GROUP BY marca;


-- 11. Marques i quantitat de cotxes d'eixa marca, per a les marques de les quals tenim més de 2 cotxes.

SELECT marca, COUNT(*)
FROM cotxes
GROUP BY marca
HAVING COUNT(*) > 2;


-- 12. Modifica la potència del cotxe amb variant "Mach-E": ha de ser 269.

UPDATE cotxes
SET potencia = 269
WHERE variant = 'Mach-E';


-- 13. Mostra la potència mitjana, arredonida a una xifra decimal.

SELECT ROUND(AVG(potencia), 1)
FROM cotxes;


-- 14. Marca, model i variant dels cotxes que estan per damunt de la potència mitjana.

SELECT marca, model, variant
FROM cotxes
WHERE potencia > 
(
	SELECT AVG(potencia)
	FROM cotxes
);

-- 15. Marca del cotxe amb menys potència (usant MIN i un operador de comparació).

SELECT marca
FROM cotxes
WHERE potencia =
(
	SELECT MIN(potencia)
	FROM cotxes
);


-- 16. Marca del cotxe amb menys potència (usant ALL o ANY).

SELECT marca
FROM cotxes
WHERE potencia <= ALL
(
	SELECT potencia
	FROM cotxes
);

-- 17. Marca del cotxe amb menys potència (usant EXISTS o NOT EXISTS).

SELECT marca
FROM cotxes c1
WHERE NOT EXISTS
(
	SELECT marca
	FROM cotxes c2
	WHERE c2.potencia < c1.potencia
);


-- 18. Afig, amb el codi 15, un cotxe de marca Lexus, model UX, variant 250h, del qual no coneixem potència ni any de llançament, usant el format detallat de INSERT.

INSERT INTO cotxes (codi, marca, model, variant)
VALUES(15, 'Lexus', 'UX', '250h');


-- 19. Modifica el vehicle de codi 15, per a indicar que la seua potència és 184.

UPDATE cotxes SET potencia = 184 WHERE codi = 15;


-- 20. Esborra el vehicle de codi 5.

DELETE FROM cotxes WHERE codi = 5;


-------------

-- (Enunciado en castellano)

-- 1. Marca, modelo y variante de los coches de 2023.
-- 2. Marca y modelo de los coches que no sean Honda ni Ford.
-- 3. Marcas, sin repeticiones, ordenadas alfabéticamente.
-- 4. Modelos cuyo nombre empieza por "C".
-- 5 y 6. Modelo y variante, para los coches posteriores a 2005 y cuya variante contiene una C (quizá en minúsculas), de 2 formas distintas.
-- 7 y 8. Marca y modelo para los coches entre 2020 y 2022, de 2 formas distintas.
-- 9. Cantidad de marcas distintas que tenemos anotadas.
-- 10. Cantidad de coches que tenemos de cada marca.
-- 11. Marcas y cantidad de coches de esa marca, para las marcas de las que tenemos más de 2 coches.
-- 12. Modifica la potencia del coche con variante "Mach-E": debe ser 269.
-- 13. Muestra la potencia media, redondeada a una cifra decimal.
-- 14. Marca, modelo y variante de los coches que están por encima de la potencia media.
-- 15. Marca del coche con menos potencia (usando MIN y un operador de comparación).
-- 16. Marca del coche con menos potencia (usando ALL o ANY).
-- 17. Marca del coche con menos potencia (usando EXISTS o NOT EXISTS).
-- 18. Añade, con el código 15, un coche de marca Lexus, modelo UX, variante 250h, del que no conocemos potencia ni año de lanzamiento, usando el formato detallado de INSERT.
-- 19. Modifica el vehículo de código 15, para indicar que su potencia es 184.
-- 20. Borra el vehículo de código 5.
