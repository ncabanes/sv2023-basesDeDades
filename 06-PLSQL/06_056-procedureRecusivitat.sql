-- Crea un procediment que mostre els codis de les 
-- categories descendents d'una donada.

CREATE OR REPLACE PROCEDURE MostrarCategoriesFilles (codiCat IN varchar) AS

 CURSOR cFilles IS
    SELECT categoria.codi
    FROM categoria
    WHERE categoria.codCategPare = codiCat;

BEGIN
    dbms_output.put_line(codiCat);
    FOR i IN cFilles LOOP
        MostrarCategoriesFilles(i.codi);
    END LOOP;

END MostrarCategoriesFilles;

EXECUTE MostrarCategoriesFilles('so');
