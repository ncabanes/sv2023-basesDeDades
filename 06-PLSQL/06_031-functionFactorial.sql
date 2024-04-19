CREATE OR REPLACE FUNCTION Factorial (
    N IN NUMBER) 
RETURN NUMBER 
AS
BEGIN
    IF N<0 THEN
        RETURN -1;
    ELSIF N=0 THEN
        RETURN 1;
    ELSE
        RETURN N*Factorial(N-1);
    END IF;
END Factorial;

--

BEGIN
    dbms_output.put_line(Factorial(5));
END;
