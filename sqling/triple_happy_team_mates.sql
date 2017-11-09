SELECT DISTINCT 
b1.yearID AS 'Year', teams.name AS 'Team Name', 
m1.nameFirst AS 'First Name', m1.nameLast AS 'Last Name', b1.3B AS 'Triples', 
m2.nameFirst AS 'Teammate First Name', m2.nameLast AS 'Teammate Last Name', b2.3b AS 'Teammate Triples' 

FROM batting AS b1 

JOIN batting AS b2 ON (b1.teamID = b2.teamID)
JOIN teams ON (teams.teamID = b1.teamID)
JOIN master AS m1 ON (b1.masterID = m1.masterID) 
JOIN master AS m2 ON (b2.masterID = m2.masterID)

WHERE b1.3b > 10
 AND b2.3b > 10
 AND b1.masterID != b2.masterID
 AND b1.yearID = b2.yearID
