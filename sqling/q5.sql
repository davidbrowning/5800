SELECT DISTINCT ROUND(batting."H"/NULLIF(batting."AB" + 0.0, 0),4) AS "Average", batting."H",batting."AB", master."nameFirst", master."nameLast", batting."yearID"
FROM master
 JOIN schoolsplayers ON (master."masterID" = schoolsplayers."masterID")
 JOIN batting ON (batting."masterID" = master."masterID")
WHERE schoolsplayers."schoolID" = (SELECT distinct "schoolID" FROM schools WHERE schools."schoolName" = 'Utah State University') AND batting."AB" IS NOT NULL
ORDER BY "yearID";
