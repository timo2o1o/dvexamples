DECLARE
   c INT;
BEGIN
   SELECT COUNT(*) INTO c FROM all_tables t WHERE t.owner = UPPER('edw_data') AND t.table_name = UPPER('contact_h');
   if c = 1 then
      execute immediate 'drop table edw_data.contact_h';
   end if;
end;
/

CREATE TABLE edw_data.contact_h
(
hk_contact_h CHAR(40) NOT NULL,
ldt DATE NOT NULL,
rsrc VARCHAR2(100) NULL,
contact NUMBER NOT NULL,
CONSTRAINT contact_h_pk PRIMARY KEY (hk_contact_h)
);