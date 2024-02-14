
-- Professors que potser impartixen cursos (cada curs correspon a un únic professor), als quals potser assistixen alumnes (cada alumne a un únic curs).

-- Tres professors: Higinio, Ignacio, Javier
-- Tres cursos: Curs 1 (d'Ignacio, 40 hores), Curs 2 (de Javier, 20 hores), Curs 3 (sense assignar, hores desconegudes), Curs 4 (d'Ignacio, 25 hores)
-- Cinc alumnes: Manuel, Nadia, Otilio, Patricia, que assistixen al curs "Curs 1". Ramón, que assistix al curs "Curs 2".

-- 1. Crea la taula de "professors" (codi i nom), amb sintaxi de Oracle. El codi serà clau primària i el nom ha de ser únic. Introduïx les dades dels tres professors, amb el format abreujat (amb els codis triats per tu).

CREATE TABLE professors
(
    codi VARCHAR2(4),
    nom VARCHAR2(20),
    CONSTRAINT pk_professors PRIMARY KEY(codi),
    CONSTRAINT uk_professors UNIQUE(nom)
);

INSERT INTO professors VALUES('H', 'Higinio');
INSERT INTO professors VALUES('I', 'Ignacio');
INSERT INTO professors VALUES('J', 'Javier');


-- 2. Crea la taula de "cursos" (codi numèric, nom, codi de professor), amb sintaxi de Oracle. El codi serà clau primària, el nom no ha d'acceptar nuls, i el codi de professor serà clau aliena a la taula corresponent.

CREATE TABLE cursos
(
    codi NUMBER(4),
    nom VARCHAR2(30) NOT NULL,
    codiProfessor VARCHAR2(4),
    CONSTRAINT pk_cursos PRIMARY KEY(codi),
    CONSTRAINT fk_cursos_professors 
        FOREIGN KEY (codiProfessor)
            REFERENCES professors(codi)
);

-- 3. Amplia la taula de "cursos", afegint un nou camp: la duració, numèric de 4 xifres.

-- Oracle

ALTER TABLE cursos ADD( duracio NUMBER(4) );

-- SQLite

ALTER TABLE cursos ADD COLUMN duracio NUMBER(4);

-- Comprovació, en SQLite

.schema cursos

-- 4. Afig dades per a la taula de cursos, detallant tots els camps que realment tinguen valors (recorda que per al curs 3 no coneixem el professor ni les hores).

INSERT INTO cursos 
(codi, nom, duracio, codiProfessor)
VALUES(1, 'Curso 1', 40, 'I');

INSERT INTO cursos 
(codi, nom, duracio, codiProfessor)
VALUES(2, 'Curso 2', 20, 'J');

INSERT INTO cursos (codi, nom) VALUES(3, 'Curso 3');

INSERT INTO cursos 
(codi, nom, duracio, codiProfessor)
VALUES(4, 'Curso 4', 25, 'I');


-- 5. Crea la taula d'alumnes (codi, nom, codi de curs). El codi serà clau primària i el nom ha de tindre com a mínim 2 lletres. Crea una taula "backupAlumnos" amb la mateixa estructura.

CREATE TABLE alumnes
(
    codi VARCHAR2(4),
    nom VARCHAR2(30),
    codiCurs NUMBER(4),
    CONSTRAINT pk_alumnes PRIMARY KEY(codi),
    CONSTRAINT ck_alumnes_nom CHECK (LENGTH(nom) >= 2),
    CONSTRAINT fk_alumnes_cursos 
        FOREIGN KEY (codiCurs)
            REFERENCES cursos(codi)
);

INSERT INTO alumnes VALUES('M', 'Manuel', 1);
INSERT INTO alumnes VALUES('N', 'Nadia', 1);
INSERT INTO alumnes VALUES('O', 'Otilio', 1);
INSERT INTO alumnes VALUES('P', 'Patricia', 1);
INSERT INTO alumnes VALUES('R', 'Ramón', 2);

