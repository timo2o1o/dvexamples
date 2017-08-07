/*
TRUNCATE TABLE edw_data.advisor_cst_cntr_bes;
TRUNCATE TABLE edw_data.advisor_cst_cntr_l;
TRUNCATE TABLE edw_data.advisor_data_s;
TRUNCATE TABLE edw_data.advisor_h;
TRUNCATE TABLE edw_data.cost_centre_h;
*/

INSERT INTO edw_data.advisor_h
  (hk_advisor_h
  ,ldt
  ,rsrc
  ,advisor)
  SELECT a.hk_advisor_h
        ,MIN(a.ldt)
        ,MAX(a.rsrc)
        ,MAX(a.betreuer) AS advisor
    FROM stage.v_betreuer a
   WHERE NOT EXISTS (SELECT NULL FROM edw_data.advisor_h b WHERE b.hk_advisor_h = a.hk_advisor_h)
   GROUP BY a.hk_advisor_h;

INSERT INTO edw_data.cost_centre_h
  (hk_cost_centre_h
  ,ldt
  ,rsrc
  ,cost_centre)
  SELECT a.hk_cost_centre_h
        ,MIN(a.ldt)
        ,MAX(a.rsrc)
        ,MAX(a.kostenstelle) AS cost_centre
    FROM stage.v_betreuer a
   WHERE NOT EXISTS (SELECT NULL FROM edw_data.cost_centre_h b WHERE b.hk_cost_centre_h = a.hk_cost_centre_h)
   GROUP BY a.hk_cost_centre_h;

INSERT INTO edw_data.advisor_cst_cntr_l
  (hk_advisor_cst_cntr_l
  ,ldt
  ,rsrc
  ,hk_advisor_h
  ,hk_cost_centre_h)
  SELECT a.hk_advisor_cst_cntr_l
        ,MIN(ldt)
        ,MAX(a.rsrc)
        ,MAX(a.hk_advisor_h)
        ,MAX(a.hk_cost_centre_h)
    FROM stage.v_betreuer a
   WHERE NOT EXISTS (SELECT NULL FROM edw_data.advisor_cst_cntr_l b WHERE b.hk_advisor_cst_cntr_l = a.hk_advisor_cst_cntr_l)
   GROUP BY a.hk_advisor_cst_cntr_l;

INSERT INTO edw_data.advisor_data_s
  (hk_advisor_h
  ,ldt
  ,rsrc
  ,hashdiff
  ,created_dt
  ,changed_dt
  ,deleted_dt)
  SELECT a.hk_advisor_h
      ,a.ldt
      ,a.rsrc
      ,a.hd_advisor_data_s  AS hashdiff
      ,a.erstellt_zst  AS created_dt
      ,a.geaendert_zst AS changed_dt
      ,a.geloescht_zst AS deleted_dt
  FROM stage.v_betreuer a
 WHERE NOT EXISTS (SELECT NULL
                     FROM edw_data.v_advisor_data_s b
                    WHERE b.hk_advisor_h = a.hk_advisor_h
                      AND b.ledt = DATE '9999-01-01'
                      AND HEXTORAW(b.hashdiff) = a.hd_advisor_data_s);
