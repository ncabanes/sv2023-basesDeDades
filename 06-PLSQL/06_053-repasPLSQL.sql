-- A partir d'estes taules i d'estes dades d'exemple:

CREATE TABLE productes (
  codi VARCHAR(6) PRIMARY KEY,
  nom VARCHAR(30),
  preuCost NUMBER(7,2)
);

CREATE TABLE categoriesProd (
  codi VARCHAR(4) PRIMARY KEY,
  nom VARCHAR(30)
);

CREATE TABLE pertanyA (
  codiProd VARCHAR(6),
  codiCateg VARCHAR(4),
  PRIMARY KEY (codiProd, codiCateg)
);

INSERT INTO productes VALUES ('p1','Producte 1', 23);
INSERT INTO productes VALUES ('p2','Producte 2', 32.5);
INSERT INTO productes VALUES ('p3','Producte 3', NULL);

INSERT INTO categoriesProd VALUES ('c1','Categoria 1');
INSERT INTO categoriesProd VALUES ('c2','Categoria 2');
INSERT INTO categoriesProd VALUES ('c3','Categoria 3');

INSERT INTO pertanyA VALUES ('p1','c1');
INSERT INTO pertanyA VALUES ('p1','c2');
INSERT INTO pertanyA VALUES ('p2','c2');

-- 1.- Crea una vista "prodCateg" que mostre codi i nom de tots els 
-- productes, així com codi i nom de les categories a què pertanyen, 
-- en cas que pertanguen a algun.

CREATE OR REPLACE VIEW prodCateg AS 
    SELECT productes.codi as codiproducte, 
        productes.nom as nomProducte, 
        categoriesProd.codi as codiCategoria, 
        categoriesProd.nom as nomCategoria 
    FROM productes 
        LEFT JOIN pertanyA ON pertanyA.codiProd = productes.codi 
        LEFT JOIN categoriesProd on pertanyA.codiCateg = categoriesProd.codi;

SELECT * FROM prodCateg;

-- 2.- Crea una funció "QuantitatProdCategoria", que reba com a paràmetre 
-- el nom d'un categoria i retorne la quantitat de productes que hi ha 
-- en eixa categoria, o -1 en cas que la categoria no existisca.

-- Versió inicial

CREATE OR REPLACE FUNCTION QuantitatProdCategoria (v_nomCateg IN VARCHAR2)
RETURN NUMBER 
AS
    v_quantitat NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO v_quantitat
    FROM prodCateg
    WHERE nomCategoria = v_nomCateg;
    
    IF v_quantitat = 0 THEN
        v_quantitat := -1;
    END IF;
    
    RETURN v_quantitat;
END;

BEGIN
    dbms_output.put_line(QuantitatProdCategoria('Categoria 2'));
END;

-- Versió completa

CREATE OR REPLACE FUNCTION QuantitatProdCategoria (v_nomCateg IN VARCHAR2)
RETURN NUMBER 
AS
    v_quantitat NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO v_quantitat
    FROM categoriesProd
    WHERE nom = v_nomCateg;
    
    IF v_quantitat = 0 THEN
        RETURN -1;
    END IF;
    
    SELECT COUNT(*) 
    INTO v_quantitat
    FROM prodCateg
    WHERE nomCategoria = v_nomCateg;
    
    RETURN v_quantitat;
END;

EXECUTE dbms_output.put_line(QuantitatProdCategoria('Categoria 3'));


-- 3.- Crea un procediment "MostrarProdCategoria", que, a partir del nom 
-- d'una categoria que rebrà com a paràmetres, mostre tots els 
-- codis i noms dels productes que pertanyen a eixa categoria, o el 
-- missatge "Categoria inexistent", segons corresponga. Usa un bucle FOR.


CREATE OR REPLACE PROCEDURE MostrarProdCategoria (v_nomCateg IN VARCHAR2)
AS
    v_quantitat NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO v_quantitat
    FROM categoriesProd
    WHERE nom = v_nomCateg;
    
    IF v_quantitat = 0 THEN
        dbms_output.put_line('Categoria inexistent');
    END IF;
    
    FOR prod IN (SELECT * FROM prodCateg
        WHERE nomCategoria = v_nomCateg) LOOP
        
        dbms_output.put_line(prod.codiproducte 
            || ' ' || prod.nomProducte);
        
    END LOOP;
END;

EXECUTE MostrarProdCategoria('Categoria 2');


-- 4.- Crea un procediment "MostrarProdsRapid", que use "CASE" per a 
-- mostrar cada producte al costat del nom de la categoria a la qual 
-- pertany, sense consultar la taula "categories", mirant només 
-- "productes" i "pertanyA". Si un producte està en diverses categories, 
-- apareixeran diverses línies que comencen pel seu nom.

-- Previ: consulta

SELECT 
    productes.nom as nomProducte, 
    pertanyA.codiCateg as codiCategoria
