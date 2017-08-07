DECLARE
   c INT;
BEGIN
   SELECT COUNT(*) INTO c FROM all_tables t WHERE t.owner = UPPER('edw_data') AND t.table_name = UPPER('advisor_cst_cntr_l');
   if c = 1 then
      execute immediate 'drop table edw_data.advisor_cst_cntr_l';
   end if;
end;
/

CREATE TABLE edw_data.advisor_cst_cntr_l
(
hk_advisor_cst_cntr_l CHAR(40) NOT NULL,
ldt DATE NOT NULL,
rsrc VARCHAR2(100) NULL,
hk_advisor_h CHAR(40) NOT NULL,
hk_cost_centre_h CHAR(40) NOT NULL,
CONSTRAINT advisor_cst_cntr_l_pk PRIMARY KEY (hk_advisor_cst_cntr_l)
);

ALTER TABLE edw_data.advisor_cst_cntr_l ADD CONSTRAINT advisor_cst_cntr_l_fk01
FOREIGN KEY (hk_advisor_h) REFERENCES edw_data.advisor_h (hk_advisor_h)
DISABLE NOVALIDATE;

ALTER TABLE edw_data.advisor_cst_cntr_l MODIFY CONSTRAINT advisor_cst_cntr_l_fk01 RELY DISABLE;

ALTER TABLE edw_data.advisor_cst_cntr_l ADD CONSTRAINT advisor_cst_cntr_l_fk02
FOREIGN KEY (hk_cost_centre_h) REFERENCES edw_data.cost_centre_h (hk_cost_centre_h)
DISABLE NOVALIDATE;

ALTER TABLE edw_data.advisor_cst_cntr_l MODIFY CONSTRAINT advisor_cst_cntr_l_fk02 RELY DISABLE;