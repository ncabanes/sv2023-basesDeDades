/* Crea un procediment "MostrarNomsDeJocs(plataforma)", que mostre els 
noms de tots els jocs d'una certa plataforma (el codi de la qual 
s'indicarà com a paràmetre), ordenats, en una mateixa línia, separats 
per un espai. Has d'usar un cursor amb WHILE.
*/

CREATE OR REPLACE PROCEDURE MostrarNomsDeJocs (
    v_plataforma IN CHAR
)
LANGUAGE plpgsql
AS
$$
DECLARE
    cursorJocs CURSOR FOR
        SELECT nom
        FROM jocs
        WHERE codiPlataforma = v_plataforma
        ORDER BY nom;
    v_nom jocs.nom % TYPE;
    v_respuesta VARCHAR(1134) := '';
BEGIN
    OPEN cursorJocs;
    FETCH cursorJocs INTO v_nom;
    WHILE FOUND LOOP
        v_respuesta := v_respuesta || v_nom || ' ';
        FETCH cursorJocs INTO v_nom;
    END LOOP;
    CLOSE cursorJocs;
    RAISE NOTICE '%', v_respuesta;
END;
$$

CALL MostrarNomsDeJocs('ps3');

