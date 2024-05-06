-- Modifica el joc de codi "batao" perquè el seu nom passe a ser 
-- "Batman: Arkham Origins". Mostra l'any de llançament del 
-- registre que haja sigut afectat.
DO
$$
DECLARE
  anyLlancament1 jocs.anyLlancament%TYPE;
BEGIN
  UPDATE jocs
  SET nom = 'Batman: Arkham Origins'
  WHERE codi = 'batao'
  RETURNING anyLlancament INTO anyLlancament1;

  RAISE NOTICE '%', 'Any de llançament del joc modificat: ' 
    || anyLlancament1;
END;
$$
