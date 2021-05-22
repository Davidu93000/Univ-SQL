set serveroutput on;

-- I - CONTRAINTES

-- La note d'un étudiant doit être comprise entre 0 et 20. OK
alter table resultats add constraint ck_resultats_points check(points between 0 and 20);

-- Le sexe d'un étudiant doit être dans la liste: 'm', 'M', 'f', 'F' ou Null. OK
alter table eleves add constraint ck_eleves_sexe check(sexe in ('f','F','M','m') or sexe is null);

-- Le salaire de base d’un professeur doit être inférieur au salaire actuel et salaire de base doit être positif ou nul. OK
alter table professeurs add constraint ck_professeurs_salaire check(salaire_base >= 0 and salaire_base <= salaire_actuel);

-- II - TRIGGERS

-- 1 OK
drop trigger trigger_salaire_baisse;
create trigger trigger_salaire_baisse before update on professeurs for each row
declare
    salaire_baisse    exception;
begin
    if updating('salaire_actuel') then
        -- le salaire baisse si l'ancien salaire est plus grand que le nouveau salaire
        if :new.salaire_actuel < :old.salaire_actuel then
            raise salaire_baisse;
        end if;
    end if;
exception when salaire_baisse then
    raise_application_error('-20000','Erreur le salaire à diminué !');
end;
/

-- 2 OK

drop table prof_specialite cascade constraints;
-- nb_professeurs doit être > 0 et on ne peut y avoir deux fois la même spécialité dans la table donc spécialite doit être clé primaire
create table prof_specialite(
    specialite    varchar2(20),
    nb_professeurs    number constraint ck_pro_specialite_nb check(nb_professeurs > 0),
    constraint pk_prof_specialite primary key(specialite)
);

drop trigger trigger_prof_specialite;

create trigger trigger_prof_specialite after insert or update or delete on professeurs for each row
declare
    v_nb_professeurs    number;
    v_specialite    varchar2(20);
begin
    if inserting then
        v_specialite := :new.specialite;
        select nb_professeurs into v_nb_professeurs from prof_specialite where upper(specialite) = upper(:new.specialite);
        -- on incrémente nb_prof pour la nouvelle spécialité
        update prof_specialite set nb_professeurs = v_nb_professeurs + 1 where upper(specialite) = upper(:new.specialite);
    end if;
    if updating('specialite') then
        v_specialite := :new.specialite;
        select nb_professeurs into v_nb_professeurs from prof_specialite where upper(specialite) = upper(:old.specialite);
        -- il y'a au moins deux professeurs de l'ancienne spécialité on peut décrémenter nb_prof
        if v_nb_professeurs > 1 then
            update prof_specialite set nb_professeurs = v_nb_professeurs - 1 where upper(specialite) = upper(:old.specialite);
        -- il n'y a qu'un seul professeur de l'ancienne spécialité (nb_prof = 1), si on décrémente nb_prof, on a nb_prof = 0 donc on supprime la ligne
        else
            delete from prof_specialite where upper(specialite) = upper(:old.specialite);
        end if;
        select nb_professeurs into v_nb_professeurs from prof_specialite where upper(specialite) = upper(:new.specialite);
        -- on incrémente nb_prof pour la nouvelle spécialité
        update prof_specialite set nb_professeurs = v_nb_professeurs + 1 where upper(specialite) = upper(:new.specialite);
    end if;
    if deleting then
        v_specialite := :old.specialite;
        select nb_professeurs into v_nb_professeurs from prof_specialite where upper(specialite) = upper(:old.specialite);
        -- il y'a au moins deux professeurs de cette spécialité on peut décrémenter nb_prof
        if v_nb_professeurs > 1 then
            update prof_specialite set nb_professeurs = v_nb_professeurs - 1 where upper(specialite) = upper(:old.specialite);
        -- il n'y a qu'un seul professeur de cette spécialité (nb_prof = 1), si on décrémente nb_prof, on a nb_prof = 0 donc on supprime la ligne
        else
            delete from prof_specialite where upper(specialite) = upper(:old.specialite);
        end if;
    end if;
exception when No_Data_Found then
    -- cas ou la nouvelle spécialité n'est pas dans la table, il faut la créer
    insert into prof_specialite values(v_specialite,1);
end;
/

-- EXEMPLES
-- inserting
insert into professeurs values(9,'Bonjour','SQL',null,null,2000000,3000000);
insert into professeurs values(10,'Hello','SqL',null,null,2000000,5000000);
insert into professeurs values(11,'Dupont','Chimie',null,null,2000000,5000000);
insert into professeurs values(12,'David','Web',null,null,2000000,5000000);
select * from professeurs order by num_prof;
select * from prof_specialite;

