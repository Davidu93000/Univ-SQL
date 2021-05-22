ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';

insert into utilisateurs values(1,'toto','123456789','Laurent','Outan',null,null,null,'M','Belgique','Bruxelles','20-12-2012',null);
insert into utilisateurs values(2,'sam','00000','Sam','Soule','samsoul@mail.com',null,null,'M','Royaume-Uni','Llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch','12-12-2012',null);
insert into utilisateurs values(3,'user1149846549845121','iheaoidhaé_ç)çdv_q-à;','Denis','Chons','deuxnichons@hotmail.es',null,'28-07-1994','M','Espagne','Madrid','21-05-2014',null);
insert into utilisateurs values(4,'Ravioli','Italia','Spagetti','Pizza','tiramisu@pizza.com',null,'16-11-1989','M','Italie','Rome','12-09-2018',null);
-- Habitant à Londres (3)
insert into utilisateurs values(5,'BREXIT','BREXIT','Charles','Atten','charlatan@gmail.com','0123456789','01-04-1995','M','Royaume-Uni','Londres','01-04-2015',null);
insert into utilisateurs values(6,'Barrack','password','Barack','Afritt',null,null,null,'M','Royaume-Uni','Londres','01-01-2010',null);
insert into utilisateurs values(7,'user199532511223','mypass123456','Harry','Cover','haricotsverts@mail.uk','0612564597','14-07-2007','M','Royaume-Uni','Londres','14-07-2017',null);
-- Ville Française (7)
insert into utilisateurs values(8,'Kevin69','1234','Kevin','Alain','kevin69@mail.com','0123456789','20-11-2000','M','France','Lyon','30-01-2015',null);
insert into utilisateurs values(9,'Neymarlebest','PSGChampion','Jean','Nemar','jenaimare@mail.com',null,'01-01-2004','M','France','Paris','30-01-2018',null);
insert into utilisateurs values(10,'Tomaemma','motsdepassesecret','Emma','Tome','hematome@mail.fr',null,null,'F','France','Bezon','27-04-2018',null);
insert into utilisateurs values(11,'Alinterieur','interieur','Alain','Terrieur','alinterieur@mail.fr',null,'30-08-1990','M','France','Villetaneuse','30-03-2005',null);
insert into utilisateurs values(12,'Alexterieur','exterieur','Alex','Terrieur','alexterieur@mail.fr',null,'30-08-1993','M','France','Villetaneuse','30-03-2005',null);
insert into utilisateurs values(13,'GilesJ','MACRONdémission','Gilles','Éjaune','giléjaune@mail.fr',null,'30-08-2005','M','France','Paris','30-03-2015',null);
insert into utilisateurs values(14,'Founovu','bcli8P','Anne','Usse','anneusse@mail.fr',null,'19-12-2001','F','France','Montcuq','21-02-2015',null);
insert into utilisateurs values(15,'Founovu2','bcli8P','Jean','Khule','jeankhule@mail.fr',null,'19-12-1999','M','France','Montcuq','21-02-2015',null);
insert into utilisateurs values(16,'Kiaudet','AuogcdJrz25Y','Camille','Honette','camionette@mail.fr',null,'20-06-1998','F','France','Trécon','27-05-2017',null);
insert into utilisateurs values(17,'Riklezr','n4URsMmHDxFKGz','Jacques','Septelétermducontra','jacceptelestermesducontrats@mail.com',null,'13-05-2016','M','France','Vatan','19-11-2017',null);
-- Habitant au Brésil (5)
insert into utilisateurs values(18,'ronaldo','brazil','Yvan','Destruk',null,null,null,'M','Brésil','São Paulo','14-07-2017',null);
insert into utilisateurs values(19,'KI','4N€v€$KY72>@CP93xDB:SY}xw78}.5)cjQ]72D3c6s;Ld3usj','Kelly','Dio',null,null,null,'F','Brésil','Brasília','01-04-2014',null);
insert into utilisateurs values(20,'Jaipasdidéedepseudo','Jaipasdidéedemdpnonplus','Justin','Petipeu','justeunpetipeu@mail.com',null,'15-06-2000','M','Brésil','São Paulo','30-12-2018',null);
insert into utilisateurs values(21,'jeneparlepaslalangedoncjechoisisunpseudoécritenfrançais','Ordem e Progresso','Firmin','Peutageul','firminpeutagueule@gmail.com',null,'10-06-1992','M','Brésil','Salvador','20-03-2014',null);
insert into utilisateurs values(22,'Neymar','Ordem e Progresso','Sarah','Pelle','sarapelle@mail.com',null,'09-09-1999','F','Brésil','Rio de Janeiro','10-10-2010',null);

insert into amis values(11,12,'30-03-2005');
insert into amis values(12,11,'30-03-2005');
insert into amis values(5,6,'05-05-2018');
insert into amis values(6,5,'05-05-2018');
insert into amis values(5,7,'05-05-2018');
insert into amis values(7,5,'05-05-2018');
insert into amis values(18,22,'17-07-2017');
insert into amis values(22,18,'17-07-2017');
insert into amis values(13,14,'14-07-2019');
insert into amis values(14,13,'14-07-2019');
insert into amis values(14,10,'14-07-2019');
insert into amis values(10,14,'14-07-2019');
insert into amis values(14,20,'14-07-2019');
insert into amis values(20,14,'14-07-2019');
-- amis de Kevin69 (13,10,20)
insert into amis values(8,13,'20-01-2014');
insert into amis values(13,8,'20-01-2014');
insert into amis values(8,10,'10-01-2018');
insert into amis values(10,8,'10-01-2018');
insert into amis values(8,20,'09-09-2019');
insert into amis values(20,8,'09-09-2019');
-- amis des amis de Kevin69 (1,2)
insert into amis values(1,13,'12-11-2017');
insert into amis values(13,1,'12-11-2017');
insert into amis values(1,10,'06-07-2018');
insert into amis values(10,1,'06-07-2018');
insert into amis values(1,20,'18-08-2016');
insert into amis values(20,1,'18-08-2016');
insert into amis values(2,13,'09-09-2019');
insert into amis values(13,2,'09-09-2019');
insert into amis values(2,10,'23-10-2018');
insert into amis values(10,2,'23-10-2018');
insert into amis values(2,20,'03-05-2016');
insert into amis values(20,2,'03-05-2016');

