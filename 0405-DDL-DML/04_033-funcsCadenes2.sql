-- A partir de les dades de països, has de mostrar:

-- Noms, completats amb punts suspensius per la dreta fins a una amplària de 40 caràcters.

SELECT RPAD(name, 40, '.') FROM country;

-- Continents, alineats a la dreta a una amplària de 25 caràcters (emplenant amb espais si és necessari).

SELECT LPAD(continent, 25, ' ') FROM country;

SELECT LPAD(continent, 25) FROM country;

-- Noms locals (LocalName), sense espais en blanc inicials ni finals

SELECT RTRIM(LTRIM((localName)) FROM country;

SELECT TRIM(localName) FROM country;
