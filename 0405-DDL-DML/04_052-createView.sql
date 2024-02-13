-- Crea una vista v_jocs_plataf que mostre el nom de cada joc
-- al costat del nom de la plataforma a la qual pertany.

CREATE VIEW v_jocs_plataf AS
SELECT jocs.nom AS jocsNom, plataformes.nom AS platNom
FROM jocs, plataformes
WHERE codiPlataforma = plataformes.codi;

SELECT * FROM v_jocs_plataf;

-- Per a comprovar que s'actualitzen les dades mostrades:

UPDATE jocs SET codiPlataforma = 'PCS' WHERE codi = 'CB2';

SELECT * FROM v_jocs_plataf;
