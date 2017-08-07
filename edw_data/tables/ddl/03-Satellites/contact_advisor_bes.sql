DECLARE
   c INT;
BEGIN
   SELECT COUNT(*) INTO c FROM all_tables t WHERE t.owner = UPPER('edw_data') AND t.table_name = UPPER('contact_advisor_bes');
   if c = 1 then
      execute immediate 'drop table edw_data.contact_advisor_bes';
   end if;
end;
/

CREATE TABLE edw_data.contact_advisor_bes
(
hk_contact_advisor_l CHAR(40) NOT NULL,
ldt DATE NOT NULL,
rsrc VARCHAR2(100) NULL,
validfrom DATE NOT NULL,
validto DATE NOT NULL,
CONSTRAINT contact_advisor_bes_pk PRIMARY KEY (hk_contact_advisor_l, ldt, validfrom)
);

ALTER TABLE edw_data.contact_advisor_bes ADD CONSTRAINT contact_advisor_bes_fk01
FOREIGN KEY (hk_contact_advisor_l) REFERENCES edw_data.contact_advisor_l (hk_contact_advisor_l)
DISABLE NOVALIDATE;

ALTER TABLE edw_data.contact_advisor_bes MODIFY CONSTRAINT contact_advisor_bes_fk01 RELY;