CREATE OR REPLACE VIEW edw_data.v_advisor_data_s AS
SELECT
a.hk_advisor_h,
a.ldt,
nvl(lead(a.ldt, 1) over(PARTITION BY a.hk_advisor_h ORDER BY a.ldt), DATE '9999-01-01') AS ledt,
a.rsrc,
a.hashdiff,
a.created_dt,
a.changed_dt,
a.deleted_dt
FROM edw_data.advisor_data_s a;