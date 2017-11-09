SELECT t.name AS 'Team Name', managers.yearID AS 'Year', m2.nameFirst AS 'Pitcher First Name', m2.nameLast AS 'Pitcher Last Name',
 m1.nameFirst AS 'Manager First Name', m1.nameLast AS 'Manager Last Name'
FROM managers 
 JOIN master AS m1 ON (managers.masterID = m1.masterID) 
 JOIN pitching AS p ON (managers.teamID = p.teamID and managers.yearID = p.yearID)
 JOIN teams AS t ON (managers.teamID = t.teamID)
 JOIN master AS m2 ON (p.masterID = m2.masterID)
where m1.nameFirst = 'Casey' and m1.nameLast = 'Stengel' GROUP BY managers.yearID, m2.nameFirst, m2.nameLast

ORDER BY managers.yearID