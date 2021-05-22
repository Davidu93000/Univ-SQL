select * from utilisateurs;
select count(distinct pays) as Nombre_Pays from utilisateurs;
select * from utilisateurs where pays = 'Brésil';
select ville,count(*) as Nombre_utilisateurs from utilisateurs where pays = 'France' group by ville;
select * from utilisateurs where (extract(year from dateInscription)) between 2010 and 2017;
select * from publications where (nbLike > 100) and (length(texte) < 100);
select id2,dateDebut from (amis join utilisateurs using(id)) where pseudo = 'Kevin69' order by dateDebut;
select id,count(*) as Nombre_Amis from (amis join utilisateurs using(id)) where ville = 'Londres' group by id;*/
-- Quel groupe a le plus de membres ?
drop view nombre_membres;
create view nombre_membres(nb_membres) as select count(*) as nb_membres from rejoindre group by idGroupe;
select max(nb_membres) as max_membres from nombre_membres;
-- Dans le groupe «Flat Earth Society» y a-t-il plus d’hommes ou de femmes ? OK (tester avec un utilisateur sexe = null)
drop view nombre_sexe_flat_earth;
create view nombre_sexe_flat_earth(sexe,nb_membres) as select sexe,count(*) as nb_membres from ((rejoindre join utilisateurs using(id)) join groupes using(idGroupe)) where groupes.nom='Flat Earth Society' group by sexe;
select sexe from nombre_sexe_flat_earth where nb_membres = (select max(nb_membres) from nombre_sexe_flat_earth);

-- 11
select idPage, avg(sumlike) from publications natural join (select idPublication, count(*) as sumlike from aimerPublication group by idPublication) natural join pages having avg(sumlike)>5 group by (idPage);

-- 12
select publications.idPublication, publications.idpage, publications.nbLike from publications join (select idPage, max(nbLike) as maxlike from publications group by idPage) p on publications.idPage = p.idPage and publications.nbLike = p.maxlike;

-- 13
select * from pages where idpage in
(select idPage from (select count(*) as sumlike, id, idPublication from aimerPublication group by id,idPublication) a join groupes on a.id= groupes.idGroupe 
group by idPage having avg(sumlike)>5);

-- 14
select avg(length(texte)) as nb_mot from publications where texte like '%Trump%';

-- 15
select id from publications a where idPage IN(select idPage from publications b where (b.id IN(select amis.id from amis where amis.idamis = a.id) or  b.id IN(select amis.idamis from amis where amis.id = a.id) )) group by a.id having count(id)= (select count(distinct idPage) from publications where publications.id = a.id );

-- 16

-- 17
select id from aimerPublication where (id IN(select id2 from amis where id=1) or id IN(select id from amis where id2=1)) and idPublication IN (select idPublication from publications where id= (select id from utilisateurs where pseudo = 'Kevin69')) group by id having count(idPublication) = (select count(*) from publications group by id having id=1);

-- 18
select id from groupes where idPage IN(select idPage from groupes where id = (select id from utilisateurs where pseudo='Kevin69')) group by id having count(id) = (select count(*) from groupes id = (select id from utilisateurs where pseudo='Kevin69'));

-- 19
select id from amis a group by id having
(select count(*) from amis where id=(select id from utilisateurs where utilisateurs.id = a.id) or id2= (select id from utilisateurs where utilisateurs.id = a.id))
>=
(select count(*) from amis where id=(select id from utilisateurs where pseudo='Kevin69') or id2= (select id from utilisateurs where pseudo='Kevin69'));

-- Affichage des tables
select * from utilisateurs;
select * from amis;
select * from couples;
select * from pages;
select * from creer;
select * from contient;
select * from publications;
select * from publier;
select * from messages;
select * from envoyer;
select * from aimerPage;
select * from aimerPublication;
select * from groupes;
select * from possede;
select * from rejoindre;











