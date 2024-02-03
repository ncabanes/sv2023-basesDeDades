-- A partir de les taules "country" i "countrylanguage", mostra:

-- 1. Noms d'idiomes del món, sense duplicats, ordenats.

SELECT DISTINCT language
FROM countryLanguage
ORDER BY language;

-- 2. Quantitat d'idiomes (diferents) del món

SELECT COUNT(DISTINCT language)
FROM countryLanguage;

-- 3. Noms d'idiomes del món, juntament amb el nom del país 
-- en què es parlen, per als idiomes que comencen per G però
-- que es parlen en països que no comencen per G.

-- Previ: idiomes i països

-- Variant amb WHERE

SELECT countryLanguage.language, country.name
FROM countryLanguage, country 
WHERE countryLanguage.countryCode = country.code;

-- Variant amb JOIN

SELECT countryLanguage.language, country.name
FROM countryLanguage 
	JOIN country 
	ON countryLanguage.countryCode = country.code;

-- Resposta amb WHERE

SELECT countryLanguage.language, country.name
FROM countryLanguage, country 
WHERE countryLanguage.countryCode = country.code
AND countryLanguage.language LIKE 'G%'
AND country.name NOT LIKE 'G%';

-- Resposta amb JOIN

SELECT countryLanguage.language, country.name
FROM countryLanguage 
	JOIN country 
	ON countryLanguage.countryCode = country.code
WHERE countryLanguage.language LIKE 'G%'
AND country.name NOT LIKE 'G%';

-- 4. Nom dels països en els quals es parlen els idiomes anomenats 
-- "Chokwe" o "Berberi", usant "OR".

SELECT country.name
FROM countryLanguage 
	JOIN country 
	ON countryLanguage.countryCode = country.code
WHERE language = 'Chokwe' OR language = 'Berberi';

-- 5. Nom dels països en els quals es parlen els idiomes anomenats 
-- "Chokwe" o "Berberi", usant "IN".

SELECT country.name
FROM countryLanguage 
	JOIN country 
	ON countryLanguage.countryCode = country.code
WHERE language IN ('Chokwe', 'Berberi');


-- 6. Nom i quantitat de parlants dels idiomes de "Andorra" 
-- (pista: pots saber la quantitat de parlants multiplicant 
-- la població (population) del país pel percentatge (percentage) 
-- d'eixe idioma, i dividint entre 100.

SELECT language, population * percentage / 100 AS parlants
FROM countryLanguage 
	JOIN country 
	ON countryLanguage.countryCode = country.code
WHERE country.name = 'Andorra';


-- 7. Nom de l'idioma més parlat a Polònia (Poland), usant MAX i una subconsulta.
-- 8. Nom de l'idioma més parlat a Polònia (Poland), usant ORDER BY i LIMIT.


SELECT language
FROM countryLanguage 
	JOIN country 
	ON countryLanguage.countryCode = country.code
WHERE name = 'Poland'
ORDER BY percentage DESC
LIMIT 1;

-- 9. Noms dels països en els quals es parla l'idioma més parlat a Polònia.
-- 10. Nom de país, idioma i percentatge, per als països en els quals es parla algun dels idiomes parlats a Qatar.
-- 11. Nom de país, nom de ciutat i població de la ciutat, per a les ciutats que es troben en països en els quals es parla l'idioma "Romani", ordenades per país (ascendent) i població (descendent). Enllaça les taules usant WHERE.
-- 12. Nom de país, nom de ciutat i població de la ciutat, per a les ciutats que es troben en països en els quals es parla l'idioma "Romani", ordenades per país (ascendent) i població (descendent). Enllaça les taules usant JOIN.


-- ---------------------------------------------------------

-- A partir de las tablas "country" y "countrylanguage", muestra:

-- 1. Nombres de idiomas del mundo, sin duplicados, ordenados.
-- 2. Cantidad de idiomas (distintos) del mundo
-- 3. Nombres de idiomas del mundo, junto con el nombre del país en que se hablan, para los idiomas que comienzan por G pero que se hablan en paises que no comienzan por G.
-- 4. Nombre de los países en los que se hablan los idiomas llamados "Chokwe" o "Berberi", usando "OR".
-- 5. Nombre de los países en los que se hablan los idiomas llamados "Chokwe" o "Berberi", usando "IN".
-- 6. Nombre y cantidad de hablantes de los idiomas de "Andorra" (pista: puedes saber la cantidad de hablantes multiplicando la población (population) del país por el porcentaje (percentage) de ese idioma, y dividiendo entre 100.
-- 7. Nombre del idioma más hablado en Polonia (Poland), usando MAX y una subconsulta.
-- 8. Nombre del idioma más hablado en Polonia (Poland), usando ORDER BY y LIMIT.
-- 9. Nombres de los países en los que se habla el idioma más hablado en Polonia.
-- 10. Nombre de país,idioma y porcentaje, para los países en los que se habla alguno de los idiomas hablados en Qatar.
-- 11. Nombre de país, nombre de ciudad y población de la ciudad, para las ciudades que se encuentran en países en los que se habla el idioma "Romani", ordenadas por país (ascendente) y poblacion (descendente). Enlaza las tablas usando WHERE.
-- 12. Nombre de país, nombre de ciudad y población de la ciudad, para las ciudades que se encuentran en países en los que se habla el idioma "Romani", ordenadas por país (ascendente) y poblacion (descendente). Enlaza las tablas usando JOIN.
