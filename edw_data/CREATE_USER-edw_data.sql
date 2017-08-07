CREATE USER edw_data
  IDENTIFIED BY start
  QUOTA UNLIMITED ON USERS;
  
GRANT create session TO edw_data;
GRANT create table TO edw_data;
GRANT create view TO edw_data;
GRANT create any trigger TO edw_data;
GRANT create any procedure TO edw_data;
GRANT create sequence TO edw_data;
GRANT create synonym TO edw_data;

GRANT unlimited tablespace TO edw_data;