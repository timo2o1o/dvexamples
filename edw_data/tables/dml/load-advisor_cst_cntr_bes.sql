INSERT INTO edw_data.advisor_cst_cntr_bes
  (hk_advisor_cst_cntr_l
  ,ldt
  ,rsrc
  ,validfrom
  ,validto)
WITH srcdata1 AS
(SELECT a.hk_advisor_cst_cntr_l AS linkkey
        ,a.hk_advisor_h AS leadingkey
        ,a.hk_cost_centre_h AS deptkey
        ,coalesce(a.geaendert_zst, a.erstellt_zst) AS validfrom
        ,least(coalesce(MIN(coalesce(a.geaendert_zst, a.erstellt_zst)) over(PARTITION BY a.hk_advisor_h ORDER BY coalesce(a.geaendert_zst, a.erstellt_zst) DESC rows BETWEEN unbounded preceding AND 1 preceding) - INTERVAL '0.001' SECOND
                       ,DATE '9999-01-01')
              ,coalesce(a.geloescht_zst, DATE '9999-01-01')) AS validto
        ,a.rsrc AS rsrc
    FROM stage.v_betreuer a),
srcdata AS
(SELECT a.linkkey
        ,a.leadingkey
        ,a.deptkey
        ,a.validfrom
        ,a.validto
        ,a.rsrc
    FROM srcdata1 a
   WHERE NOT EXISTS (SELECT NULL
            FROM edw_data.v_advisor_cst_cntr_bes y
           WHERE y.hk_advisor_cst_cntr_l = a.linkkey
             AND y.validfrom = a.validfrom
             AND (y.validto = a.validto OR a.validto = DATE '9999-01-01')
             AND y.ledt = to_date('01.01.9999', 'DD.MM.YYYY'))),
effdata AS
(SELECT hextoraw(l.hk_advisor_cst_cntr_l) AS linkkey
        ,hextoraw(l.hk_advisor_h) AS leadingkey
        ,hextoraw(l.hk_cost_centre_h) AS deptkey
        ,es.validfrom
        ,es.validto
        ,es.rsrc
    FROM edw_data.v_advisor_cst_cntr_bes es
   INNER JOIN edw_data.advisor_cst_cntr_l l
      ON l.hk_advisor_cst_cntr_l = es.hk_advisor_cst_cntr_l
   WHERE es.ledt = DATE '9999-01-01'
     AND es.validfrom < es.validto
     -- This can be added to limit the amount of data in an incremental load scenario:
     -- AND l.hk_advisor_h IN (SELECT DISTINCT /*+ result_cache */ a.hk_advisor_h FROM stage.v_betreuer a)
),
newvalidto AS
(SELECT e.linkkey
        ,e.leadingkey
        ,e.deptkey
        ,e.validfrom
        ,MIN(s.validfrom) - INTERVAL '0.001' SECOND AS validto
        ,e.rsrc
    FROM effdata e
   INNER JOIN srcdata s
      ON s.leadingkey = e.leadingkey
   WHERE NOT (s.deptkey = e.deptkey AND s.validfrom = e.validfrom)
     AND s.validfrom < e.validto
   GROUP BY e.linkkey
           ,e.leadingkey
           ,e.deptkey
           ,e.validfrom
           ,e.rsrc),
newrows AS
(SELECT * FROM srcdata UNION SELECT * FROM newvalidto)
SELECT linkkey AS hk_advisor_cst_cntr_l
      ,SYSDATE AS ldt
      ,rsrc
      ,validfrom
      ,validto
  FROM newrows a;