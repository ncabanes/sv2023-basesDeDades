CREATE OR REPLACE PROCEDURE EscriureGuions(
    quantitat IN NUMBER) 
IS
   guions  VARCHAR2(200);
BEGIN
   FOR i IN 1 .. quantitat LOOP
       guions := guions || '-';
   END LOOP;

   DBMS_OUTPUT.PUT_LINE(guions);
END EscriureGuions;

-- Ús 1

BEGIN
   EscriureGuions(5);
END;

-- Ús 2

EXECUTE EscriureGuions(5);
