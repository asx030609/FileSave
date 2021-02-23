DECLARE 
      p_grantee       VARCHAR2   (30)   :=   'C##TEST'; 
BEGIN 
      FOR   rec   IN   (SELECT   object_name,   object_type 
                                        ,   DECODE   (object_type 
                                                        ,   'TABLE ',   'ALL ' 
                                                        ,   'VIEW ',   'SELECT ' 
                                                        ,   'EXECUTE ' 
                                                          )   grant_type 
                              FROM       user_objects) 
      LOOP 
            BEGIN 
                  EXECUTE   IMMEDIATE   'grant   all   on   '   ||   rec.object_name   ||   '   to   '   ||   p_grantee; 
            EXCEPTION 
                  WHEN   OTHERS 
                  THEN 
                        dbms_output.put_line   (SUBSTR   (SQLERRM,   1,   240)); 
            END; 
      END   LOOP; 
END;