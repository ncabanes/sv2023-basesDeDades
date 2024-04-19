-- Afig, des de PL/SQL, una nova plataforma de jocs, usant ROWTYPE. 
-- El seu codi serà "smd" i el seu nom serà "Sega MegaDrive".

DECLARE
    plat plataformes % ROWTYPE;
BEGIN
    plat.codi := 'smd';
    plat.nom := 'Sega MegaDrive';
    INSERT INTO plataformes VALUES plat;
END;
