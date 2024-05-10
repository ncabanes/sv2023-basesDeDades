-- A partir de la següent estructura de taules sobre llenguatges de programació i compiladors (en la qual, per simplificar, suposarem que cada compilador és per a un únic llenguatge):
-- 
-- Llenguatges(codi, nom, anyCreació)
-- Compiladors(codiCompilador, nom, codiLlenguatge)
-- VersionsDeCompiladors(codiCompilador, númeroVersió, dataLlançament)
-- 
-- i les següents dades d'exemple:

CREATE TABLE llenguatges (
  codi VARCHAR(4) PRIMARY KEY,
  nom VARCHAR(20),
  anyCreacio NUMBER(4)
);

CREATE TABLE compiladors (
  codi VARCHAR(6) PRIMARY KEY,
  nom VARCHAR(30),
  codiLlenguatge VARCHAR(4)
);

CREATE TABLE versionsCompiladors (
  codiComp VARCHAR(6),
  numVersio VARCHAR(10),
  dataLlanc NUMBER(4),
  PRIMARY KEY (codiComp, numVersio)
);

INSERT INTO llenguatges VALUES ('cob', 'COBOL', 1959);
INSERT INTO llenguatges VALUES ('bas', 'BASIC', 1964);
INSERT INTO llenguatges VALUES ('pas', 'Pascal', 1970);
INSERT INTO llenguatges VALUES ('c', 'C', 1972);
INSERT INTO llenguatges VALUES ('cpp', 'C++', 1983);
INSERT INTO llenguatges VALUES ('py', 'Python', 1991);
INSERT INTO llenguatges VALUES ('cs', 'C#', 2000);

INSERT INTO compiladors VALUES ('tp', 'Turbo Pascal', 'pas');
INSERT INTO compiladors VALUES ('fp', 'Free Pascal', 'pas');
INSERT INTO compiladors VALUES ('tc', 'Turbo C', 'c');
INSERT INTO compiladors VALUES ('bc', 'Borland C++', 'cpp');
INSERT INTO compiladors VALUES ('owa', 'Open Watcom C++', 'cpp');
INSERT INTO compiladors VALUES ('vs', 'Visual Studio', 'cs');

INSERT INTO versionsCompiladors VALUES ('tp', '1.0', 1983);
INSERT INTO versionsCompiladors VALUES ('tp', '7.0', 1992);
INSERT INTO versionsCompiladors VALUES ('fp', '3.2.2', 2021);
INSERT INTO versionsCompiladors VALUES ('bc', '3.1', 1992);
INSERT INTO versionsCompiladors VALUES ('owa', '1.9', 2010);
INSERT INTO versionsCompiladors VALUES ('vs', '2022 ', 2021);


-- 5.- Crea un procediment "MostrarCompiladors2", similar a "Mostrar Compiladors" 
-- però amb dues diferències: usarà un bucle LOOP i, en cas de no trobar cap dada, 
-- respondrà "No hi ha compiladors".

CREATE OR REPLACE PROCEDURE MostrarCompiladors2 (v_nomLleng IN VARCHAR2)
AS
    v_registre LlenguatgesICompiladors % ROWTYPE;
    v_quantitat NUMBER := 0;
    
    CURSOR cursor_compiladors IS
        SELECT * 
        FROM LlenguatgesICompiladors
        WHERE UPPER(nomL) = UPPER(v_nomLleng);
BEGIN
    OPEN cursor_compiladors;
    LOOP
        FETCH cursor_compiladors INTO v_registre;
        EXIT WHEN cursor_compiladors % NOTFOUND;

        dbms_output.put_line(v_registre.codiC
             || ' - ' || v_registre.nomC
             || ' - ' || v_registre.numVersio
             || ' - ' || v_registre.DataLlanc);
        v_quantitat := v_quantitat + 1;
    END LOOP;
    CLOSE cursor_compiladors;
    IF v_quantitat = 0 THEN
        dbms_output.put_line('No hi ha compiladors');
    END IF;
END MostrarCompiladors2;

-- Prova

BEGIN
    dbms_output.put_line('-pascal:');
    MostrarCompiladors2('pascal');
    
    dbms_output.put_line('-go:');
    MostrarCompiladors2('go');
