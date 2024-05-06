-- Crea una taula "anotacions", amb un número de registre 
-- autoincremental i un text de no més de 50 lletres. 
-- Afig almenys 3 dades d'exemple.
 
CREATE TABLE anotacions
( 
    num SERIAL,
    texto VARCHAR(50),
    CONSTRAINT pk_partides PRIMARY KEY (num)
);

INSERT INTO anotacions (texto) VALUES ( 'Hola' );
INSERT INTO anotacions (texto) VALUES ( 'Que tal' );
INSERT INTO anotacions (texto) VALUES ( 'Adios' );
INSERT INTO anotacions (num, texto) VALUES ( DEFAULT, 'Hasta otra' );

--

SELECT * FROM anotacions;
