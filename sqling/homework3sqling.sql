/* Q1 Players who played for the dodgers */

SELECT distinct master.nameFirst, master.nameLast FROM master, appearances, teams 

WHERE master.masterID = appearances.masterID 
 
and appearances.teamID in (SELECT teams.teamID FROM teams WHERE teams.name = 'Los Angeles Dodgers') order by master.nameLast

/* Q2 Players who only played for the dodgers WARNING: MUST USE POSTGRESQL, TIMED OUT ON mysql*/

SELECT distinct master."nameFirst", master."nameLast"

FROM master 

JOIN appearances on 
(master."masterID" = appearances."masterID") 

JOIN teams on (teams."teamID" = appearances."teamID")
WHERE teams."name" = 'Los Angeles Dodgers'

and 

master."masterID" not in 
(SELECT distinct master."masterID"
FROM master JOIN appearances on (master."masterID" = appearances."masterID") JOIN teams on (teams."teamID" = appearances."teamID")
WHERE teams."name" != 'Los Angeles Dodgers')

order by "nameLast"

/* Q3 Pitchers for Montreal Expos */
SELECT distinct 
master.nameFirst, master.nameLast 

FROM master 
 JOIN pitching on (master.masterID = pitching.masterID) 
 JOIN teams on (teams.teamID = pitching.teamID)


WHERE teams.name = 'Montreal Expos'

order by master.nameLast

/* Q4 Errors >= 160 */
SELECT name, yearID, E FROM teams WHERE E >= 160
 order by yearID

/* Q5 USU Batters */
SELECT DISTINCT schoolsplayers.schoolID, (batting.H/batting.AB), batting.H ,batting.AB, master.nameFirst, master.nameLast, batting.yearID 

FROM master 
 JOIN schoolsplayers on (master.masterID = schoolsplayers.masterID) 
 JOIN batting on (batting.masterID = master.masterID)


WHERE schoolsplayers.schoolID = 
(SELECT distinct schoolID FROM schools 
WHERE schools.schoolName = 'Utah State University')
 
 AND batting.AB IS NOT NULL

ORDER BY yearID
