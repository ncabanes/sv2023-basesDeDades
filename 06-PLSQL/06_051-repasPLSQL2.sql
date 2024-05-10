-- Suposant la següent estructura bàsica per a emmagatzemar receptes de cuina:
-- - Taula RECEPTES(codi, nom, descripció, tempsMinuts, dificultat)
-- - Taula INGREDIENTS (codi, nom, preuKg)
-- - Relació INGRED_RECEPTA(codiRecepta, codiIngredient, quantitatKg)

CREATE TABLE receptes (
    codi CHAR(4) PRIMARY KEY, 
    nom VARCHAR2(30),
    descripc VARCHAR2(800),
    tempsMinuts NUMBER(3),
    dificultat NUMBER(1)
);

CREATE TABLE ingredients (
    codi CHAR(4) PRIMARY KEY, 
    nom VARCHAR2(30),
    preuKg NUMBER(7,5)
);

CREATE TABLE ingred_recepta (
    codiRecepta CHAR(4), 
    codiIngredient CHAR(4), 
    quantitatKg NUMBER(5,3),
    PRIMARY KEY (codiRecepta, codiIngredient)
);

INSERT INTO receptes VALUES ('r1','Recepta 1',NULL,35,1);
INSERT INTO receptes VALUES ('r2','Recepta 2',NULL,55,2);
INSERT INTO receptes VALUES ('r3','Recepta 3',NULL,105,4);

INSERT INTO ingredients VALUES ('i1','Ingredient 1',20.5);
INSERT INTO ingredients VALUES ('i2','Ingredient 2',18.5);
INSERT INTO ingredients VALUES ('i3','Ingredient 3',4.5);
INSERT INTO ingredients VALUES ('i4','Ingredient 4',4);

INSERT INTO ingred_recepta VALUES ('r1','i1',0.1);
INSERT INTO ingred_recepta VALUES ('r1','i2',0.03);
INSERT INTO ingred_recepta VALUES ('r2','i1',0.4);
INSERT INTO ingred_recepta VALUES ('r2','i3',0.3);

-- 1.- Crea un procediment "MostrarIngredientsOrfes", que mostre els noms 
-- dels ingredients que apareixen en la nostra base de dades però que 
-- realment no s'utilitzen en cap recepta. Al final haurà de mostrar també 
-- el text: "Trobats: XX", on XX serà la quantitat d'ingredients que no 
-- s'utilitzen.



-- 2.- Crea una funció "QuantitatIngredients" que, a partir del codi de 
-- recepta, retorne la quantitat d'ingredients (potser 0) que conté.



-- 3.- Crea un procediment "MostrarRecepta", que, a partir del codi de 
-- recepta, escriga en línies separades el nom, la descripció, el temps en 
-- minuts, la dificultat, els noms i quantitats de cadascun dels 
-- ingredients, i finalment, el preu de cost.



-- 4.- Crea una taula "CopiaSeguretatIngred", amb la mateixa estructura 
-- que "Ingredients" però inicialment buida, i un trigger anomenat 
-- "EsborratIngredient", que bolque a aqueixa taula cada ingredient que 
-- s'esborre.



-- 5.- Crea una taula "CanvisDePreu", formada per codi d'article, data, 
-- preu inicial i preu final, i un trigger "CanviDePreu", que anote la 
-- corresponent informació cada vegada que es modifique el preu d'un 
-- ingredient.



-- -----
/*
Suponiendo la siguiente estructura básica para almacenar recetas de cocina:
- Tabla RECETAS(código, nombre, descripción, tiempoMinutos, dificultad)
- Tabla INGREDIENTES (código, nombre, precioKg)
- Relación INGRED_RECETA(códigoReceta, códigoIngrediente, cantidadKg)

1.- Crea un procedimiento "MostrarIngredientesHuérfanos", que muestre los nombres de los ingredientes que aparecen en nuestra base de datos pero que realmente no se utilizan en ninguna receta. Al final deberá mostrar también el texto: "Encontrados: XX", donde XX será la cantidad de ingredientes que no se utilizan.

2.- Crea una función "CantidadIngredientes" que, a partir del código de receta, devuelva la cantidad  de ingredientes (quizá 0) que contiene.

3.- Crea un procedimiento "MostrarReceta", que, a partir del código de receta, escriba en líneas separadas el nombre, la descripción, el tiempo en minutos, la dificultad, los nombres y cantidades de cada uno de los ingredientes, y finalmente, el precio de coste.

4.- Crea una tabla "BackupIngredientes", con la misma estructura que "Ingredientes" pero inicialmente vacía, y un trigger llamado "BorradoIngrediente", que vuelque a esa tabla cada ingrediente que se borre.

5.- Crea una tabla "CambiosDePrecio", formada por código de artículo, fecha, precio inicial y precio final, y un trigger "CambioDePrecio", que anote la correspondiente información cada vez que se modifique el precio de un ingrediente.
*/
