SELECT t.name AS 'Team Name', t.W AS 'Number of Wins'
FROM teams as t
WHERE t.yearID >= 1970 
 AND t.yearID <= 1979 
 AND t.lgID = 'NL'
 AND t.W = (SELECT (CEILING(SUM(t.W)/COUNT(*))) 
FROM teams AS t 
WHERE t.yearID >= 1970 AND t.yearID <= 1979 AND t.lgID = 'NL') OR t.W = 
(SELECT (FLOOR(SUM(t.W)/COUNT(*))) 
FROM teams AS t 
WHERE t.yearID >= 1970 AND t.yearID <= 1979 AND t.lgID = 'NL')
