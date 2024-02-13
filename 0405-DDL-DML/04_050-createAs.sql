-- Crea una taula de còpia de seguretat de jocs, bolcant a ella el contingut de l'original.

create table copiaJocs as select * from jocs;

-- Crea una taula amb els noms de les plataformes dels jocs el nom dels quals comença per P

create table plataformesP as
select nom from plataformes
where upper(codi) like 'P%';

select * from plataformesP;
