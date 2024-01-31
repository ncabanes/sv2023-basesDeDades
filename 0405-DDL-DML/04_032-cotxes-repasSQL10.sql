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
