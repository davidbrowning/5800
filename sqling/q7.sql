SELECT DISTINCT teams."name" , teams."lgID" , total_year1."yearID",
 total_year1.Team_Salary , total_year2."yearID", total_year2.Team_Salary ,
  FLOOR((total_year2.Team_Salary/total_year1.Team_Salary) * 100)

FROM 
 (SELECT SUM(s."salary") AS Team_Salary, s."teamID", s."yearID" 
  FROM salaries AS s GROUP BY s."teamID", s."yearID") AS total_year1
JOIN 
 (SELECT SUM(s."salary") AS Team_Salary, s."teamID", s."yearID" 
  FROM salaries AS s GROUP BY s."teamID", s."yearID") AS total_year2
  
ON (total_year1."yearID" + 1 = total_year2."yearID"
 AND total_year1."teamID" = total_year2."teamID"
 AND total_year2.Team_Salary >= total_year1.Team_Salary * 1.5 )
JOIN teams ON (total_year1."teamID" = teams."teamID" AND total_year2."teamID" = teams."teamID" 
 AND teams."yearID" = total_year1."yearID")
 ORDER BY total_year2."yearID";
