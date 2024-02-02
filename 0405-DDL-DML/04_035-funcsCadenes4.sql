-- A partir de les dades de cotxes, has de mostrar:

-- Posició de la primera A dins de la marca

SELECT marca, INSTR(UPPER(marca), 'A') FROM cotxes;


-- Marca, model i longitud (quantitat de lletres) del model

SELECT marca, model, LENGTH(model) AS longitud FROM cotxes;


-- Marca i primera paraula del model, suposant que tots els 
-- models tingueren 2 o més paraules

INSERT INTO cotxes VALUES (20, 'Tesla', 'Model X', NULL, NULL, NULL);

-- Previ: longitud de la primera paraula

SELECT marca, model, INSTR(model, ' ')-1
FROM cotxes
WHERE codi=20;

-- Consulta completa

SELECT marca, model, SUBSTR(model, 1, INSTR(model, ' ')-1)
FROM cotxes
WHERE codi=20;

