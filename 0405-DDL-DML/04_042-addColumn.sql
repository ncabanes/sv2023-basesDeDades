-- Afig un camp "anyDeLlancament" (número de 4 xifres) a la taula plataf0

-- Oracle

ALTER TABLE plataf0 ADD( anyDeLlancament NUMBER(4) );

-- SQLite

ALTER TABLE plataf0 ADD COLUMN anyDeLlancament NUMBER(4);
