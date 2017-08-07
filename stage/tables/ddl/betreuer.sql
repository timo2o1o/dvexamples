DECLARE
   c INT;
BEGIN
   SELECT COUNT(*) INTO c FROM all_tables t WHERE t.owner = UPPER('stage') AND t.table_name = UPPER('betreuer');
   if c = 1 then
      execute immediate 'drop table stage.betreuer';
   end if;
end;
/

CREATE TABLE stage.betreuer
(
seq NUMBER NOT NULL,
ldt DATE NOT NULL,
betreuer CHAR(1) NULL,
kostenstelle NUMBER NULL,
erstellt_zst DATE NULL,
geaendert_zst DATE NULL,
geloescht_zst DATE NULL,
CONSTRAINT betreuer_pk PRIMARY KEY (seq, ldt)
);