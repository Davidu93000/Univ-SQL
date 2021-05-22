DROP TABLE genealogie;

CREATE TABLE genealogie (
  numPer NUMERIC,
  Nom varchar2(35) NOT NULL,
  DateNaissance date NOT NULL,
  Pere NUMERIC DEFAULT NULL,
  Mere NUMERIC DEFAULT NULL,
  PRIMARY KEY (numPer)
);

INSERT INTO genealogie (numPer, Nom, DateNaissance, Pere, Mere) VALUES (1, 'George VI', '14/12/1895', NULL, NULL);
INSERT INTO genealogie (numPer, Nom, DateNaissance, Pere, Mere) VALUES (2, 'Elizabeth Bowes-Lyon', '04/08/1900', NULL, NULL);
INSERT INTO genealogie (numPer, Nom, DateNaissance, Pere, Mere) VALUES (3, 'Elizabeth II', '21/04/1926', 1, 2);
INSERT INTO genealogie (numPer, Nom, DateNaissance, Pere, Mere) VALUES (4, 'Margaret du Royaume-Uni', '21/08/1930', 1, 2);
INSERT INTO genealogie (numPer, Nom, DateNaissance, Pere, Mere) VALUES (5, 'Philip Mountbatten', '10/06/1921', NULL, NULL);
INSERT INTO genealogie (numPer, Nom, DateNaissance, Pere, Mere) VALUES (6, 'Prince Charles', '14/11/1948', 5, 3);
INSERT INTO genealogie (numPer, Nom, DateNaissance, Pere, Mere) VALUES (7, 'Princesse Anne', '15/08/1950', 5, 3);
INSERT INTO genealogie (numPer, Nom, DateNaissance, Pere, Mere) VALUES (8, 'Prince Andrew', '19/02/1960', 5, 3);
INSERT INTO genealogie (numPer, Nom, DateNaissance, Pere, Mere) VALUES (9, 'Prince Edward', '10/03/1964', 5, 3);
INSERT INTO genealogie (numPer, Nom, DateNaissance, Pere, Mere) VALUES (10, 'Diana Spencer', '01/07/1961', NULL, NULL);
INSERT INTO genealogie (numPer, Nom, DateNaissance, Pere, Mere) VALUES (11, 'Prince William', '21/06/1982', 6, 10);
INSERT INTO genealogie (numPer, Nom, DateNaissance, Pere, Mere) VALUES (12, 'Prince Henry', '15/09/1984', 6, 10);

/* 1 */
SELECT Nom,DateNaissance FROM GENEALOGIE WHERE Mere = 3;
/* 2 */
SELECT G2.NOM,G2.DATENAISSANCE FROM GENEALOGIE G1, GENEALOGIE G2 WHERE G1.NUMPER = 11 AND G2.NUMPER = G1.MERE;
/* 3 */
SELECT G2.NOM,G2.DATENAISSANCE FROM GENEALOGIE G1, GENEALOGIE G2 WHERE (G1.NUMPER = 3 AND G2.NUMPER = G1.MERE) OR (G1.NUMPER = 3 AND G2.NUMPER = G1.PERE);
/* 4 */
SELECT G2.NOM,G2.DATENAISSANCE FROM GENEALOGIE G1, GENEALOGIE G2 WHERE (G1.NUMPER = 6 AND G2.MERE = G1.MERE AND G2.PERE = G1.PERE AND G2.NUMPER != 6);
/* 5 */
SELECT G1.NOM,G2.NOM AS NOM_PERE,G3.NOM AS NOM_MERE FROM GENEALOGIE G1,GENEALOGIE G2,GENEALOGIE G3 WHERE (G2.NUMPER = G1.PERE AND G3.NUMPER = G1.MERE) UNION (SELECT NOM,NULL,NULL FROM GENEALOGIE WHERE PERE IS NULL OR MERE IS NULL);
/* 6 */
SELECT G1.NOM,COUNT(*) AS NB_ENFANTS FROM GENEALOGIE G1,GENEALOGIE G2 WHERE G1.NUMPER = G2.PERE OR G1.NUMPER = G2.MERE GROUP BY G1.NOM;
