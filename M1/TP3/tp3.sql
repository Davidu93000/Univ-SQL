-- I - Création de tables et de types

-- 1
drop type adresse_type force;
create type adresse_type as object(
    num_rue    number,
    nom_rue    varchar2(255),
    nom_ville    varchar2(255)
)
/

-- 2
drop type personne_type force;
create type personne_type as object(
    nom    varchar2(255),
    prenom    varchar2(255)
)
/

-- 3
drop type activite_type force;
create type activite_type as object(
    niveau    number,
    nom    varchar2(255),
    equipe    varchar2(255)
)
/

drop type cours_type force;
create type cours_type as object(
    num_cours    number,
    nom    varchar2(255),
    nbheures    number,
    annee    number
)
/

-- 4
drop table personnes cascade constraint;
create table personnes of personne_type(
    constraint pk_personnes primary key(nom,prenom)
)
/

drop table activites cascade constraint;
create table activites of activite_type(
    constraint pk_activites primary key(niveau,nom,equipe)
)
/

drop table cours cascade constraint;
create table cours of cours_type(
    constraint pk_cours primary key(num_cours)
)
/

-- II - Ajout et modification de données, requêtes

-- 1

-- les personnes
Insert into personnes Values (personne_type('Brisefer', 'Benoit'));
Insert into personnes Values (personne_type('Génial', 'Olivier'));
Insert into personnes Values (personne_type('Jourdan', 'Gil'));
Insert into personnes Values (personne_type('Spring', 'Jerry'));
Insert into personnes Values (personne_type('Tsuno', 'Yoko'));
Insert into personnes Values (personne_type('Lebut', 'Marc'));
Insert into personnes Values (personne_type('Lagaffe', 'Gaston'));
Insert into personnes Values (personne_type('Dubois', 'Robin'));
Insert into personnes Values (personne_type('Walthéry', 'Natacha'));
Insert into personnes Values (personne_type('Danny', 'Buck'));
-- les cours
Insert into cours Values (cours_type(1,'Réseau',15,1));
Insert into cours Values (cours_type(2,'Sgbd',30,1));
Insert into cours Values (cours_type(3,'Programmation',15,1));
Insert into cours Values (cours_type(4,'Sgbd',30,2));
Insert into cours Values (cours_type(5,'Analyse',60,2));
-- les activites
Insert into activites Values(activite_type(1,'Mini foot','Amc Indus'));
Insert into activites Values(activite_type(1,'Surf','Les planchistes ...'));
Insert into activites Values(activite_type(2,'Tennis','Ace Club'));
Insert into activites Values(activite_type(3,'Tennis','Ace Club'));
Insert into activites Values(activite_type(1,'Volley ball','Avs80'));
Insert into activites Values(activite_type(2,'Mini foot','Les as du ballon'));
Insert into activites Values(activite_type(2,'Volley ball','smash'));

-- 2
select * from user_tables;
select * from user_object_tables;

-- 3
-- Liste des cours avec toutes les informations associées
select * from cours;

-- Nombre d’équipe par activité
select * from activites;
select nom,count(equipe) as nb_equipe from activites group by nom;

-- Liste des cours dont le nombre d’heures est supérieure ou égale à 25
select * from cours where nbheures >= 25;

-- 4
insert into activites values(activite_type(1,'Ski','Ace Club'));
select * from activites;

-- 5
update activites set niveau = 3 where equipe = 'Avs80' and nom = 'Volley ball';
select * from activites;

-- III - Héritage

-- 1
drop table personnes cascade constraints;
drop type personne_type force;
create type personne_type as object(
    id    number,
    nom    varchar2(255),
    prenom    varchar2(255)
)
NOT FINAL
/

-- 2
drop type eleve_type validate;
create type eleve_type under personne_type(
    date_naissance    date,
    poids    number,
    annee    number,
    adresse    adresse_type
)
/

drop type professeur_type validate;
create type professeur_type under personne_type(
    specialite    varchar2(255),
    date_entree    date,
    der_prom    date,
    salaire_base    number,
    salaire_actuel    number
)
/

-- 3

drop type eleve_type validate;
create type eleve_type under personne_type(
    date_naissance    date,
    poids    number,
    annee    number,
    adresse    adresse_type
)
/

-- 4


drop table eleves cascade constraint;
create table eleves of eleve_type(
    constraint ck_eleves_poids check(poids > 0),
    constraint ck_eleves_annee check(annee > 0)
)
/

drop table professeurs cascade constraint;
create table professeurs of professeur_type(
    constraint ck_professeurs_salaire check(salaire_base >= 0 and salaire_base <= salaire_actuel)
)
/

-- 5

-- 6

-- 7

select * from professeurs;

























