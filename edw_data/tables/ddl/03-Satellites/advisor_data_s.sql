DECLARE
   c INT;
BEGIN
   SELECT COUNT(*) INTO c FROM all_tables t WHERE t.owner = UPPER('edw_data') AND t.table_name = UPPER('advisor_data_s');
   if c = 1 then
      execute immediate 'drop table edw_data.advisor_data_s';
   end if;
end;
/

CREATE TABLE edw_data.advisor_data_s
(
hk_advisor_h CHAR(40) NOT NULL,
ldt DATE NOT NULL,
rsrc VARCHAR2(100) NULL,
hashdiff CHAR(40) NOT NULL,
created_dt DATE NULL,
changed_dt DATE NULL,
deleted_dt DATE NULL,
CONSTRAINT advisor_data_s_pk PRIMARY KEY (hk_advisor_h, ldt)
);

ALTER TABLE edw_data.advisor_data_s ADD CONSTRAINT advisor_data_s_fk01
FOREIGN KEY (hk_advisor_h) REFERENCES edw_data.advisor_h (hk_advisor_h)
DISABLE NOVALIDATE;

ALTER TABLE edw_data.advisor_data_s MODIFY CONSTRAINT advisor_data_s_fk01 RELY;