END;

-- Alternativa, con %NOTFOUND

CREATE OR REPLACE PROCEDURE MostrarCompiladors2 (nomLleng IN VARCHAR)
AS
    CURSOR compiladors_cursor IS
    SELECT v.codiComp AS codiComp, c.nom AS nomComp, 
    v.numVersio AS numVersio, v.dataLlanc AS dataLlanc
    FROM llenguatges l LEFT JOIN compiladors c 
    ON l.codi = c.codiLlenguatge 
    INNER JOIN versionsCompiladors v
    ON c.codi = v.codiComp
    AND UPPER(l.nom) = UPPER(nomLleng)
    ORDER BY nomComp;
    
    v_codiComp versionsCompiladors.codiComp % TYPE;
    v_nom compiladors.nom % TYPE;
    v_numVersio versionsCompiladors.numVersio % TYPE;
    v_dataLlanc versionsCompiladors.dataLlanc % TYPE;
    
BEGIN
    OPEN compiladors_cursor;
    
    FETCH compiladors_cursor INTO v_codiComp, v_nom, 
    v_numVersio, v_dataLlanc;
    IF compiladors_cursor %NOTFOUND THEN
        dbms_output.put_line('No hi ha compiladors');
    ELSE
        LOOP
            EXIT WHEN compiladors_cursor %NOTFOUND;
            dbms_output.put_line(v_codiComp || ' - ' || 
            v_nom || ' - ' || v_numVersio || ' - ' ||
            v_dataLlanc);
            FETCH compiladors_cursor INTO v_codiComp, v_nom, 
            v_numVersio, v_dataLlanc;
        END LOOP;
    END IF;
    
    CLOSE compiladors_cursor;
    
END MostrarCompiladors2;


-- 6.- Crea un procediment "MostrarVersionsCompilador" que, per a un cert 
-- compilador, el nom del qual rebrà com a paràmetre, mostrarà totes les versions 
-- que tenim disponibles (número i any), emprant un bucle WHILE. Abans de mostrar 
-- aquestes versions, en la línia anterior, escriurà el nom del compilador, i, 
-- emprant CASE (i sense consultar la taula "llenguatges"), si es tracta d'un 
-- compilador de llenguatge Pascal (codi "pas"), C++ (codi "cpp") o altres. Hauràs 
-- d'usar excepcions per a comprovar el cas que el compilador no existisca o que 
-- hi haja 2 amb el mateix nom. Prova-ho emprant un bloc anònim.

-- Prova

SELECT compiladors.codi AS codiC, compiladors.nom as nomC,
    versionsCompiladors.numVersio, versionsCompiladors.dataLlanc
FROM compiladors 
    LEFT JOIN versionsCompiladors ON versionsCompiladors.codiComp = compiladors.codi
ORDER BY nomC, numVersio;

-- Procedure

CREATE OR REPLACE PROCEDURE MostrarVersionsCompilador (v_nomComp IN VARCHAR2)
AS
    v_nom compiladors.nom % TYPE;
    v_codiLeng compiladors.codiLlenguatge % TYPE;
    v_numVers versionsCompiladors.numVersio % TYPE;
    v_data versionsCompiladors.dataLlanc % TYPE;
    
    CURSOR cursor_versions IS
        SELECT versionsCompiladors.numVersio, versionsCompiladors.dataLlanc
        FROM compiladors 
            LEFT JOIN versionsCompiladors 
            ON versionsCompiladors.codiComp = compiladors.codi
        WHERE nom = v_nomComp
        ORDER BY nom, numVersio;

BEGIN
    SELECT nom, codiLlenguatge
    INTO v_nom, v_codiLeng
    FROM compiladors
    WHERE nom = v_nomComp;
    
    dbms_output.put_line(v_nom);
    CASE v_codiLeng
        WHEN 'pas' THEN dbms_output.put_line('Pascal');
        WHEN 'cpp' THEN dbms_output.put_line('C++');
        ELSE dbms_output.put_line('(Altres llenguatges');
    END CASE;

    OPEN cursor_versions;
    FETCH cursor_versions INTO v_numVers, v_data;
    WHILE cursor_versions % FOUND LOOP
        dbms_output.put_line(v_numVers || ', ' || v_data);
        FETCH cursor_versions INTO v_numVers, v_data;
    END LOOP;
    CLOSE cursor_versions;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('No trobat');
        WHEN TOO_MANY_ROWS THEN
            dbms_output.put_line('Duplicat');
