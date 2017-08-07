CREATE OR REPLACE VIEW edw_data.v_advisor_cst_cntr_bes AS
SELECT
a.hk_advisor_cst_cntr_l,
a.ldt,
nvl(lead(a.ldt, 1) over(PARTITION BY a.hk_advisor_cst_cntr_l, a.validfrom ORDER BY a.ldt), DATE '9999-01-01') AS ledt,
a.rsrc,
a.validfrom,
a.validto
FROM edw_data.advisor_cst_cntr_bes a;