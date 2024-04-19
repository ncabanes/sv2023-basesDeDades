-- Esborra la plataforma de codi "nds". 
-- Mostra el codi i el nom que tenia eixa plataforma.

DECLARE
    nomP plataformes.nom%Type;
    codiP Plataformes.codi%Type;
BEGIN
    DELETE FROM plataformes WHERE codi ='nds' 
    RETURNING codi,nom INTO nomP,codiP ;
    
    dbms_output.put_line('Nom : ' || nomP);
    dbms_output.put_line('Codi : ' || codiP);
END;
