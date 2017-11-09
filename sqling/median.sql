SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY win) AS rn, * 
FROM 
 (SELECT "name", SUM("W") as win FROM teams
WHERE "yearID" >= 1970 AND "yearID" <= 1979 AND "lgID" = 'NL'
GROUP BY "name" ORDER BY win)
 AS wins_sum) AS wsf
 WHERE wsf.rn = 
 (SELECT COUNT(DISTINCT "teamID")/2 
  FROM teams 
  WHERE teams."yearID" >= 1970 
   AND teams."yearID" <= 1979 
   AND teams."lgID" = 'NL')

 

