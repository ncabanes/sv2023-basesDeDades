CREATE OR REPLACE PROCEDURE InserirJoc(
    pCodiJoc IN VARCHAR2, pNomJoc IN VARCHAR2, 
    pCodiPlataforma IN VARCHAR2) 
IS  
    numPlataformes NUMBER(3);
    
BEGIN
    SELECT COUNT(*)
        INTO numPlataformes
        FROM plataformes
        WHERE codi = codiPlataforma;
    
    IF numPlataformes = 0 THEN
        dbms_output.put_line('No existeix aqueixa plataforma.');
    ELSE
        INSERT INTO jocs(codi, nom, codiPlataforma)
            VALUES(pCodiJoc, pNomJoc, pCodiPlataforma);
        dbms_output.put_line('Joc guardat correctcament.');
    END IF;
END InserirJoc;

--
