.open jocs

CREATE TABLE jocs(
    id VARCHAR(5) PRIMARY KEY,
    nom VARCHAR(30), 
    plataforma VARCHAR(30), 
    valoracio VARCHAR(3)
);

INSERT INTO jocs VALUES('11111','Ace attorney','switch','85');
INSERT INTO jocs VALUES('22222','Octopath traveler','switch','90');

SELECT * FROM jocs;
