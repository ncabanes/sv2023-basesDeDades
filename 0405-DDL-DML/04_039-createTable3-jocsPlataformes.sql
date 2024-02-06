-- Crea una nova versió de les taules Plataformes i Jocs, amb els canvis:
-- 
-- El nom de plataforma ha de ser únic.
-- El codi de joc ha d'estar en majúscules
-- L'espai ocupat ha de ser inferior o igual a 500
 
CREATE TABLE plataformes(
    codi CHAR(4),
    nom VARCHAR2(25) NOT NULL,
    CONSTRAINT pk_plataformes PRIMARY KEY (codi),
    CONSTRAINT ck_plataformes UNIQUE(nom),
);

CREATE TABLE Jocs(
    codi CHAR(5),
    nom VARCHAR2(50) NOT NULL, 
    descripcion VARCHAR2(1000), 
    dataLlan DATE,
    espaiOcupat NUMBER(7,3),
    codiPlataforma CHAR(4),
    CONSTRAINT pk_jocs PRIMARY KEY(codi),
    CONSTRAINT ck_jocs_codi CHECK(codi = UPPER(codi)),
    CONSTRAINT ck_jocs_espaiOcupat CHECK(espaiOcupat <= 500),
    CONSTRAINT fk_jocs_plataformes FOREIGN KEY(codiPlataforma)
        REFERENCES plataformes(codi)   
);