insert into couples values(14,15,'21-02-2015');
insert into couples values(15,14,'21-02-2015');
insert into couples values(16,17,'12-09-2019');
insert into couples values(17,16,'12-09-2019');
insert into couples values(5,22,'05-11-2019');
insert into couples values(22,5,'05-11-2019');

insert into pages values(1,'publique',1);
insert into pages values(2,'privée',10);
insert into pages values(3,'publique',100);
insert into pages values(4,'publique',1000);
insert into pages values(5,'publique',10000);

insert into creer values(5,1);
insert into creer values(1,2);
insert into creer values(9,3);
insert into creer values(8,4);
insert into creer values(12,5);

insert into contient values(1,5);
insert into contient values(1,6);
insert into contient values(1,7);
insert into contient values(2,2);
insert into contient values(3,3);
insert into contient values(3,4);
insert into contient values(4,1);
insert into contient values(5,8);
insert into contient values(5,9);

insert into publications values(1,'Titre','16-08-2017','Contenu de la publication',6);
insert into publications values(2,'Hello','16-08-2017','Hello',1);
insert into publications values(3,'PSG Champion','16-08-2017','on é les meilleurs !!!',2003);
insert into publications values(4,'Champion du MONDE !!!','14-07-2018','CHAMPION DU MONDE !!!!!!!!!!!!',10230);
insert into publications values(5,'Trump','12-09-2017','Il faut mettre Trump dans la base donc voila',0);
insert into publications values(6,'Trump president','19-09-2017','Hello Trump is the 45th president.',102);
insert into publications values(7,'How old is Trump ?','17-02-2016','How old is Trump ???',1);
-- publication de Kevin69
insert into publications values(8,'ON VAS TOUS MOURRIR !!!','12-12-2012','C LA FIN DU MONDE !!!',506);
insert into publications values(9,'ON EST VIVANTS !!!','13-12-2012','ON EST ENCORE VIVANT !!!',5006);

insert into publier values(8,8);
insert into publier values(8,9);
insert into publier values(1,1);
insert into publier values(1,3);
insert into publier values(2,2);
insert into publier values(6,4);
insert into publier values(7,5);
insert into publier values(10,6);

insert into messages values(1,'Hello','01-08-2019');
insert into messages values(2,'Hello how are you','01-08-2019');
insert into messages values(3,'Good !','01-08-2019');

insert into envoyer values(8,1);
insert into envoyer values(9,2);
insert into envoyer values(8,3);

insert into aimerPage values(1,1);
insert into aimerPage values(2,2);
insert into aimerPage values(3,3);
insert into aimerPage values(4,4);
insert into aimerPage values(5,5);

insert into aimerPublication values(1,5);
insert into aimerPublication values(2,5);
insert into aimerPublication values(3,5);
insert into aimerPublication values(4,5);
insert into aimerPublication values(5,5);
insert into aimerPublication values(12,7);
insert into aimerPublication values(12,8);
insert into aimerPublication values(14,8);
insert into aimerPublication values(15,8);
insert into aimerPublication values(16,8);
insert into aimerPublication values(18,8);
-- aimé tous les publications de Kevin69 (8,10,20,22)
insert into aimerPublication values(8,8);
insert into aimerPublication values(8,9);
insert into aimerPublication values(10,8);
insert into aimerPublication values(10,9);
insert into aimerPublication values(20,8);
insert into aimerPublication values(20,9);
insert into aimerPublication values(22,8);
insert into aimerPublication values(22,9);

insert into groupes values(1,'Flat Earth Society');
insert into groupes values(2,'Français(e)');
insert into groupes values(3,'Groupe');
insert into groupes values(4,'Hello');
insert into groupes values(5,'Groupe des meilleurs !');

insert into possede values(1,1);
insert into possede values(2,2);
insert into possede values(3,3);
insert into possede values(4,4);
insert into possede values(5,5);

insert into rejoindre values(9,2);
insert into rejoindre values(12,2);
insert into rejoindre values(13,2);
insert into rejoindre values(15,2);
insert into rejoindre values(17,2);
insert into rejoindre values(18,3);
insert into rejoindre values(20,2);
insert into rejoindre values(21,2);
-- groupes de Kevin69 (1,2,5)
insert into rejoindre values(8,1);
insert into rejoindre values(8,2);
insert into rejoindre values(8,5);
-- qui sont dans les groupes de Kevin69 (1,10,20)
insert into rejoindre values(1,1);
insert into rejoindre values(1,2);
insert into rejoindre values(1,5);
insert into rejoindre values(10,1);
insert into rejoindre values(10,2);
insert into rejoindre values(10,5);
insert into rejoindre values(20,1);
insert into rejoindre values(20,5);