FROM productes 
    LEFT JOIN pertanyA ON pertanyA.codiProd = productes.codi
ORDER BY nomProducte;


-- Procediment

CREATE OR REPLACE PROCEDURE MostrarProdsRapid 
AS
    v_nomCateg categoriesProd.nom % TYPE;
    CURSOR cursorProd IS 
        SELECT 
            productes.nom as nomProducte, 
            pertanyA.codiCateg as codiCategoria
        FROM productes 
            LEFT JOIN pertanyA ON pertanyA.codiProd = productes.codi
        ORDER BY nomProducte;    
BEGIN
    FOR prod IN cursorProd LOOP
        v_nomCateg := CASE prod.codiCategoria
            WHEN 'c1' THEN 'Categoria 1'
            WHEN 'c2' THEN 'Categoria 2'
            WHEN 'c3' THEN 'Categoria 3'
            ELSE '(Sense categoria)'
        END;
        
        dbms_output.put_line(prod.nomProducte 
            || ' - ' || v_nomCateg);
    END LOOP;
END;

BEGIN
    MostrarProdsRapid;
END;


-- 5.- Crea una taula auxiliar "productesEsborrats" (sense clau primària) 
-- i un trigger "EsborrantProducte", que permeta que, cada vegada que 
-- s'esborre un producte, les seues dades es guarden en una taula 
-- auxiliar, juntament amb la data en què s'ha esborrat.

CREATE TABLE productesEsborrats (
  codi VARCHAR(6),
  nom VARCHAR(30),
  preuCost NUMBER(7,2),
  dataEsborrament DATE
);

CREATE OR REPLACE TRIGGER EsborrantProducte
AFTER DELETE ON productes
FOR EACH ROW
BEGIN
    INSERT INTO productesEsborrats 
    VALUES(:OLD.codi, :OLD.nom, :OLD.preuCost, SYSDATE);
END;

INSERT INTO productes VALUES ('p5','Producte 5', 1);

SELECT * FROM productes;

DELETE FROM productes WHERE codi = 'p5';

SELECT * FROM productesEsborrats;


-- 6.- Crea un bloc anònim que mostre el codi de cada producte, el seu 
-- nom i el seu preu en dòlars, suposant un canvi d'1 Euro = 1.08 
-- dòlars. Has d'emprar un bloc WHILE.

DECLARE
    CURSOR c IS
        SELECT * FROM productes;
    v_producte productes%ROWTYPE;
    v_dolars NUMBER(7,2);
BEGIN
    OPEN c;
    FETCH c INTO v_producte;
    WHILE c%FOUND LOOP
        v_dolars := v_producte.preuCost * 1.08;
        dbms_output.put_line(v_producte.codi 
            || ' - ' || v_producte.nom
            || ': ' ||  v_dolars || ' dòlars');
        FETCH c INTO v_producte;
    END LOOP;
    CLOSE c;
END;


-- 7.- Crea una funció "PreuMitja", que reba el codi d'una 
-- categoria i retorne el preu mitjà dels articles que hi ha en eixa 
-- categoria, o -99 en cas que no hi haja cap article en eixa 
-- categoria.

CREATE OR REPLACE FUNCTION PreuMitja (v_codCateg VARCHAR) 
RETURN NUMBER 
IS
    v_quantitat NUMBER(5);
    v_preuMitja NUMBER(7,2);

BEGIN
    SELECT COUNT(*)
    INTO v_quantitat
    FROM categoriesProd c 
    WHERE c.codi = v_codCateg;

    IF v_quantitat = 0 THEN
        RETURN -99;
    END IF;
    
    SELECT AVG(preuCost)
        INTO v_preuMitja
        FROM productes, pertanyA
        WHERE productes.codi = codiProd
        AND codiCateg = v_codCateg;

    RETURN v_preuMitja;

END PreuMitja;

-- Prova, amb categoria que existeix

BEGIN
    dbms_output.put_line(PreuMitja('c2'));
END;

-- Prova, amb categoria que no existeix

SELECT PreuMitja('c7') FROM dual;


-- 8.- Crea un procediment "MostrarCategoriesIProds", que, sense rebre 
-- paràmetres, mostre el nom de cada categoria, i, en la línia 
-- següent, els noms de tots els productes que pertanyen a eixa 
-- categoria, tots ells en la mateixa línia, separats per un espai en 
-- blanc.

CREATE OR REPLACE PROCEDURE MostrarCategoriesIProds 
AS
    v_llistaProd VARCHAR2(5000);
BEGIN
    FOR categ IN (SELECT * FROM categoriesProd ORDER BY nom) LOOP
        v_llistaProd := '';
        FOR prod IN (SELECT * FROM prodCateg
            WHERE codiCategoria = categ.codi) LOOP
            v_llistaProd := v_llistaProd || ' ' || prod.nomProducte;
        END LOOP;
        
        dbms_output.put_line(categ.nom || ' - ' || v_llistaProd);
    END LOOP;
END;

