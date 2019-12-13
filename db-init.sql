DO $atw$
DECLARE
    counter INTEGER :=0;
    users text[] := '{learn_sql_1, learn_sql_2, learn_sql_3, learn_sql_4, learn_sql_5, 
                  learn_sql_6, learn_sql_7, learn_sql_8, learn_sql_9, learn_sql_10, 
                  learn_sql_11, learn_sql_12, learn_sql_13, learn_sql_14, learn_sql_15, 
                  learn_sql_16, learn_sql_17, learn_sql_18, learn_sql_19, learn_sql_20,
                  kbm}';
    object_tc TEXT;
    db_name TEXT := 'trainings';
 BEGIN
    LOOP 
      EXIT WHEN counter = 21 ; 
      counter := counter + 1 ; 

      object_tc := users[counter];
     
      IF NOT EXISTS (
        SELECT 1
        FROM   pg_catalog.pg_user
        WHERE  usename = object_tc) THEN

        EXECUTE 'CREATE USER '|| object_tc || ' WITH LOGIN PASSWORD ''' || object_tc || '''  NOSUPERUSER INHERIT NOREPLICATION';
		    EXECUTE 'CREATE SCHEMA IF NOT EXISTS ' || object_tc;
           
        END IF;
       
        EXECUTE 'REVOKE CONNECT ON DATABASE ' || db_name || ' FROM ' || object_tc;
        EXECUTE 'REVOKE ALL PRIVILEGES ON DATABASE ' || db_name || ' FROM ' || object_tc;
        EXECUTE 'GRANT USAGE ON SCHEMA ' || object_tc || ' TO ' || object_tc;
        EXECUTE 'GRANT ALL PRIVILEGES ON SCHEMA ' || object_tc || ' TO ' || object_tc;

    END LOOP ; 

  END;
$atw$ LANGUAGE plpgsql;

-- CHANGE DEFAULT PASSWORD
--ALTER USER user_name WITH PASSWORD 'new_password';