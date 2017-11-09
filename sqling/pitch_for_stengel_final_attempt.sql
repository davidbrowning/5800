SELECT managers."yearID", mnames."nameFirst", mnames."nameLast" FROM managers 
JOIN pitching 
 ON (managers."teamID" = pitching."teamID" 
 AND managers."yearID" = pitching."yearID")
JOIN (SELECT master."nameFirst", master."nameLast", master."masterID" 
 FROM master) AS mnames
 ON (pitching."masterID" = mnames."masterID")
WHERE managers."masterID" = 
 (SELECT DISTINCT master."masterID"
  FROM master 
  WHERE master."nameLast" = 'Stengel'
  AND master."nameFirst" = 'Casey') 

 ORDER BY managers."yearID"