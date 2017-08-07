DECLARE
   c INT;
BEGIN
   SELECT COUNT(*) INTO c FROM all_tables t WHERE t.owner = UPPER('edw_data') AND t.table_name = UPPER('cost_centre_h');
   if c = 1 then
      execute immediate 'drop table edw_data.cost_centre_h';
   end if;
end;
/

CREATE TABLE edw_data.cost_centre_h
(
hk_cost_centre_h CHAR(40) NOT NULL,
ldt DATE NOT NULL,
rsrc VARCHAR2(100) NULL,
cost_centre NUMBER NOT NULL,
CONSTRAINT cost_centre_h_pk PRIMARY KEY (hk_cost_centre_h)
);