CREATE TABLE backupAlumnes
(
    codi VARCHAR2(4),
    nom VARCHAR2(30),
    codiCurs NUMBER(4),
    CONSTRAINT pk_bAlumnes PRIMARY KEY(codi),
    CONSTRAINT ck_bAlumnes_nom CHECK (LENGTH(nom) >= 2),
    CONSTRAINT fk_bAlumnes_cursos 
        FOREIGN KEY (codiCurs)
            REFERENCES cursos(codi)
);

-- 6. Mostra codi i nom dels alumnes del curs 1.

SELECT codi, nom
FROM alumnes
WHERE codiCurs = 1;

-- 7. Mostra codi i nom dels alumnes de cursos que no siguen el 1.

SELECT codi, nom
FROM alumnes
WHERE codiCurs <> 1;

-- 8. Mostra els noms d'alumnes que comencen per M, usant LIKE.

SELECT nom
FROM alumnes
WHERE UPPER(nom) LIKE 'M%';

-- 9. Mostra els noms d'alumnes que comencen per M, usant SUBSTR.

SELECT nom
FROM alumnes
WHERE SUBSTR(UPPER(nom),1,1) = 'M';


-- 10. Mostra els noms d'alumnes que comencen per M, usant INSTR.

SELECT nom
FROM alumnes
WHERE INSTR(UPPER(nom),'M') = 1;


-- 11. Mostra els noms d'alumnes que NO comencen per M, usant LIKE.

SELECT nom
FROM alumnes
WHERE UPPER(nom) NOT LIKE 'M%';

-- 12. Mostra els noms d'alumnes que NO comencen per M, usant SUBSTR.

SELECT nom
FROM alumnes
WHERE SUBSTR(UPPER(nom),1,1) <> 'M';

-- 13. Mostra els noms d'alumnes que NO comencen per M, usant INSTR.

SELECT nom
FROM alumnes
WHERE INSTR(UPPER(nom),'M') <> 1;


-- 14. Mostra la duració mitjana dels cursos, arredonida a una xifra decimal, amb l'àlies DuracMitjana.

SELECT ROUND(AVG(duracio), 1) AS duracMitjana
FROM cursos;


-- 15. Mostra els noms dels cursos que duren més de la mitjana.

SELECT nom FROM cursos
WHERE duracio > 
(
    SELECT AVG(duracio) FROM cursos
);

-- 16. Mostra el nom del curs més llarg, usant ORDER BY i LIMIT /FETCH.

-- Prova prèvia

SELECT nom, duracio
FROM cursos 
ORDER BY duracio DESC;


-- SQLite, MySQL

SELECT nom
FROM cursos 
ORDER BY duracio DESC 
LIMIT 1;

-- Oracle

SELECT nom 
FROM cursos 
WHERE duracio IS NOT NULL
ORDER BY duracio DESC 
FETCH NEXT 1 ROWS ONLY;

-- 17. Mostra el nom del curs més llarg, usant MAX i = o IN.

SELECT nom FROM cursos
WHERE duracio = 
(
    SELECT MAX(duracio) FROM cursos
);

-- 18. Mostra el nom del curs més llarg, usant ALL o ANY.

SELECT nom FROM cursos
WHERE duracio >= ALL 
(
    SELECT duracio FROM cursos
    WHERE duracio IS NOT NULL
);

-- 19. Mostra el nom del curs més llarg, usant EXISTS o NOT EXISTS.

-- Inclouent nuls

SELECT nom FROM cursos c1
WHERE NOT EXISTS
(
    SELECT nom FROM cursos c2
    WHERE c2.duracio > c1.duracio
);

-- Sense nuls

SELECT nom FROM cursos c1
WHERE duracio IS NOT NULL AND NOT EXISTS
(
    SELECT nom FROM cursos c2
    WHERE c2.duracio > c1.duracio
);

-- 20. Mostra els noms dels professors, juntament amb el nom dels cursos que impartixen (només per als professors i cursos que realment estan relacionats). Has d'emprar WHERE per a enllaçar les taules.

