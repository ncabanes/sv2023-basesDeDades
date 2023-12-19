.open cafes

CREATE TABLE cafes (
  codi VARCHAR(4) PRIMARY KEY,
  nom VARCHAR(20),
  valoracio NUMERIC(2)
);

INSERT INTO cafes VALUES ('j1', 'Café Jurado nº1', 5);

SELECT * FROM cafes;

-- j1|Café Jurado nº1|5

SELECT nom FROM cafes;

-- Café Jurado nº1

SELECT nom FROM cafes WHERE valoracio = 5;

-- Café Jurado nº1
