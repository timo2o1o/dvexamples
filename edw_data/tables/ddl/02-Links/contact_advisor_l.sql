DECLARE
   c INT;
BEGIN
   SELECT COUNT(*) INTO c FROM all_tables t WHERE t.owner = UPPER('edw_data') AND t.table_name = UPPER('contact_advisor_l');
   if c = 1 then
      execute immediate 'drop table edw_data.contact_advisor_l';
   end if;
end;
/

CREATE TABLE edw_data.contact_advisor_l
(
hk_contact_advisor_l CHAR(40) NOT NULL,
ldt DATE NOT NULL,
rsrc VARCHAR2(100) NULL,
hk_advisor_h CHAR(40) NOT NULL,
hk_contact_h CHAR(40) NOT NULL,
advisor_type NUMBER   NOT NULL,
CONSTRAINT contact_advisor_l_pk PRIMARY KEY (hk_contact_advisor_l)
);

ALTER TABLE edw_data.contact_advisor_l ADD CONSTRAINT contact_advisor_l_fk01
FOREIGN KEY (hk_advisor_h) REFERENCES edw_data.advisor_h (hk_advisor_h)
DISABLE NOVALIDATE;

ALTER TABLE edw_data.contact_advisor_l MODIFY CONSTRAINT contact_advisor_l_fk01 RELY;

ALTER TABLE edw_data.contact_advisor_l ADD CONSTRAINT contact_advisor_l_fk02
FOREIGN KEY (hk_contact_h) REFERENCES edw_data.contact_h (hk_contact_h)
DISABLE NOVALIDATE;

ALTER TABLE edw_data.contact_advisor_l MODIFY CONSTRAINT contact_advisor_l_fk02 RELY;