/*
 * Diese Funktion "emuliert" die Verfuegbarkeit der Oraclefunktion "STANDARD_HASH" zur Generierung von Hashwerten.
 * Die Funktion steht erst ab der Datenbankversion 12c zur Verfuegung.
 */

CREATE OR REPLACE 
FUNCTION standard_hash (v_input VARCHAR2) RETURN RAW DETERMINISTIC
AS
   --PRAGMA UDF;
BEGIN
   RETURN dbms_crypto.hash(utl_raw.cast_to_raw(v_input), dbms_crypto.HASH_SH1);
END standard_hash;