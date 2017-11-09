SELECT t.name AS 'Team Name', t.W AS 'Number of Wins'
FROM teams AS t 
WHERE t.yearID >= 1970 AND t.yearID <= 1979 AND t.lgID = 'NL' and t.W = 81
ORDER BY t.W