-- SQLite

SELECT professors.nom, cursos.nom
FROM professors, cursos
WHERE professors.codi = cursos.codiProfessor;

-- Oracle

SELECT professors.nom AS nomProf, cursos.nom as nomCurs
FROM professors, cursos
WHERE professors.codi = cursos.codiProfessor;


-- 21. Mostra els noms dels professors, juntament amb el nom dels cursos que impartixen (només per als professors i cursos que realment estan relacionats). Has d'emprar JOIN per a enllaçar les taules.

SELECT professors.nom AS nomProf, cursos.nom as nomCurs
FROM professors JOIN cursos
ON professors.codi = cursos.codiProfessor;


-- 22. Mostra els noms de tots els professors, juntament amb el nom dels cursos que impartixen (potser cap).

SELECT professors.nom AS nomProf, cursos.nom as nomCurs
FROM professors LEFT JOIN cursos
ON professors.codi = cursos.codiProfessor;


-- 23. Mostra el nom de cada curs, juntament amb la quantitat d'alumnes, fins i tot per als cursos que no tinguen alumnes.

SELECT cursos.nom, COUNT(alumnes.codi)
FROM cursos LEFT JOIN alumnes
ON cursos.codi = alumnes.codiCurs
GROUP BY cursos.nom;


-- 24. Mostra el nom de cada curs, juntament amb la quantitat d'alumnes, però només per als cursos amb més d'un alumne.

SELECT cursos.nom, COUNT(alumnes.codi)
FROM cursos LEFT JOIN alumnes
ON cursos.codi = alumnes.codiCurs
GROUP BY cursos.nom
HAVING COUNT(alumnes.codi) > 1;


-- 25. Mostra els codis i noms dels alumnes que assistixen al curs més llarg, ordenats alfabèticament.

-- 25a. Duració del curs mès llarg

SELECT MAX(duracio) FROM cursos;

-- 25b. Codi del curs mès llarg

SELECT codi FROM cursos WHERE duracio =
(
    SELECT MAX(duracio) FROM cursos
);

-- 25c. Consulta completa

SELECT codi, nom FROM alumnes WHERE codiCurs IN 
(
    SELECT codi FROM cursos WHERE duracio =
    (
        SELECT MAX(duracio) FROM cursos
    )
)
ORDER BY nom;


-- 26. Canvia la duració del curs 3, que passarà a ser de 30 hores.

UPDATE cursos
SET duracio = 30
WHERE codi = 3;

-- 27. Esborra el curs 4.

DELETE FROM cursos WHERE codi = 4;

-- 28. Mostra els noms dels cursos per als quals no hi ha un professor assignat.

SELECT nom
FROM cursos 
WHERE codiProfessor IS NULL;

-- 29. Mostra la quantitat de professors que impartixen més d'un curs.

-- 29a. Professors i cursos (22)

SELECT professors.nom AS nomProf, cursos.nom as nomCurs
FROM professors LEFT JOIN cursos
ON professors.codi = cursos.codiProfessor;

-- 29b. Professors i quantitat de cursos

SELECT professors.nom, COUNT(cursos.codi)
FROM professors LEFT JOIN cursos
ON professors.codi = cursos.codiProfessor
GROUP BY professors.nom;

-- 29c. Professors amb més d'un curs

SELECT professors.nom, COUNT(cursos.codi)
FROM professors LEFT JOIN cursos
ON professors.codi = cursos.codiProfessor
GROUP BY professors.nom
HAVING COUNT(cursos.codi) > 1;

-- 29d. Consulta completa

SELECT COUNT(*) FROM
(
    SELECT professors.nom, COUNT(cursos.codi)
    FROM professors LEFT JOIN cursos
    ON professors.codi = cursos.codiProfessor
    GROUP BY professors.nom
    HAVING COUNT(cursos.codi) > 1
);


-- 30. Buida la taula "backupAlumnos" (sense usar DELETE).

-- No en SQLite

TRUNCATE TABLE backupAlumnes;


