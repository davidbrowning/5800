CREATE OR REPLACE FUNCTION forgetLosers() RETURNS TRIGGER AS $del_loser$
 BEGIN
  IF NEW."L" > 160 THEN
   NEW = NULL;
  END IF;
  RETURN NEW;
 END;
 $del_loser$ LANGUAGE plpgsql;
 

CREATE TRIGGER forgetlosers 
 BEFORE INSERT OR UPDATE ON teams
 FOR EACH ROW EXECUTE PROCEDURE forgetlosers();

 INSERT INTO teams ("L")
  VALUES (190);

-- Returns no results:
 SELECT * 
 FROM teams 
 WHERE "L" > 160
 
 