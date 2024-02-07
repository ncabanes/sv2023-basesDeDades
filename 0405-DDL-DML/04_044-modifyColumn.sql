-- Amplia la grandària del nom de plataforma de 25 a 30 lletres.

-- En Oracle, no disponible en SQLite

ALTER TABLE plataf0 MODIFY (nom VARCHAR2(30));
