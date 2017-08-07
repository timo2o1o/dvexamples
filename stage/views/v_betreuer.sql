CREATE OR REPLACE VIEW stage.v_betreuer AS
SELECT
a.seq,
a.ldt,
a.betreuer,
a.kostenstelle,
a.erstellt_zst,
a.geaendert_zst,
a.geloescht_zst,
STANDARD_HASH(a.betreuer) AS hk_advisor_h,
STANDARD_HASH(TO_CHAR(a.kostenstelle)) AS hk_cost_centre_h,
STANDARD_HASH(a.betreuer || ';' || TO_CHAR(a.kostenstelle)) AS hk_advisor_cst_cntr_l,
STANDARD_HASH(TO_CHAR(a.erstellt_zst, 'YYYY-MM-DD"T"HH24:MI:SS') || ';' || TO_CHAR(a.geaendert_zst, 'YYYY-MM-DD"T"HH24:MI:SS') || ';' || TO_CHAR(a.geloescht_zst, 'YYYY-MM-DD"T"HH24:MI:SS')) AS hd_advisor_data_s,
'BETREUER' AS rsrc
FROM stage.betreuer a;

GRANT SELECT ON stage.v_betreuer TO edw_data;