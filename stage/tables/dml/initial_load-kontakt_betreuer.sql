--INITIAL LOAD:
TRUNCATE TABLE stage.kontakt_betreuer;

-- Insert von zwei Standardfällen:

INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst)
VALUES
  (1
  ,'A'
  ,1
  ,DATE'2017-01-01'
  ,DATE'2017-01-01' +3
  ,DATE'2017-01-01');

INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst)
VALUES
  (1
  ,'B'
  ,1
  ,DATE'2017-01-01' +3
  ,NULL
  ,DATE'2017-01-01');
  
INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst)
VALUES
  (1
  ,'B'
  ,2
  ,DATE'2017-01-01'
  ,NULL
  ,DATE'2017-01-01');

INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst)
VALUES
  (2
  ,'C'
  ,1
  ,DATE'2017-01-01'
  ,NULL
  ,DATE'2017-01-01');
  
INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst
  ,geaendert_zst)
VALUES
  (2
  ,'C'
  ,1
  ,DATE'2017-01-01'
  ,DATE'2017-01-01'+30
  ,DATE'2017-01-01'
  ,DATE'2017-01-01'+1);
  

  
--	Doppelte Zuordnung in der Quelle
INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst)
VALUES
  (2
  ,'C'
  ,1
  ,DATE'2017-01-01'
  ,NULL
  ,DATE'2017-01-01');
  
--	Zweimal die gleiche Zuordnung mit unterschiedlichem Gültigkeitsbeginn
INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst)
VALUES
  (2
  ,'C'
  ,2
  ,DATE'2017-01-01'
  ,NULL
  ,DATE'2017-01-01');

INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst)
VALUES
  (2
  ,'C'
  ,2
  ,DATE'2017-01-01' +1
  ,NULL
  ,DATE'2017-01-01');  

--	Zweimal oder öfter die gleiche Zuordnung mit gleichem Gültigkeitsbeginn aber unterschiedlichem Gültigkeitsende
INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst)
VALUES
  (3
  ,'E'
  ,1
  ,DATE'2017-01-01' +1
  ,NULL
  ,DATE'2017-01-01');

INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst)
VALUES
  (3
  ,'E'
  ,1
  ,DATE'2017-01-01' +1
  ,DATE'2017-01-01' +2
  ,DATE'2017-01-01');

INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst)
VALUES
  (3
  ,'E'
  ,1
  ,DATE'2017-01-01' +1
  ,DATE'2017-01-01' +3
  ,DATE'2017-01-01');

INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst
  ,geaendert_zst
  ,geloescht_zst)
VALUES
  (3
  ,'E'
  ,1
  ,DATE'2017-01-01' +1
  ,DATE'2017-01-01' +3
  ,DATE'2017-01-01'
  ,DATE'2017-01-01' +1
  ,DATE'2017-01-01' +1);

--	NULL-Values als Gültigkeitsbeginn und/oder -Ende
INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst)
VALUES
  (4
  ,'E'
  ,1
  ,NULL
  ,DATE'2017-01-01' +3
  ,DATE'2017-01-01');

--	Unterschiedliche Zuordnung des Leading Keys mit überschneidenden Gültigkeitszeiträumen
INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst)
VALUES
  (4
  ,'F'
  ,1
  ,DATE'2017-01-01' +1
  ,DATE'2017-01-01' +3
  ,DATE'2017-01-01');
  
INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst)
VALUES
  (4
  ,'G'
  ,1
  ,DATE'2017-01-01' +2
  ,DATE'2017-01-01' +7
  ,DATE'2017-01-01');
  
  -- Test ob weitere Änderung bei DENSE RANK richtig gezogen wird:
  INSERT INTO stage.kontakt_betreuer
  (kontakt
  ,betreuer
  ,betreuer_typ
  ,gueltig_ab
  ,gueltig_bis
  ,erstellt_zst
  ,geaendert_zst)
VALUES
  (2
  ,'C'
  ,1
  ,DATE'2017-01-01'
  ,NULL
  ,DATE'2017-01-01'
  ,DATE'2017-01-01'+3);