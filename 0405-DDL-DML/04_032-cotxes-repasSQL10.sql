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

-- 1. Mostra marca, model i variant dels cotxes que tenim registrats amb més de 5 anys d'antiguitat, ordenats per marca, model i variant.

-- 2. Potència mitjana dels cotxes que tenim emmagatzemats.

-- 3. Potència mitjana dels cotxes que tenim registrats de cada marca.

-- 4. Marca i model (sense duplicats) dels cotxes la marca dels quals comença per H o el model dels quals comença per H, ordenats de major a menor potència.

-- 5. Marca i model dels cotxes l'any dels quals està entre 2005 i 2023 (inclusivament) i la marca dels quals és Mini o Ford.

-- 6. Quantitat de cotxes que tenim registrats de cada marca, només per a les marques de les quals tinguem més de 2 registres.

-- 7. Cotxes per als quals no coneixem la potència.

-- 8. Cotxes la potència dels quals siga superior a 200 i la marca dels quals acabe amb la lletra "D", potser amb majúscules diferents.

-- 9. Marca del cotxe amb més potència (usant MAX i un operador de comparació).

-- 10. Marca del cotxe amb més potència (usant ALL o ANY).

-- 11. Marca del cotxe amb més potència (usant EXISTS o NOT EXISTS).

-- 12. Cotxes (marca, model i variant) que pertanyen a la marca del cotxe amb més potència.

-- 13. Afig un nou cotxe, triat per tu (pot ser inventat), amb el codi 11, sense indicar el seu any de llançament (has d'usar NULL).

-- 14. Afig un nou cotxe, triat per tu (pot ser inventat), amb el codi 12, sense indicar el seu any de llançament (has d'indicar només els camps pertinents).

-- 15. Modifica la potència del cotxe amb codi 10: ha de ser 269.

-- 16. Esborra el cotxe de codi 12.

-- 17. Mostra tots els noms, tant de marques i com de models, en una única columna, ordenats alfabèticament.

-- 18. Mostra les marques que no tinguen cap cotxe de més de 150 CV.

-------------

-- (Enunciado en castellano)

-- 1. Muestra marca, modelo y variante de los coches que tenemos registrados con más de 5 años de antigüedad, ordenados por marca, modelo y variante.
-- 2. Potencia media de los coches que tenemos almacenados.
-- 3. Potencia media de los coches que tenemos registrados de cada marca.
-- 4. Marca y modelo (sin duplicados) de los coches cuya marca empieza por H o cuyo modelo empieza por H, ordenados de mayor a menor potencia.
-- 5. Marca y modelo de los coches cuyo año entre 2005 y 2023 (incluidos) y cuya marca es Mini o Ford.
-- 6. Cantidad de coches que tenemos registrados de cada marca, solo para las marcas de las cuales tengamos más de 2 registros.
-- 7. Coches para los cuales no conocemos la potencia.
-- 8. Coches cuya potencia sea superior a 200 y cuya marca acabe con la letra "D", quizá con mayúsculas diferentes.
-- 9. Marca del coche con más potencia (usando MAX y un operador de comparación).
-- 10. Marca del coche con más potencia (usando ALL o ANY).
-- 11. Marca del coche con más potencia (usando EXISTS o NOT EXISTS).
-- 12. Coches (marca, modelo y variante) que pertenecen a la marca del coche con más potencia.
-- 13. Añade un nuevo coche, elegido por ti (puede ser inventado), con el código 11, sin indicar su año de lanzamiento (debes usar NULL).
-- 14. Añade un nuevo coche, elegido por ti (puede ser inventado), con el código 12, sin indicar su año de lanzamiento (debes indicar sólo los campos pertinentes).
-- 15. Modifica la potencia del coche con código 10: debe ser 269.
-- 16. Borra el coche de código 12.
-- 17. Muestra todos los nombres, tanto de marcas y como de modelos, en una única columna, ordenados alfabéticamente.
-- 18. Muestra las marcas que no tengan ningún coche de más de 150 CV.

