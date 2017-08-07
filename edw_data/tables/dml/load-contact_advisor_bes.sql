-- TRUNCATE TABLE edw_data.contact_advisor_bes

SELECT a.hk_contact_advisor_l AS linkkey
      ,MAX(a.hk_advisor_h) AS leadingkey
      ,MAX(a.betreuer_typ) AS leadingkeypart
      ,MAX(a.hk_contact_h) AS deptkey
      ,COALESCE(a.gueltig_ab,  DATE'1700-01-01')  AS validfrom
      ,COALESCE(MAX(a.gueltig_bis) keep(dense_rank FIRST ORDER BY a.gueltig_bis DESC, COALESCE(a.geaendert_zst, a.erstellt_zst) DESC NULLS FIRST), DATE'9999-01-01') AS validto
  FROM stage.v_kontakt_betreuer a
 WHERE a.betreuer = 'C'
   AND a.kontakt  = 2
   AND a.betreuer_typ = 1
   AND a.geloescht_zst IS NULL
 GROUP BY a.hk_contact_advisor_l, a.gueltig_ab

/*INSERT INTO edw_data.contact_advisor_bes
  (hk_contact_advisor_l
  ,ldt
  ,validfrom
  ,validto)*/
  WITH srcdata AS
   (SELECT a.hk_contact_advisor_l AS linkkey
          ,MAX(a.hk_advisor_h) AS leadingkey
          ,MAX(a.betreuer_typ) AS leadingkeypart
          ,MAX(a.hk_contact_h) AS deptkey
          ,COALESCE(a.gueltig_ab,  DATE'1700-01-01')  AS validfrom
          ,COALESCE(MAX(a.gueltig_bis) keep(dense_rank FIRST ORDER BY COALESCE(a.geaendert_zst, a.erstellt_zst) DESC NULLS FIRST), DATE'9999-01-01') AS validto
      FROM stage.v_kontakt_betreuer a
     WHERE COALESCE(a.gueltig_ab, DATE'1700-01-01') < COALESCE(a.gueltig_bis, DATE '9999-01-01')
       AND a.geloescht_zst IS NULL
     GROUP BY a.hk_contact_advisor_l, a.gueltig_ab),
  effdata AS
   (SELECT hextoraw(l.hk_contact_advisor_l) AS linkkey
          ,hextoraw(l.hk_advisor_h) AS leadingkey
          ,l.advisor_type           AS leadingkeypart
          ,hextoraw(l.hk_contact_h) AS deptkey
          ,es.validfrom
          ,es.validto
      FROM edw_data.v_contact_advisor_bes es
     INNER JOIN edw_data.contact_advisor_l l
        ON l.hk_contact_advisor_l = es.hk_contact_advisor_l
     WHERE es.ledt = DATE '9999-01-01'
       AND es.validfrom < es.validto
       -- Einschränken auf Leading_Keys in der Stage:
       AND l.hk_advisor_h IN (SELECT a.hk_advisor_h FROM stage.v_kontakt_betreuer a)),
  newvalidto AS
   (SELECT e.linkkey
          ,e.leadingkey
          ,e.leadingkeypart
          ,e.deptkey
          ,e.validfrom
          ,s.validfrom - INTERVAL '0.001' SECOND AS validto
      FROM effdata e
     INNER JOIN srcdata s
        ON (s.leadingkey = e.leadingkey AND s.leadingkeypart = e.leadingkeypart)
       AND NOT (s.deptkey = e.deptkey AND s.validfrom = e.validfrom)
       AND s.validfrom < e.validto
       AND s.validto >= e.validto),
  newrows AS
   (SELECT * FROM srcdata UNION ALL SELECT * FROM newvalidto)
  
  SELECT linkkey
        ,SYSDATE AS ldt
        ,validfrom
        ,validto
    FROM newrows a
   WHERE a.linkkey <> ALL (SELECT
           b.hk_contact_advisor_l
            FROM edw_data.v_contact_advisor_bes b
           WHERE b.ledt = DATE '9999-01-01'
             AND b.validfrom = a.validfrom
             AND b.validto = a.validto);