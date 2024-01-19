CREATE TABLE alumnesNotes (
    nom VARCHAR(50), 
    tema VARCHAR(20), 
    nota NUMERIC (5,2),
    PRIMARY KEY (nom, tema));

INSERT INTO alumnesNotes VALUES ('Abraham', 'Tema 1', 9.8);
INSERT INTO alumnesNotes VALUES ('Basilio', 'Tema 1', 7.7);
INSERT INTO alumnesNotes VALUES ('Cecilia', 'Tema 1', 9.8);
INSERT INTO alumnesNotes VALUES ('David', 'Tema 1', 4.3);
INSERT INTO alumnesNotes VALUES ('Elena', 'Tema 1', 8.5);

INSERT INTO alumnesNotes VALUES ('Abraham', 'Tema 2', 10.0);
INSERT INTO alumnesNotes VALUES ('Basilio', 'Tema 2', 7.5);
INSERT INTO alumnesNotes VALUES ('Cecilia', 'Tema 2', 9.4);
INSERT INTO alumnesNotes VALUES ('David', 'Tema 2', 4.1);
INSERT INTO alumnesNotes VALUES ('Elena', 'Tema 2', 8.9);

INSERT INTO alumnesNotes VALUES ('Abraham', 'Tema 3', 8.8);
INSERT INTO alumnesNotes VALUES ('Basilio', 'Tema 3', 7.1);
INSERT INTO alumnesNotes VALUES ('Cecilia', 'Tema 3', 9.9);
INSERT INTO alumnesNotes VALUES ('Elena', 'Tema 3', 9.5);
INSERT INTO alumnesNotes VALUES ('Gerardo', 'Tema 3', 2.1);

-- 1. Noms d'alumnes, sense duplicats.

SELECT DISTINCT nom
FROM alumnesNotes;


-- 2. Notes (tema i nota) de l'alumne el nom del qual és "Elena".

SELECT tema, nota
FROM alumnesNotes
WHERE nom = 'Elena';


-- 3. Nota mitjana de tots els exàmens.

SELECT AVG(nota)
FROM alumnesNotes;


-- 4. Nota mitjana dels exàmens del Tema 2.

SELECT AVG(nota)
FROM alumnesNotes
WHERE tema = 'Tema 2';


-- 5. Nota mitjana dels exàmens dels alumnes el nom dels quals comença per "C".

SELECT AVG(nota)
FROM alumnesNotes
WHERE nom LIKE 'C%';


-- 6. Nota mitjana de cada examen, ordenada per tema.

SELECT tema, AVG(nota)
FROM alumnesNotes
GROUP BY tema
ORDER BY tema;


-- 7. Nota mitjana de cada alumne, ordenada per nom, de la Z a la A.

SELECT nom, AVG(nota)
FROM alumnesNotes
GROUP BY nom
ORDER BY nom DESC;



-- 8. Nota mitjana dels alumnes, la mitjana dels quals és un suspens.

SELECT nom, AVG(nota)
FROM alumnesNotes
GROUP BY nom
HAVING AVG(nota) < 5;


-- 9. Notes del tema 1 i del tema 2.

SELECT nota
FROM alumnesNotes
WHERE tema = 'Tema 1' OR tema = 'Tema 2';


-- 10. Nota més alta.

SELECT MAX(nota)
FROM alumnesNotes;


-- 11. Nom d'alumne i de tema, per als exàmens dels quals no hi haja nota.

SELECT nom, tema
FROM alumnesNotes
WHERE nota IS NULL;


-- 12 i 13. Nom d'alumne, de tema i nota, per als exàmens amb notes entre 9 i 10 (de 2 formes diferents).

SELECT nom, tema, nota
FROM alumnesNotes
WHERE nota BETWEEN 9 AND 10;

SELECT nom, tema, nota
FROM alumnesNotes
WHERE nota >= 9 AND nota <= 10;


-- 14. Nom de cada tema i la seua nota mitjana, ordenada per nota mitjana, de la més alta a les més baixa.

SELECT tema, AVG(nota)
FROM alumnesNotes
GROUP BY tema
ORDER BY AVG(nota) DESC;

SELECT tema, AVG(nota) AS mitjana
FROM alumnesNotes
GROUP BY tema
ORDER BY mitjana DESC;



-- 1. Nombres de alumnos, sin duplicados.
-- 2. Notas (tema y nota) del alumno cuyo nombre es "Elena".
-- 3. Nota media de todos los exámenes.
-- 4. Nota media de los exámenes del Tema 2.
-- 5. Nota media de los exámenes de los alumnos cuyo nombre empieza por "C".
-- 6. Nota media de cada examen, ordenada por tema.
-- 7. Nota media de cada alumno, ordenada por nombre, de la Z a la A.
-- 8. Nota media de los alumnos cuya media es un suspenso.
-- 9. Notas del tema 1 y del tema 2.
-- 10. Nota más alta.
-- 11. Nombre de alumno y de tema, para los exámenes de los que no haya nota.
-- 12 y 13. Nombre de alumno, de tema y nota, para los exámenes con notas entre 9 y 10 (de 2 formas distintas).
-- 14. Nombre de cada tema y su nota media, ordenada por nota media, de la más alta a las más baja.