-- updating
-- modification sur un professeurs qui n'existe pas (ca ne fait rien)
update professeurs set specialite = 'POO' where num_prof = 100;
select * from professeurs order by num_prof;
select * from prof_specialite;
-- cas 1 modification sur une autre colonne que spécialité OK (ca ne fait rien)
update professeurs set salaire_actuel = salaire_actuel + 1000 where num_prof = 11;
select * from professeurs order by num_prof;
select * from prof_specialite;
-- cas 2 modification d'une spécialité vers un autre déjà existant (sans suppression) OK
update professeurs set specialite = 'chimie' where num_prof = 10;
select * from professeurs order by num_prof;
select * from prof_specialite;
-- cas 3 modification d'une spécialité vers un autre déjà existant (avec suppression) OK (plus de sql)
update professeurs set specialite = 'sql' where num_prof = 12;
select * from professeurs order by num_prof;
select * from prof_specialite;
-- cas 4 modification d'une spécialité vers une nouvelle spécialité (sans suppression et insertion nouvelle spécialité) OK (ajout nouvelle spécialité WEB)
update professeurs set specialite = 'WEB' where num_prof = 11;
select * from professeurs order by num_prof;
select * from prof_specialite;
-- cas 5 modification d'une spécialité vers une nouvelle spécialité (avec suppression et insertion nouvelle spécialité) OK (ajout nouvelle spécialité POO et suppression de chimie)
update professeurs set specialite = 'POO' where num_prof = 10;
select * from professeurs order by num_prof;
select * from prof_specialite;

-- deleting
delete from professeurs where num_prof = 9 or num_prof = 10;
select * from professeurs order by num_prof;
select * from prof_specialite;

-- 3 OK

drop trigger trigger_charge;
create trigger trigger_charge after update or delete on professeurs for each row
declare
    v_num_prof    number;
    cursor cursor_charge is select * from charge;
begin
    if updating('num_prof') then
        v_num_prof := :new.num_prof;
        -- on parcours la table charge
        for rec_charge in cursor_charge loop
            -- lorsqu'on trouve l'ancien num_prof
            if rec_charge.num_prof = :old.num_prof then
                -- on le change par son nouveau num_prof
                update charge set num_prof = v_num_prof where num_prof = :old.num_prof;
            end if;
        end loop;
    end if;
    if deleting then
         -- on parcours la table charge
        for rec_charge in cursor_charge loop
            -- lorsqu'on trouve l'ancien num_prof
            if rec_charge.num_prof = :old.num_prof then
                -- on le supprime
                delete from charge where num_prof = :old.num_prof;
            end if;
        end loop;
    end if;
end;
/

-- TESTE DU TRIGGER
-- updating
-- modification d'un professeur qui n'existe pas OK (ca ne fait rien)
update professeurs set num_prof = 1001 where num_prof = 100;
select * from professeurs order by num_prof;
select * from charge order by num_prof;
-- cas 1 modification sur une autre colonne que num_prof OK (ca ne fait rien)
update professeurs set salaire_actuel = salaire_actuel + 1000 where num_prof = 11;
select * from professeurs order by num_prof;
select * from charge order by num_prof;
-- cas 2 modification d'un num_prof qui existe
update professeurs set num_prof = 13 where num_prof = 1;
select * from professeurs order by num_prof;
select * from charge order by num_prof;

-- deleting
-- prof n'existe pas (ca ne fait rien)
delete from professeurs where num_prof = 100;
select * from professeurs order by num_prof;
select * from charge order by num_prof;
-- supprime un professeur qui existe => on supprime tous les cours ou il était en charge
delete from professeurs where num_prof = 2;
select * from professeurs order by num_prof;
select * from charge order by num_prof;

-- 4 OK & ne fonctionne pas sur oracle (à voir avec sqlplus)

drop table audit_resultats cascade constraints;
create table audit_resultats(
    utilisateur    varchar2(50),
    date_maj    date,
    desc_maj    varchar2(50),
    num_eleve    number(4),
    num_cours    number(4),
    points    number
);

drop trigger trigger_audit_resultats;
create trigger trigger_audit_resultats after insert or update or delete on resultats for each row
declare
    v_desc    varchar2(255);
begin
    if inserting then
        v_desc := 'INSERT';
        insert into audit_resultats values(user,sysdate,v_desc,:new.num_eleve,:new.num_cours,:new.points);
    end if;
    if updating then
        v_desc := 'UPDATE';
        if updating('num_eleve') then
            v_desc := v_desc || ' num_eleve';
        end if;
        if updating('num_cours') then
            v_desc := v_desc || ' num_cours';
        end if;
        if updating('points') then
            v_desc := v_desc || ' points';
        end if;
        insert into audit_resultats values(user,sysdate,v_desc,:new.num_eleve,:new.num_cours,:new.points);
    end if;
    if deleting then
        v_desc := 'DELETE';
        insert into audit_resultats values(user,sysdate,v_desc,:new.num_eleve,:new.num_cours,:new.points);
    end if;
end;
/

select * from resultats order by num_eleve;
select * from audit_resultats;

