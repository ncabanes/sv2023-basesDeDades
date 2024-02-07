-- En la taula de jocs, l'any ha de ser posterior a 1975.

-- En Oracle; ADD CONSTRAINT no disponible en SQLite

ALTER TABLE jocs ADD (anyLlancament NUMBER(4));

ALTER TABLE jocs
ADD CONSTRAINT ck_jocs_anyLlancament CHECK(anyLlancament>1975)
