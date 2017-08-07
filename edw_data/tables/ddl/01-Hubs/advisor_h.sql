DECLARE
   c INT;
BEGIN
   SELECT COUNT(*) INTO c FROM all_tables t WHERE t.owner = UPPER('edw_data') AND t.table_name = UPPER('advisor_h');
   if c = 1 then
      execute immediate 'drop table edw_data.advisor_h';
   end if;
end;
/

CREATE TABLE edw_data.advisor_h
(
hk_advisor_h CHAR(40) NOT NULL,
ldt DATE NOT NULL,
rsrc VARCHAR2(100) NULL,
advisor CHAR(1) NOT NULL,
CONSTRAINT advisor_h_pk PRIMARY KEY (hk_advisor_h)
);