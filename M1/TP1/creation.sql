drop table utilisateurs cascade constraints;
drop table amis cascade constraints;
drop table couples cascade constraints;
drop table pages cascade constraints;
drop table creer cascade constraints;
drop table contient cascade constraints;
drop table publications cascade constraints;
drop table publier cascade constraints;
drop table messages cascade constraints;
drop table envoyer cascade constraints;
drop table aimerPage cascade constraints;
drop table aimerPublication cascade constraints;
drop table groupes cascade constraints;
drop table possede cascade constraints;
drop table rejoindre cascade constraints;

create table utilisateurs(
    id    number,
    pseudo    varchar2(255)    constraint nn_utilisateurs_pseudo not null,
    mdp    varchar2(255)    constraint nn_utilisateurs_mdp not null,
    prenom    varchar2(255),
    nom    varchar2(255),
    mail    varchar2(255),
    telephone    varchar2(10),
    dateNaissance    date,
    sexe    char(1)    check (sexe in ('F','M')),
    pays    varchar2(255)    constraint nn_utilisateurs_pays not null,
    ville    varchar2(255)    constraint nn_utilisateurs_ville not null,
    dateInscription    date    constraint nn_utilisateurs_inscription not null,
    dateFermeture    date,
    constraint pk_utilisateurs primary key (id),
    constraint ck_utilisateurs_date check (dateFermeture > dateInscription and dateInscription > dateNaissance)
);

create table amis(
    id    number,
    id2    number,
    dateDebut    date constraint nn_amis_date not null,
    constraint pk_amis primary key (id,id2),
    constraint fk_amis_id_utilisateurs foreign key (id) references utilisateurs,
    constraint ck_amis check (id != id2)
);

create table couples(
    id    number,
    id2    number,
    dateDebut    date constraint nn_couples_date not null,
    constraint pk_couples primary key (id,id2),
    constraint fk_couples_id_utilisateurs foreign key (id) references utilisateurs,
    constraint ck_couples check (id != id2)
);

create table pages(
    idPage    number,
    typePage    varchar(8)    constraint ck_pages_typepage check (typePage in ('publique','privée')),
    nbLike    number    constraint ck_pages_nblike check (nbLike >= 0),
    constraint pk_pages primary key (idPage)
);

create table creer(
    id    number,
    idPage    number,
    constraint pk_creer primary key (id,idPage),
    constraint fk_creer_utilisateurs foreign key (id) references utilisateurs,
    constraint fk_creer_pages foreign key (idPage) references pages
);

create table contient(
    idPage    number,
    idPublication    number,
    constraint pk_contient primary key (idPublication,idPage)
);

create table publications(
    idPublication    number,
    titre    varchar2(255)    constraint nn_publications_titre not null,
    datePublication    date    constraint nn_publications_date not null,
    texte    varchar2(255),
    nbLike    number    constraint ck_publications_nblike check (nbLike >= 0),
    constraint pk_publications primary key (idPublication)
);


create table publier(
    id    number,
    idPublication    number,
    constraint pk_publier primary key (id,idPublication),
    constraint fk_publier_utilisateurs foreign key (id) references utilisateurs,
    constraint fk_publier_publications foreign key (idPublication) references publications
);

create table messages(
    idMsg    number,
    texte    varchar2(255),
    dateEnvoie    date,
    constraint pk_messages primary key (idMsg)
);

create table envoyer(
    id    number,
    idMsg    number,
    constraint pk_envoyer primary key (id,idMsg),
    constraint fk_envoyer_utilisateurs foreign key (id) references utilisateurs,
    constraint fk_envoyer_messages foreign key (idMsg) references messages
);

create table aimerPage(
    id    number,
    idPage    number,
    constraint pk_aimerpage primary key (id,idPage),
    constraint fk_aimerpage_utilisateurs foreign key (id) references utilisateurs,
    constraint fk_aimerpage_pages foreign key (idPage) references pages
);

create table aimerPublication(
    id    number,
    idPublication    number,
    constraint pk_aimerpublication primary key (id,idPublication),
    constraint fk_aimerpublication_utilisateurs foreign key (id) references utilisateurs,
    constraint fk_aimerpublication_publications foreign key (idPublication) references publications
);

create table groupes(
    idGroupe    number,
    nom    varchar2(255)    constraint nn_groupes_nom not null,
    constraint pk_groupes primary key (idGroupe)
);

create table possede(
    idPage    number,
    idGroupe    number,
    constraint pk_possede primary key (idPage,idGroupe),
    constraint fk_possede_pages foreign key (idPage) references pages,
    constraint fk_possede_groupes foreign key (idGroupe) references groupes
);

create table rejoindre(
    id    number,
    idGroupe    number,
    constraint pk_rejoindre primary key (id,idGroupe),
    constraint fk_rejoindre_utilisateurs foreign key (id) references utilisateurs,
    constraint fk_rejoindre_groupes foreign key (idGroupe) references groupes
);
