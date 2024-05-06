CREATE OR REPLACE FUNCTION NumFactorial (
    N IN NUMERIC) 
RETURNS NUMERIC 
LANGUAGE plpgsql
AS
$$
BEGIN
    IF N<0 THEN
        RETURN -1;
    ELSIF N=0 THEN
        RETURN 1;
    ELSE
        RETURN N*NumFactorial(N-1);
    END IF;
END;
$$

-- Ús en PostgreSQL

SELECT NumFactorial(5);

