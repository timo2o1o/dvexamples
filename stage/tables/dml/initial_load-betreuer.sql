--INITIAL LOAD:
TRUNCATE TABLE stage.betreuer;

INSERT INTO stage.betreuer
  (seq
  ,ldt
  ,betreuer
  ,kostenstelle
  ,erstellt_zst)
VALUES
  (1
  ,DATE'2017-03-30'
  ,'A'
  ,1
  ,DATE'2017-01-01');
  
INSERT INTO stage.betreuer
  (seq
  ,ldt
  ,betreuer
  ,kostenstelle
  ,erstellt_zst)
VALUES
  (2
  ,DATE'2017-03-30'
  ,'B'
  ,2
  ,DATE'2017-01-01');
  
COMMIT;

TRUNCATE TABLE stage.betreuer;
  
INSERT INTO stage.betreuer
  (seq
  ,ldt
  ,betreuer
  ,kostenstelle
  ,erstellt_zst
  ,geaendert_zst)
VALUES
  (1
  ,DATE'2017-03-30' + 1
  ,'A'
  ,3
  ,DATE'2017-01-01'
  ,DATE'2017-01-05');
  
INSERT INTO stage.betreuer
  (seq
  ,ldt
  ,betreuer
  ,kostenstelle
  ,erstellt_zst)
VALUES
  (2
  ,DATE'2017-03-30' + 1
  ,'B'
  ,2
  ,DATE'2017-01-01');
  
COMMIT;
  
TRUNCATE TABLE stage.betreuer;
  
INSERT INTO stage.betreuer
  (seq
  ,ldt
  ,betreuer
  ,kostenstelle
  ,erstellt_zst
  ,geaendert_zst)
VALUES
  (1
  ,DATE'2017-03-30' + 2
  ,'A'
  ,1
  ,DATE'2017-01-01'
  ,DATE'2017-01-06');
  
INSERT INTO stage.betreuer
  (seq
  ,ldt
  ,betreuer
  ,kostenstelle
  ,erstellt_zst)
VALUES
  (2
  ,DATE'2017-03-30' + 2
  ,'B'
  ,2
  ,DATE'2017-01-01');
  
COMMIT;  
  
  
  
  
  
  
  /* ALTE BEISPIELE */
  
INSERT INTO stage.betreuer
  (seq
  ,ldt
  ,betreuer
  ,kostenstelle
  ,erstellt_zst
  ,geaendert_zst)
VALUES
  (3
  ,sysdate
  ,'C'
  ,12
  ,DATE'2017-01-01' -1
  ,DATE'2017-01-01');
  
INSERT INTO stage.betreuer
  (seq
  ,ldt
  ,betreuer
  ,kostenstelle
  ,erstellt_zst
  ,geaendert_zst
  ,geloescht_zst)
VALUES
  (4
  ,SYSDATE
  ,'D'
  ,155
  ,DATE'2017-01-01' -2
  ,DATE'2017-01-01' -1
  ,DATE'2017-01-01');  
  
-- Change of cost_centre
UPDATE stage.betreuer
   SET kostenstelle = 160
      ,geaendert_zst = DATE'2017-01-01' +1
 WHERE betreuer = 'A';
 
-- Change of cost_centre with valid-from in the future
UPDATE stage.betreuer
   SET kostenstelle = 33
      ,geaendert_zst = DATE'2017-01-01' + 3
 WHERE betreuer = 'A';
 
-- Change of cost_centre with valid_from in between now and the future
UPDATE stage.betreuer
   SET kostenstelle = 1
      ,geaendert_zst = DATE'2017-01-01' + 1
 WHERE betreuer = 'A';
 
-- CHANGE another advisor
UPDATE stage.betreuer
   SET kostenstelle = 160
      ,geaendert_zst = DATE'2017-01-01' + 1
 WHERE betreuer = 'B';
 
-- DELETE a betreuer
UPDATE stage.betreuer
  SET geloescht_zst = DATE'2017-01-01' + 2
WHERE betreuer = 'B';

-- Another change
UPDATE stage.betreuer
   SET kostenstelle = 160,
       geaendert_zst = DATE'2017-01-01' + 4
WHERE betreuer = 'A';
