CREATE OR REPLACE VIEW stage.v_kontakt_betreuer AS
SELECT
a.kontakt,
a.betreuer,
a.betreuer_typ,
a.gueltig_ab,
a.gueltig_bis,
a.erstellt_zst,
a.geaendert_zst,
a.geloescht_zst,
STANDARD_HASH(a.betreuer) AS hk_advisor_h,
STANDARD_HASH(TO_CHAR(a.kontakt)) AS hk_contact_h,
STANDARD_HASH(a.betreuer || ';' || TO_CHAR(a.kontakt) || ';' || TO_CHAR(a.betreuer_typ)) AS hk_contact_advisor_l,
'KONTAKT_BETREUER' AS rsrc
FROM stage.kontakt_betreuer a;

GRANT SELECT ON stage.v_kontakt_betreuer TO edw_data;