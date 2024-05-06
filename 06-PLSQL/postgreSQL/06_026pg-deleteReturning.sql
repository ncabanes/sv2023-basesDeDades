-- Esborra la plataforma de codi "nds". 
-- Mostra el codi i el nom que tenia eixa plataforma.

DO
$$
DECLARE
    nomP plataformes.nom%Type;
    codiP Plataformes.codi%Type;
BEGIN
    DELETE FROM plataformes WHERE codi ='nds' 
    RETURNING codi,nom INTO codiP,nomP ;
    
    RAISE NOTICE '%', 'Nom : ' || nomP;
    RAISE NOTICE '%', 'Codi : ' || codiP;
END;
$$