END;

-- Prova

BEGIN
    dbms_output.put_line('-Turbo Pascal:');
    MostrarVersionsCompilador('Turbo Pascal');
    
    dbms_output.put_line('-XCS:');
    MostrarVersionsCompilador('XCS');
END;


-- 7.- Crea un procediment "AnalitzarAnys", que reba com a paràmetres un any 
-- inicial i un any final. Des del primer d'aqueixos anys fins a l'últim (tots dos 
-- inclosos), mostrarà l'any i la quantitat de compiladors que tenim emmagatzemats 
-- per a aqueix any. Prova-ho emprant EXECUTE.

CREATE OR REPLACE PROCEDURE AnalitzarAnys(v_anyIni IN NUMBER, v_anyFi IN NUMBER)
AS
    v_quantitat NUMBER;
        
BEGIN
    FOR anyComp IN v_anyIni .. v_anyFi LOOP
        SELECT COUNT(*) 
            INTO v_quantitat
            FROM versionsCompiladors
            WHERE dataLlanc = anyComp;
        dbms_output.put_line(anyComp || ': ' || v_quantitat);
    END LOOP;
END;

-- Prova

EXECUTE AnalitzarAnys(1980, 1993);


-- 8.- Crea una funció "AnyDeCompilador", que, a partir d'un cert codi de 
-- compilador i un número de versió que rebrà com a paràmetres, retorne com a text 
-- l'any d'aqueixa versió, o bé el text "Inexistent" si no existeix aqueixa versió 
-- d'aqueix compilador. Has d'emprar excepcions per a filtrar el cas que no 
-- existisca.

-- Prova

SELECT dataLlanc 
FROM versionsCompiladors
WHERE codiComp = 'tp' AND numVersio = '5.5';

-- Funció

CREATE OR REPLACE FUNCTION AnyDeCompilador (
    v_codi IN VARCHAR2, 
    v_numVers IN VARCHAR2)
RETURN VARCHAR2
AS
    v_any NUMBER;
BEGIN
    SELECT dataLlanc 
    INTO v_any
    FROM versionsCompiladors
    WHERE codiComp = v_codi AND numVersio = v_numVers;
    
    RETURN TO_CHAR(v_any);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Inexistent';
    WHEN TOO_MANY_ROWS THEN
        RETURN'Duplicat';
END;

-- Prova

BEGIN
    dbms_output.put_line('tp 7.0: ' || AnyDeCompilador('tp', '7.0'));
    dbms_output.put_line('xp 1: ' || AnyDeCompilador('xp', '1'));
END;


-- 9.- Crea un trigger "ValidarAny" que, a l'hora d'afegir una certa versió d'un 
-- compilador, li afija 1900 si l'any que introdueix l'usuari està entre el 60 i 
-- el 99, i li afija 2000 si està entre 0 i 59. Si és any és major o igual que 
-- 100, es guardarà sense canvis. Per exemple, si és usuari introdueix una dada 
-- amb l'any 90, es guardarà com 1990, i si guarda un de l'any 22, es guardarà com 
-- 2022.

CREATE OR REPLACE TRIGGER ValidarAny
BEFORE INSERT ON versionsCompiladors
FOR EACH ROW
BEGIN
    IF :NEW.dataLlanc <= 59 THEN
        :NEW.dataLlanc := :NEW.dataLlanc + 2000;
    ELSIF :NEW.dataLlanc <= 99 THEN
        :NEW.dataLlanc := :NEW.dataLlanc + 1900;
    END IF;
END;

-- Prova

INSERT INTO versionsCompiladors VALUES ('tp', '5.5', 89);
INSERT INTO versionsCompiladors VALUES ('fp', '2.4.0', 10);

SELECT * FROM versionsCompiladors 
WHERE codiComp = 'tp' OR codiComp = 'fp';


