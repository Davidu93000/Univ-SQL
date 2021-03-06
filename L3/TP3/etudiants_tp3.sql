DROP TABLE ETUDIANTS CASCADE CONSTRAINTS;

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';

CREATE TABLE ETUDIANTS(
	NUMERO		NUMBER(4)		NOT NULL,
	NOM			VARCHAR2(25)	NOT NULL,
	PRENOM		VARCHAR2(25)	NOT NULL,
	SEXE			CHAR(1)		CHECK (SEXE IN ('M','F')),
	DATENAISSANCE	DATE			NOT NULL,
	POIDS			NUMBER		,
	ANNEE			NUMBER		,
	CONSTRAINT PK_ETUDIANTS PRIMARY KEY (NUMERO)
);

INSERT INTO ETUDIANTS VALUES(71,'Traifor','Benoît','M','10/12/1978',77,1);
INSERT INTO ETUDIANTS VALUES(72,'Génial','Clément','M','10/04/1978',72,1);
INSERT INTO ETUDIANTS VALUES(73,'Paris','Adam','M','28/06/1974',72,2);
INSERT INTO ETUDIANTS (NUMERO,NOM,PRENOM,SEXE,DATENAISSANCE,POIDS) VALUES(74,'Parees','Clémence','F','20/09/1977',72);
INSERT INTO ETUDIANTS VALUES(69,'Saitout','Inès','F','22/11/1969',69,2);
INSERT INTO ETUDIANTS VALUES(55,'Seratoub','Izouaf','M','19/09/2013',81,1);

COL attribut FORMAT format
TTITLE ‘Titre’
SET PAGES n
SET LINES m

/*SELECT DECODE(ANNEE, 1, 'Première', 2, 'Seconde', 'Valeur différente de 1 et de 2 !!') AS ANETUDE FROM ETUDIANTS;
SELECT UPPER(NOM) FROM ETUDIANTS;
SELECT LOWER (NOM) FROM ETUDIANTS;
SELECT NVL(TO_CHAR(ANNEE), 'Valeur NON renseignée') AS ANETUDE FROM ETUDIANTS;

SELECT NOM||' '||PRENOM AS NOM_PRENOM FROM ETUDIANTS;
SELECT UPPER(SUBSTR(PRENOM,1,1))||'. '||UPPER(NOM) AS PN FROM ETUDIANTS WHERE SEXE = 'M';
SELECT NOM,DATENAISSANCE FROM ETUDIANTS WHERE SOUNDEX(NOM) = SOUNDEX('Paris');
SELECT NOM,DATENAISSANCE FROM ETUDIANTS WHERE PRENOM LIKE 'I%';
SELECT UPPER(NOM)||' '||PRENOM||' est '||DECODE(SEXE, 'M', 'un garçon', 'F', 'une fille')||' né le '||DATENAISSANCE||' pèse '||POIDS||' kg et est en '||DECODE(ANNEE, 1, 'Première année', 2, 'Seconde années') AS DESCRIPTION FROM ETUDIANTS WHERE ANNEE BETWEEN 1 AND 2;
SELECT UPPER(NOM)||' à '||TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM DATENAISSANCE)) || ' ans' AS AGE FROM ETUDIANTS;*/
