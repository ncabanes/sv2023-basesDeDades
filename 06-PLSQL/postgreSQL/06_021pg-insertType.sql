-- Afig, des de PL/SQL, una nova plataforma de jocs, el codi de la qual 
-- serà "nds" i el nom de la qual serà "Nintendo DS". Hauràs d'emprar
-- una variable per al codi i una altra per al nom.

DO
$$
DECLARE
    pNom plataformes.nom%TYPE:= 'Nintendo DS';
    pCodi plataformes.codi%TYPE:= 'nds';

BEGIN
    INSERT INTO plataformes
    (codi, nom)
    VALUES(pCodi, pNom);
END;
$$
