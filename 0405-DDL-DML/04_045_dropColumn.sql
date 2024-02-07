-- En la taula de jocs, elimina el camp de la data de llançament

-- Oracle

ALTER TABLE plataf0 DROP (anyLlancament);

-- SQLite

ALTER TABLE plataf0 DROP COLUMN anyLlancament;