BEGIN
    MostrarCategoriesIProds;
END;

-- 9.- Crea un trigger anomenat "PreuPerDefecte" que, quan es guarda un 
-- nou producte, si no s'indica el seu preu, li assigne preu 10 si és de 
-- categoria 1 o preu 15 si és de categoria 2. Si és de qualsevol altra 
-- categoria, deixarà el valor NULL.

CREATE OR REPLACE TRIGGER PreuPerDefecte
BEFORE INSERT ON productes
FOR EACH ROW
DECLARE
    v_categ pertanyA.codiCateg % TYPE;
BEGIN
    SELECT codiCateg
        INTO v_categ
        FROM pertanyA
        WHERE codiProd = :NEW.codi;
        
    CASE v_categ
        WHEN 'c1' THEN
            :NEW.preuCost := 10;
        WHEN 'c2' THEN
            :NEW.preuCost := 15;
        ELSE
            :NEW.preuCost := NULL;
    END CASE;
    
END;

-- Prova

INSERT INTO pertanyA VALUES ('p4','c1');
INSERT INTO productes VALUES ('p4','Producte 4', NULL);
SELECT * FROM productes WHERE codi = 'p4';

INSERT INTO pertanyA VALUES ('p5','c2');
INSERT INTO productes VALUES ('p5','Producte 5', NULL);
SELECT * FROM productes WHERE codi = 'p5';

INSERT INTO pertanyA VALUES ('p6','c3');
INSERT INTO productes VALUES ('p6','Producte 6', NULL);
SELECT * FROM productes WHERE codi = 'p6';


-- 10.- Crea un procediment "MostrarPreusMitjans", que utilitze la 
-- funció "PreuMitja" per a mostrar els preus mitjans de totes les 
-- categories que tenim emmagatzemades.

CREATE OR REPLACE PROCEDURE MostrarPreusMitjans IS
    CURSOR c IS
        SELECT codi
        FROM categoriesProd;
    
BEGIN
    FOR registre IN c LOOP
        dbms_output.put_line(registre.codi
            || ': ' || PrecioMedio(registre.codi));
    END LOOP;
END MostrarPreusMitjans;

BEGIN
    MostrarPreusMitjans;
END;



-- ==============================================================

-- 1.- Crea una vista "prodCateg" que muestre código y nombre de todos los 
-- productos, así como código y nombre de las categorías a que pertenecen, 
-- en caso de que pertenezcan a alguno.


-- 2.- Crea una función "CantidadProdCategoria", que reciba como parámetro 
-- el nombre de un categoría y devuelva la cantidad de productos que hay 
-- en esa categoría, o -1 en caso de que la categoría no exista.


-- 3.- Crea un procedimiento "MostrarProdCategoria", que, a partir del 
-- nombre de una categoría que recibirá como parámetros, muestre todos los 
-- códigos y nombres de los productos que pertenecen a esa categoría, o el 
-- mensaje "Categoría inexistente", según corresponda. Usa un bucle FOR.


-- 4.- Crea un procedimiento "MostrarProdsRapido", que use una orden 
-- "case" para mostrar cada producto junto al nombre de la categoría a la 
-- que pertenece, sin consultar la tabla "categorías", mirando sólo 
-- "productos" y "perteneceA". Si un producto está en varias categorías, 
-- aparecerán varias líneas que comiencen por su nombre.


-- 5.- Crea una tabla auxiliar "productosBorrados" (sin clave primaria) y 
-- un trigger "BorrandoProducto", que permitan que, cada vez que se borre 
-- un producto, sus datos se guarden en una tabla auxiliar, junto con la 
-- fecha en que se ha borrado.


-- 6.- Crea un bloque anónimo que muestre el código de cada producto, su 
-- nombre y su precio en dólares, suponiendo un cambio de 1 Euro = 1.08 
-- dólares. Debes emplear un bloque WHILE.


-- 7.- Crea una función "PrecioMedio", que reciba el código de una 
-- categoría y devuelva el precio medio de los artículos que hay en esa 
-- categoría, o -99 en caso de que no haya ningún artículo en esa 
-- categoría.


-- 8.- Crea un procedimiento "MostrarCategoriasYProds", que, sin recibir 
-- parámetros, muestre el nombre de cada categoría, y, en la línea 
-- siguiente, los nombres de todos los productos que pertenecen a esa 
-- categoría, todos ellos en la misma línea, separados por un espacio en 
-- blanco.


-- 9.- Crea un trigger llamado "PrecioPorDefecto" que, cuando se guarda un 
-- nuevo producto, si no se indica su precio, le asigne precio 10 si es de 
-- categoría 1 o precio 15 si es de categoría 2. Si es de cualquier otra 
-- categoría, dejará el valor NULL.


-- 10.- Crea un procedimiento "MostrarPreciosMedios", que se apoye en la 
-- función "PrecioMedio" para mostrar los precios medios de todas las 
-- categorías que tenemos almacenadas.