-- 31. Mostra els noms tant d'alumnes com de professors, en una mateixa columna.

SELECT nom FROM alumnes
UNION
SELECT nom FROM professors;


-- 32. Afig un professor anomenat "Manuel". Mostra els noms d'alumnes que coincidisquen amb el d'algun professor.

INSERT INTO professors VALUES('M', 'Manuel');

SELECT nom FROM alumnes
INTERSECT
SELECT nom FROM professors;


-- 33. Mostra els noms d'alumnes que no coincidisquen amb el de cap professor.

SELECT nom FROM alumnes
EXCEPT
SELECT nom FROM professors;


-- 34. Elimina la taula "backupAlumnos".

DROP TABLE backupAlumnes;


-- 35, 36. Mostra els noms dels cursos el codi dels quals està entre el 2 i el 5, tots dos inclusivament, de 2 formes diferents.

SELECT nom
FROM cursos
WHERE codi >= 2 AND codi <= 5;

SELECT  nom
FROM cursos
WHERE codi BETWEEN 2 AND 5;


-- 37. Mostra la quantitat de noms d'alumnes diferents que tenim.

SELECT COUNT(DISTINCT nom)
FROM alumnes;


-- 38. Mostra els noms dels cursos que siguen més llargs que tots els que impartix el professor anomenat Javier.

SELECT nom
FROM cursos
WHERE duracio >=
(
    SELECT MAX(duracio) FROM cursos, professors 
    WHERE professors.codi = cursos.codiProfessor 
    AND professors.nom = 'Javier'
);


-- 39. Mostra el nom dels 10 cursos més llargs, exceptuat els dos més llargs (és a dir, del tercer més llarg al dècim més llarg).

-- Previ: nom i duració dels cursos

SELECT nom, duracio FROM cursos ORDER BY duracio DESC;

-- Del 3 al 10, SQLite

SELECT nom FROM cursos ORDER BY duracio DESC
LIMIT 8 OFFSET 2;

-- Del 3 al 10, Oracle

SELECT nom FROM cursos ORDER BY duracio DESC
OFFSET 2 ROWS
FETCH NEXT 8 ROWS ONLY;


-- 40. Noms dels alumnes que estan en els cursos anomenats "Curso 1" o "Curso 2", usant "IN". En una mateixa columna han d'aparéixer el nom del curs i el nom de l'alumne, amb una aparença com a "Curs 1: Nadia".

-- Oracle

SELECT CONCAT(c.nom, ': ', a.nom)
FROM cursos c JOIN alumnes a
ON c.codi = a.codiCurs
WHERE c.nom IN ('Curso 1', 'Curso 2');

-- SQLite

SELECT c.nom || ': ' || a.nom
FROM cursos c JOIN alumnes a
ON c.codi = a.codiCurs
WHERE c.nom IN ('Curso 1', 'Curso 2');


-- --------------------------------


-- Profesores que quizá impartan cursos (cada curso corresponde a un único profesor), a los que quizá asistan alumnos (cada alumno a un único curso).

-- Tres profesores: Higinio, Ignacio, Javier
-- Tres cursos: Curso 1 (de Ignacio, 40 horas), Curso 2 (de Javier, 20 horas), Curso 3 (sin asignar, horas desconocidas), Curso 4 (de Ignacio, 25 horas)
-- Cinco alumnos: Manuel, Nadia, Otilio, Patricia, que asisten al curso "Curso 1". Ramón, que asiste al curso "Curso 2".

-- 1. Crea la tabla de "profesores" (código y nombre), con sintaxis de Oracle. El código será clave primaria y el nombre debe ser único. Introduce los datos de los tres profesores, con el formato abreviado (con los códigos escogidos por ti).

-- 2. Crea la tabla de "cursos" (código numérico, nombre, código de profesor), con sintaxis de Oracle. El código será clave primaria, el nombre no debe aceptar nulos, y el código de profesor será clave ajena a la tabla correspondiente.

-- 3. Amplía la tabla de "cursos", añadiendo un nuevo campo: la duración, numérico de 4 cifras.

