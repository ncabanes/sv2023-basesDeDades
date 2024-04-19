-- Crea una taula "anotacions", amb un número de registre 
-- autoincremental i un text de no més de 50 lletres. 
-- Afig almenys 3 dades d'exemple.
 
CREATE TABLE anotacions
( 
    num NUMBER(5),
    texto VARCHAR2(50),
    CONSTRAINT pk_partides PRIMARY KEY (num)
);

CREATE SEQUENCE numeroRegistre;

INSERT INTO anotacions
VALUES ( numeroRegistre.NEXTVAL, 'Hola' );

INSERT INTO anotacions
VALUES ( numeroRegistre.NEXTVAL, 'Que tal' );

INSERT INTO anotacions
VALUES ( numeroRegistre.NEXTVAL,  'Adios' );
