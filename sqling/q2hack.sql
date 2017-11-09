select * from appearances 
 group by appearances.masterID 
 having count(appearances.masterID) = 1 
 and teamID = 'LAN' 

