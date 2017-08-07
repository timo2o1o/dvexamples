DECLARE
   c INT;
BEGIN
   SELECT COUNT(*) INTO c FROM all_tables t WHERE t.owner = UPPER('edw_data') AND t.table_name = UPPER('advisor_cst_cntr_dks');
   if c = 1 then
      execute immediate 'drop table edw_data.advisor_cst_cntr_dks';
   end if;
end;
/

CREATE TABLE edw_data.advisor_cst_cntr_dks
(
hk_advisor_cst_cntr_l CHAR(40) NOT NULL,
ldt DATE NOT NULL,
rsrc VARCHAR2(100) NULL,
activeYN CHAR(1) NOT NULL,
CONSTRAINT advisor_cst_cntr_dks_pk PRIMARY KEY (hk_advisor_cst_cntr_l, ldt)
);

ALTER TABLE edw_data.advisor_cst_cntr_dks ADD CONSTRAINT advisor_cst_cntr_dks_fk01
FOREIGN KEY (hk_advisor_cst_cntr_l) REFERENCES edw_data.advisor_cst_cntr_l (hk_advisor_cst_cntr_l)
DISABLE NOVALIDATE;

ALTER TABLE edw_data.advisor_cst_cntr_dks MODIFY CONSTRAINT advisor_cst_cntr_dks_fk01 RELY;