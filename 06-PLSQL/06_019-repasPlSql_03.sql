CREATE TABLE SeguimentPreus (
    codi VARCHAR2(12),
    nom VARCHAR2(50),
    dataComprovacio DATE , 
    preu NUMBER(7,2) NOT NULL,
    CONSTRAINT pk_SeguimentPreus PRIMARY KEY (codi,dataComprovacio) 
);

INSERT INTO SeguimentPreus VALUES ('B08FSNKNSV','Crucial X6 2TB SSD Portàtil',TO_DATE ('2024-04-02','YYYY-MM-DD'),126.54);
INSERT INTO SeguimentPreus VALUES ('QUMOX ','Mando a Distancia Control Remoto',TO_DATE ('2024-02-25','YYYY-MM-DD'),21.19);
INSERT INTO SeguimentPreus VALUES ('ACNHNS','Animal Crossing: New Horizons(Nintendo Switch)',TO_DATE ('2022-03-05','YYYY-MM-DD'),45.99);
INSERT INTO SeguimentPreus VALUES ('B08FSNKNSV','Crucial X6 2TB SSD Portàtil',TO_DATE ('2024-01-06','YYYY-MM-DD'),100.00);

-- Mostra quants preus ens apareixen per a l'article 
-- amb codi "B08FSNKNSV".

DECLARE
    quantitat NUMBER(5);
BEGIN
    SELECT COUNT(*)
    INTO quantitat
    FROM SeguimentPreus
    WHERE codi= 'B08FSNKNSV';
    
    dbms_output.put_line(quantitat);
END;

-- Mostra la diferència entre el preu actual i el menor preu del 
-- qual tenim constància, per a l'article amb codi "B08FSNKNSV", usant 
-- consultes consecutives, en comptes d'una subconsulta.

DECLARE
    preuMenor SeguimentPreus.preu %TYPE;
    preuActual SeguimentPreus.preu %TYPE;
BEGIN
    SELECT MIN(preu)
    INTO preuMenor
    FROM SeguimentPreus
    WHERE codi= 'B08FSNKNSV';
    
    SELECT preu
    INTO preuActual
    FROM SeguimentPreus
    WHERE codi= 'B08FSNKNSV'
    ORDER BY dataComprovacio DESC
    FETCH NEXT 1 ROWS ONLY;
    
    dbms_output.put_line(preuActual - preuMenor);
END;

-- ---------------------------

CREATE TABLE categories (
    codi CHAR(5),
    nom VARCHAR2(30),
    CONSTRAINT pk_categories PRIMARY KEY(codi)
);
CREATE TABLE productes (
    codi NUMBER(5),
    descripcio VARCHAR2(40),
    preu NUMBER(7, 2),
    categoriaProducte CHAR(5),
    CONSTRAINT pk_productes PRIMARY KEY(codi),
    CONSTRAINT fk_productes FOREIGN KEY(categoriaProducte)
        REFERENCES categories(codi)
);


INSERT INTO categories VALUES('cr', 'Càmeres reflex');
INSERT INTO categories VALUES('ce', 'Càmeres Evil');
INSERT INTO categories VALUES('fc', 'Flashes per a càmera');

INSERT INTO productes VALUES('1001', 'Canon EOS 2000D', 529.00, 'cr');
INSERT INTO productes VALUES('2001', 'Canon EOS R100', 499.00, 'ce');
INSERT INTO productes VALUES('2002', 'Sony Alpha ZV-E10', 649.00, 'ce');
INSERT INTO productes VALUES('2003', 'Panasonic Lumix DMC-G7KEC', 599.90, 'ce');
INSERT INTO productes VALUES('3991', 'SanDisk 128GB Extreme PRO', 31.20, NULL);

-- Mostra, des de PL/SQL, la descripció de la categoria a la qual 
-- pertany el producte més car. No has d'usar subconsultes, sinó consultes 
-- consecutives.

DECLARE 
    nomCat categories.nom%TYPE;

BEGIN

    SELECT nom
        INTO nomCat
        FROM categories
        JOIN productes 
            ON categories.codi = productes.categoriaProducte
        ORDER BY preu DESC
        FETCH FIRST 1 ROWS ONLY;

    dbms_output.put_line(nomCat);
END;

-- Mostra, des de PL/SQL, el nom dels productes amb codi 2001 a 
-- 2003, emprant un bucle FOR.

DECLARE
    nomProducte productes.descripcio % TYPE;
BEGIN
    FOR i IN 2001 .. 2003 LOOP
        SELECT descripcio
        INTO nomProducte
        FROM productes
        WHERE codi = i;
        
        dbms_output.put_line(nomProducte);
    END LOOP;
END;

-- Mostra, des de PL/SQL, la descripció del producte i el nom de 
-- la categoria a la qual pertany, per al producte amb codi 3991. Si el 
-- nom és nul, escriu el text "Sense descripció". No has d'usar 
-- NVL, sinó una orde IF.

DECLARE
    nomProducte productes.descripcio%TYPE;
    nomCat categories.nom%TYPE;
BEGIN
    SELECT productes.descripcio, categories.nom
    INTO nomProducte, nomCat
    FROM productes LEFT JOIN categories
    ON productes.categoriaProducte = categories.codi
    WHERE productes.codi = 3991;
    
    IF nomCat IS NOT NULL THEN
        dbms_output.put_line(nomProducte || ' - ' || nomCat);
    ELSE
        dbms_output.put_line(nomProducte || ' - Sense descripcio');
    END IF;
END;

-- Alternativa, con EXCEPT

DECLARE
    nomProducte productes.descripcio%TYPE := 'Producte desconegut';
    codCat categories.codi%TYPE;
    nomCat categories.nom%TYPE;
BEGIN
    SELECT descripcio, categoriaProducte
    INTO nomProducte, codCat
    FROM productes 
    WHERE codi = 3991;
    
    SELECT categories.nom
    INTO nomCat
    FROM categories
    WHERE categories.codi = codCat;
    
    dbms_output.put_line(nomProducte || ' - ' || nomCat);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line(nomProducte || ' - Sense descripcio');
END;

