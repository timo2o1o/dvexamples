CREATE OR REPLACE VIEW edw_data.v_contact_advisor_bes AS
SELECT
a.hk_contact_advisor_l,
a.ldt,
nvl(lead(a.ldt, 1) over(PARTITION BY a.hk_contact_advisor_l, a.validfrom ORDER BY a.ldt), DATE '9999-01-01') AS ledt,
a.rsrc,
a.validfrom,
a.validto
FROM edw_data.contact_advisor_bes a;