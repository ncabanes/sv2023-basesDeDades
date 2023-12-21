-- Exercici 04.004

CREATE TABLE estudiants ( 
  nia NUMERIC(10) PRIMARY KEY, 
  nom VARCHAR(25), 
  cognoms VARCHAR(50), 
  email VARCHAR(100)
); 

INSERT INTO estudiants VALUES (23, 'Michael', 'Jordan', 'michael@jordan.com');
INSERT INTO estudiants VALUES (32, 'Earvin', 'Johnson', 'magic@johnson.com');
INSERT INTO estudiants VALUES (34, 'Hakeem', 'Olajuwon', 'hakeem@olaju.com');

INSERT INTO estudiants VALUES (11, 'Isaiah', 'Thomas', NULL);
INSERT INTO estudiants (nia, nom, cognoms) VALUES (33, 'Larry', 'Bird');
INSERT INTO estudiants (nom, cognoms, nia) VALUES ('Dominique', 'Wilkins', 21);
