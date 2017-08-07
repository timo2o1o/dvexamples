--TRUNCATE TABLE edw_data.advisor_cst_cntr_dks;

INSERT INTO edw_data.advisor_cst_cntr_dks
  (hk_advisor_cst_cntr_l
  ,ldt
  ,rsrc
  ,activeyn)
WITH srcdata AS
(SELECT a.hk_advisor_cst_cntr_l AS linkkey
        ,a.hk_advisor_h AS leadingkey
        ,a.hk_cost_centre_h AS deptkey
        ,'Y' AS activeyn
        ,a.rsrc AS rsrc
    FROM stage.v_betreuer a),
effdata AS
(SELECT hextoraw(l.hk_advisor_cst_cntr_l) AS linkkey
        ,hextoraw(l.hk_advisor_h) AS leadingkey
        ,hextoraw(l.hk_cost_centre_h) AS deptkey
        ,es.activeyn
        ,es.rsrc
    FROM edw_data.v_advisor_cst_cntr_dks es
   INNER JOIN edw_data.advisor_cst_cntr_l l
      ON l.hk_advisor_cst_cntr_l = es.hk_advisor_cst_cntr_l
   WHERE es.ledt = DATE '9999-01-01'
     -- This can be added to limit the amount of data in an incremental load scenario:
     -- AND l.hk_advisor_h IN (SELECT DISTINCT /*+ result_cache */ a.hk_advisor_h FROM stage.v_betreuer a)
),
newvalidto AS
(SELECT e.linkkey
        ,MAX(e.leadingkey)
        ,MAX(e.deptkey)
        ,'N' AS activeyn
        ,MAX(e.rsrc)
    FROM effdata e
    LEFT OUTER JOIN srcdata s
      ON s.leadingkey = e.leadingkey
   WHERE e.activeyn = 'Y'
     AND (NOT (s.deptkey = e.deptkey)
           OR s.deptkey IS NULL)
   GROUP BY e.linkkey),
newrows AS
(SELECT * FROM srcdata UNION ALL SELECT * FROM newvalidto)
SELECT linkkey AS hk_advisor_cst_cntr_l
      ,SYSDATE AS ldt
      ,rsrc
      ,activeyn
  FROM newrows a
 WHERE NOT EXISTS (SELECT NULL
                     FROM edw_data.v_advisor_cst_cntr_dks y
                    WHERE y.hk_advisor_cst_cntr_l = a.linkkey
                      AND y.activeyn = a.activeyn
                      AND y.ledt = DATE '9999-01-01');