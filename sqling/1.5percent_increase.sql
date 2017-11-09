SELECT DISTINCT teams.name AS 'Team Name', teams.lgID AS 'League', total_year1.yearID 
 AS 'Previous Year', total_year1.Team_Salary AS 'Previous Salary', total_year2.yearID 
 AS 'Year', total_year2.Team_Salary AS 'Salary', ((total_year2.Team_Salary/total_year1.Team_Salary) * 100) AS 'Percent Increase'
 FROM (SELECT SUM(s.salary) AS Team_Salary, s.teamID, s.yearID FROM salaries AS s GROUP BY s.teamID, s.yearID) AS total_year1 
JOIN (select SUM(s.salary) AS Team_Salary, s.teamID, s.yearID FROM salaries AS s GROUP BY s.teamID, s.yearID) AS total_year2 
ON (total_year1.yearID + 1 = total_year2.yearID 
 AND total_year1.teamID = total_year2.teamID 
 AND total_year2.Team_Salary >= total_year1.Team_Salary * 1.5 ) 
 
JOIN teams ON (total_year1.teamID = teams.teamID) ORDER BY total_year2.yearID