-- 10.- Crea una funció "QuantitatDeCompiladorsComAText", que reba com a paràmetre 
-- el nom d'un llenguatge, i retorne el text "Cap compilador trobat", "Un 
-- compilador trobat" o "Més d''un compilador trobat", segons corresponga a partir 
-- de la quantitat de versions de compiladors existents per a aqueix llenguatge, 
-- usant IF i sense control d'excepcions.

-- Prova

SELECT COUNT(*) 
FROM compiladors, llenguatges
WHERE compiladors.codiLlenguatge = llenguatges.codi
AND llenguatges.nom = 'Pascal';

-- Funció

CREATE OR REPLACE FUNCTION QuantitatDeCompiladorsComAText (
    v_nomLeng IN VARCHAR2)
RETURN VARCHAR2
AS
    v_quantitat NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO v_quantitat
    FROM compiladors, llenguatges
    WHERE compiladors.codiLlenguatge = llenguatges.codi
    AND llenguatges.nom = v_nomLeng;
    
    IF v_quantitat = 0 THEN
        RETURN 'Cap compilador trobat';
    ELSIF v_quantitat = 1 THEN
        RETURN 'Un compilador trobat';
    ELSE
        RETURN 'Més d''un compilador trobat';
    END IF;
END;

-- Prova

BEGIN
    dbms_output.put_line('Pascal: ' || QuantitatDeCompiladorsComAText('Pascal'));
    dbms_output.put_line('C: ' || QuantitatDeCompiladorsComAText('C'));
    dbms_output.put_line('Lisp: ' || QuantitatDeCompiladorsComAText('Lisp'));
END;


-- 11.- Crea una funció "QuantitatDeCompiladorsComAText2", que reba com a 
-- paràmetre el nom d'un llenguatge, i retorne el text "Cap compilador trobat", 
-- "Un compilador trobat" o "Més d''un compilador trobat", segons corresponga a 
-- partir de la quantitat de versions de compiladors existents per a aqueix 
-- llenguatge. No ha d'usar IF (ni CASE) sinó control d'excepcions.

-- Funció

CREATE OR REPLACE FUNCTION QuantitatDeCompiladorsComAText2 (
    v_nomLeng IN VARCHAR2)
RETURN VARCHAR2
AS
    v_codi versionsCompiladors.codiComp % TYPE;
BEGIN
    SELECT compiladors.codi 
    INTO v_codi
    FROM compiladors, llenguatges
    WHERE compiladors.codiLlenguatge = llenguatges.codi
    AND llenguatges.nom = v_nomLeng;
    
    RETURN 'Un compilador trobat';
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Cap compilador trobat';
    WHEN TOO_MANY_ROWS THEN
        RETURN'Més d''un compilador trobat';
END;

-- Prova

BEGIN
    dbms_output.put_line('Pascal: ' || QuantitatDeCompiladorsComAText2('Pascal'));
    dbms_output.put_line('C: ' || QuantitatDeCompiladorsComAText2('C'));
    dbms_output.put_line('Lisp: ' || QuantitatDeCompiladorsComAText2('Lisp'));
END;


-- 12.- Crea un procediment "MostrarLlistaCompiladors", que reba com a paràmetre el 
-- nom d'un llenguatge, i mostre en una primera línia el text "Cap compilador 
-- trobat", "Un compilador trobat" o "Més d'un compilador trobat", segons 
-- corresponga, ajudant-se d'una de les dues funcions anteriors, i després mostre 
-- les versions de compiladors (codi, nom, versió, data), cadascuna en una línia.

CREATE OR REPLACE PROCEDURE MostrarLlistaCompiladors (v_nomLleng IN VARCHAR2)
AS
BEGIN
    dbms_output.put_line(v_nomLleng || ': '
         || QuantitatDeCompiladorsComAText(v_nomLleng));
    MostrarCompiladors(v_nomLleng);
END;

-- Prova

BEGIN
    dbms_output.put_line('-Pascal:');
    MostrarLlistaCompiladors('Pascal');
    
    dbms_output.put_line('-go:');
    MostrarLlistaCompiladors('go');
END;

