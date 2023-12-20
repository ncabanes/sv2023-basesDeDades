.open jocsV1

-- Jocs posteriors a l'any 2000

SELECT * FROM jocs WHERE any_ll > 2000;

-- Jocs de l'any 1997 o anteriors

SELECT * FROM jocs WHERE any_ll <= 1997;

-- Jocs la plataforma dels quals no siga "*ps4"

SELECT * FROM jocs WHERE plataforma <> 'ps4';


-- =========================

-- Jocs de l'any 1997 o anteriors, no usant l'operador <=, sinó AND

SELECT * FROM jocs WHERE any_ll = 1997
    OR any_ll < 1997;

-- Jocs de PS4 de l'any 2022

SELECT * 
FROM jocs 
WHERE plataforma = 'ps4'
    AND any_ll = 2022;


-- =========================

-- Jocs entre 2010 i 2020, de dues maneres diferents

SELECT nom, plataforma 
FROM jocs
WHERE any_ll >= 2010 AND any_ll <= 2020;

SELECT nom, plataforma 
FROM jocs
WHERE any_ll BETWEEN 2010 AND 2020;

-- =========================

-- Jocs de qualsevol plataforma Playstation 
-- (el codi de la plataforma comença per "*ps")

SELECT *
FROM jocs
WHERE plataforma LIKE 'ps%';


-- =========================

-- Afig dos jocs sense plataforma (en dos formats diferents)

INSERT INTO jocs VALUES ('tloz', 'The legend of Zelda', NULL, NULL);

INSERT INTO jocs (codi, nom) VALUES ('mg', 'Magic, the Gathering');

-- Mostra els jocs per als quals no s'ha indicat plataforma

SELECT *
FROM jocs
WHERE plataforma IS NULL;
