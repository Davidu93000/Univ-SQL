DROP TABLE ETUDIANTS CASCADE CONSTRAINTS;

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';

CREATE TABLE ETUDIANTS(
	NUMERO             NUMBER(4)	,
	NOM                VARCHAR2(25)	CONSTRAINT CONTRAINTE1 NOT NULL,
	PRENOM             VARCHAR2(25)	CONSTRAINT CONTRAINTE2 NOT NULL,
	SEXE               CHAR(1)		CONSTRAINT CONTRAINTE3 CHECK(SEXE IN ('F','M')),
	DATENAISSANCE      DATE			CONSTRAINT CONTRAINTE4 NOT NULL,
	POIDS              NUMBER		,
	ANNEE              NUMBER		,
	CONSTRAINT PK_ETUDIANTS PRIMARY KEY (NUMERO)
);

DESC ETUDIANTS;

select constraint_name from user_constraints where table_name='ETUDIANTS';

ALTER TABLE ETUDIANTS ADD CONSTRAINT CK_POIDS CHECK(POIDS > 30 AND POIDS < 200);
ALTER TABLE ETUDIANTS ADD CONSTRAINT CK_ANNEE CHECK(ANNEE=1 OR ANNEE=2);

select constraint_name from user_constraints where table_name='ETUDIANTS';

ALTER TABLE ETUDIANTS RENAME CONSTRAINT CONTRAINTE1 TO NN_NOM;
ALTER TABLE ETUDIANTS RENAME CONSTRAINT CONTRAINTE2 TO NN_PRENOM;
ALTER TABLE ETUDIANTS RENAME CONSTRAINT CONTRAINTE3 TO CK_SEXE;
ALTER TABLE ETUDIANTS RENAME CONSTRAINT CONTRAINTE4 TO NN_DATENAISSANCE;

select constraint_name from user_constraints where table_name='ETUDIANTS';
