ALTER TABLE batting
 ADD CHECK ("HR" <= "AB");
 INSERT INTO batting ("masterID","HR","AB")
  VALUES ('someguy89',20,10)