CREATE USER stage
  IDENTIFIED BY start
  QUOTA UNLIMITED ON USERS;
  
GRANT create session TO stage;
GRANT create table TO stage;
GRANT create view TO stage;
GRANT create any trigger TO stage;
GRANT create any procedure TO stage;
GRANT create sequence TO stage;
GRANT create synonym TO stage;

grant execute on sys.dbms_crypto to stage;

GRANT unlimited tablespace TO stage;