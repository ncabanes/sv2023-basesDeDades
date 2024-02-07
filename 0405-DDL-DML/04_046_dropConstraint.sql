-- En la taula de jocs, elimina la clau aliena.

-- En Oracle, no disponible en SQLite

ALTER TABLE jocs DROP CONSTRAINT fk_jocs_plataformes;