-- 4. Añade datos para la tabla de cursos, detallando todos los campos que realmente tengan valores (recuerda que para el curso 3 no conocemos el profesor ni las horas).

-- 5. Crea la tabla de alumnos (código, nombre, código de curso). El código será clave primaria y el nombre debe tener como mínimo 2 letras. Crea una tabla "backupAlumnos" con la misma estructura.

-- 6. Muestra código y nombre de los alumnos del curso 1.

-- 7. Muestra código y nombre de los alumnos de cursos que no sean el 1.

-- 8. Muestra los nombres de alumnos que empiezan por M, usando LIKE.

-- 9. Muestra los nombres de alumnos que empiezan por M, usando SUBSTR.

-- 10. Muestra los nombres de alumnos que empiezan por M, usando INSTR.

-- 11. Muestra los nombres de alumnos que NO empiezan por M, usando LIKE.

-- 12. Muestra los nombres de alumnos que NO empiezan por M, usando SUBSTR.

-- 13. Muestra los nombres de alumnos que NO empiezan por M, usando INSTR.

-- 14. Muestra la duración media de los cursos, redondeada a una cifra decimal, con el alias DuracMedia.

-- 15. Muestra los nombres de los cursos que duran más de la media.

-- 16. Muestra el nombre del curso más largo, usando ORDER BY y LIMIT /FETCH.

-- 17. Muestra el nombre del curso más largo, usando MAX y = ó IN.

-- 18. Muestra el nombre del curso más largo, usando ALL o ANY.

-- 19. Muestra el nombre del curso más largo, usando EXISTS o NOT EXISTS.

-- 20. Muestra los nombres de los profesores, junto con el nombre de los cursos que imparten (sólo para los profesores y cursos que realmente están relacionados). Debes emplear WHERE para enlazar las tablas.

-- 21. Muestra los nombres de los profesores, junto con el nombre de los cursos que imparten (sólo para los profesores y cursos que realmente están relacionados). Debes emplear JOIN para enlazar las tablas.

-- 22. Muestra los nombres de todos los profesores, junto con el nombre de los cursos que imparten (quizá ninguno).

-- 23. Muestra el nombre de cada curso, junto con la cantidad de alumnos, incluso para los cursos que no tengan alumnos.

-- 24. Muestra el nombre de cada curso, junto con la cantidad de alumnos, pero sólo para los cursos con más de un alumno.

-- 25. Muestra los códigos y nombres de los alumnos que asisten al curso más largo, ordenados alfabéticamente.

-- 26. Cambia la duración del curso 3, que pasará a ser de 30 horas.

-- 27. Borra el curso 4.

-- 28. Muestra los nombres de los cursos para los que no hay un profesor asignado.

-- 29. Muestra la cantidad de profesores que imparten más de un curso.

-- 30. Vacía la tabla "backupAlumnos" (sin usar DELETE).

-- 31. Muestra los nombres tanto de alumnos como de profesores, en una misma columna.

-- 32. Añade un profesor llamado "Manuel". Muestra los nombres de alumnos que coincidan con el de algún profesor.

-- 33. Muestra los nombres de alumnos que no coincidan con el de ningún profesor.

-- 34. Elimina la tabla "backupAlumnos".

-- 35, 36. Muestra los nombres de los cursos cuyo código está entre el 2 y el 5, ambos inclusive, de 2 formas distintas.

-- 37. Muestra la cantidad de nombres de alumnos distintos que tenemos.

-- 38. Muestra los nombres de los cursos que sean más largos que todos los que imparte el profesor llamado Javier.

-- 39. Muestra el nombre de los 10 cursos más largos, exceptuado los dos mayores (es decir, del tercero más largo al décimo más largo).

-- 40. Nombres de los alumnos que están en los cursos llamados "Curso 1" o "Curso 2", usando "IN". En una misma columna deben aparecer el nombre del curso y el nombre del alumno, con una apariencia como "Curso 1: Nadia".
