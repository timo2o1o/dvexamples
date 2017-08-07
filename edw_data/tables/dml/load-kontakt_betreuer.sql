INSERT INTO edw_data.advisor_h
  (hk_advisor_h
  ,ldt
  ,rsrc
  ,advisor)
  SELECT DISTINCT
         a.hk_advisor_h
        ,SYSDATE AS ldt
        ,a.rsrc
        ,a.betreuer AS advisor
    FROM stage.v_kontakt_betreuer a
   WHERE a.hk_advisor_h <> ALL (SELECT
           b.hk_advisor_h
            FROM edw_data.advisor_h b);

INSERT INTO edw_data.contact_h
  (hk_contact_h
  ,ldt
  ,rsrc
  ,contact)
  SELECT DISTINCT 
         a.hk_contact_h
        ,SYSDATE AS ldt
        ,a.rsrc
        ,a.kontakt AS contact
    FROM stage.v_kontakt_betreuer a
   WHERE a.hk_contact_h <> ALL (SELECT
           b.hk_contact_h
            FROM edw_data.contact_h b);

INSERT INTO edw_data.contact_advisor_l
  (hk_contact_advisor_l
  ,ldt
  ,rsrc
  ,hk_advisor_h
  ,hk_contact_h
  ,advisor_type)
  SELECT DISTINCT
         a.hk_contact_advisor_l
        ,SYSDATE AS ldt
        ,a.rsrc
        ,a.hk_advisor_h
        ,a.hk_contact_h
        ,a.betreuer_typ
    FROM stage.v_kontakt_betreuer a
   WHERE a.hk_contact_advisor_l <> ALL (SELECT
           b.hk_contact_advisor_l
            FROM edw_data.contact_advisor_l b);