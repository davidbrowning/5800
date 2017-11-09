ALTER TABLE teams 
 ADD CONSTRAINT WITH NOCHECK check_league CHECK ("lgID" IN ('NL' ,'AL'));
--INSERT INTO teams ("lgID")
  --VALUES ('AP')