-- inserting
insert into resultats values(100,100,20);
select * from resultats order by num_eleve;
select * from audit_resultats;
-- updating
update resultats set num_eleve = 100, points = 18 where num_eleve = 1 and num_cours = 1;
select * from resultats order by num_eleve;
select * from audit_resultats;
-- deleting
delete from resultats where num_eleve = 100 and num_cours = 100;
select * from resultats order by num_eleve;
select * from audit_resultats;

-- 5

drop trigger confidentialite;
create trigger confidentialite before update on professeurs for each row
declare
    v_salaire    number;
    exception_utilisateur    exception;
begin 
    if updating('salaire_actuel') then
        v_salaire := :old.salaire_actuel + (:old.salaire_actuel * 20 / 100);
        if :new.salaire_actuel > v_salaire then
            if user != 'GrandChef' then
                raise exception_utilisateur;
            else
                dbms_output.put_line('Bonjour GrandChef');
            end if;
        end if;
    end if;
exception when exception_utilisateur then raise_application_error(-20002,'Modification interdite !');
end;
/

select * from professeurs order by num_prof;
update professeurs set salaire_actuel = salaire_actuel + 1000000 where num_prof = 1;
select * from professeurs order by num_prof;
update professeurs set salaire_actuel = salaire_actuel + 500000 where num_prof = 1;
select * from professeurs order by num_prof;

-- III - FONCTIONS ET PROCÉDURES

-- Créez une fonction fn_moyenne calculant la moyenne d’un étudiant passé en paramètre. OK
drop function fn_moyenne;
create function fn_moyenne(id in eleves.num_eleve%type) return number is
        v_moyenne_points resultats.points%type;
    begin
        select avg(points) into v_moyenne_points from resultats where num_eleve = id;
        return v_moyenne_points;
    exception when No_data_found then return null;
    end;
/

-- Créez une procédure pr_resultat permettant d’afficher la moyenne de chaque élève avec la mention adéquate : échec, passable, assez bien, bien, très bien. OK
drop procedure pr_resultat;
create procedure pr_resultat is
    v_message    varchar2(255);
    v_moyenne    number;
    cursor cursor_eleves is select num_eleve from eleves;
begin
    for rec_eleves in cursor_eleves loop
        v_moyenne := fn_moyenne(rec_eleves.num_eleve);
        if v_moyenne is not null then
            v_message := 'Éleve ' || rec_eleves.num_eleve || ' moyenne : ' || v_moyenne;
            if v_moyenne between 0 and 8 then
                v_message := v_message || ' échec.';
            elsif v_moyenne between 8 and 10 then
                v_message := v_message || ' passable.';
            elsif v_moyenne between 10 and 13 then
                v_message := v_message || ' assez bien.';
            elsif v_moyenne between 13 and 15 then
                v_message := v_message || ' bien.';
            else
                v_message := v_message || ' très bien.';
            end if;
            dbms_output.put_line(v_message);
        else
            dbms_output.put_line('Éleve ' || rec_eleves.num_eleve || ' a pas de notes !');
        end if;
    end loop;
end pr_resultat;
/

-- Créez un package contenant ces fonction et procédures. OK

-- package
drop package package_moyenne;
create package package_moyenne is
    function fn_moyenne(id in eleves.num_eleve%type) return number;
    procedure pr_resultat;
end package_moyenne;
/

-- package body
drop package body package_moyenne;
create package body package_moyenne is
    function fn_moyenne(id in eleves.num_eleve%type) return number is
        v_moyenne_points resultats.points%type;
    begin
        select avg(points) into v_moyenne_points from resultats where num_eleve = id;
        return v_moyenne_points;
    exception when No_data_found then return null;
    end;
    
    procedure pr_resultat is
        v_message    varchar2(255);
        v_moyenne    number;
        cursor cursor_eleves is select num_eleve from eleves;
    begin
        for rec_eleves in cursor_eleves loop
            v_moyenne := fn_moyenne(rec_eleves.num_eleve);
            if v_moyenne is not null then
                v_message := 'Éleve ' || rec_eleves.num_eleve || ' moyenne : ' || v_moyenne;
                if v_moyenne between 0 and 8 then
                    v_message := v_message || ' échec.';
                elsif v_moyenne between 8 and 10 then
                    v_message := v_message || ' passable.';
                elsif v_moyenne between 10 and 13 then
                    v_message := v_message || ' assez bien.';
                elsif v_moyenne between 13 and 15 then
                    v_message := v_message || ' bien.';
                else
                    v_message := v_message || ' très bien.';
                end if;
                dbms_output.put_line(v_message);
            else
                dbms_output.put_line('Éleve ' || rec_eleves.num_eleve || ' a pas de notes !');
            end if;
        end loop;
    end pr_resultat;
end package_moyenne;
/

-- teste les fonctions/procedures du package
begin
    pr_resultat;
    package_moyenne.pr_resultat;
end;
/