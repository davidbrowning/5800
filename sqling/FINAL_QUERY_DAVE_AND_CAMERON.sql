-- Cameron Cummings
-- Dave Browning
-- SQL Assignment

-- Query 1 - LA Dodgers
-- List the first name and last name of every player that has played at any time
-- in their career for the Los Angeles Dodgers.  List each player only once.

SELECT master."nameFirst", master."nameLast"
FROM master JOIN appearances ON (master."masterID" = appearances."masterID")
JOIN teams ON (appearances."teamID" = teams."teamID")
WHERE teams."name" = 'Los Angeles Dodgers';

-- Query 2 - LA Dodgers Only
-- List the first name and last name of of every player that has played only for the Los Angeles
-- Dodgers (i.e., they did not play for any other team including the Brooklyn Dodgers, note that
-- the Brooklyn Dodgers became the Los Angeles Dodgers in the 1950s). 
-- List each player only once. 

SELECT DISTINCT master."nameFirst", master."nameLast"
FROM master JOIN appearances ON (master."masterID" = appearances."masterID")
JOIN teams ON (appearances."teamID" = teams."teamID")
WHERE teams."name" = 'Los Angeles Dodgers' AND master."masterID" 
NOT IN (SELECT DISTINCT master."masterID"
       FROM master JOIN appearances ON (master."masterID" = appearances."masterID")
    JOIN teams on (appearances."teamID" = teams."teamID")
    WHERE teams."name" != 'Los Angeles Dodgers')
ORDER BY master."nameLast";

-- Query 3 - Expos Pitchers
-- List the first name and last name of every player that has pitched for the team named
-- the "Montreal Expos". List each player only once.

SELECT DISTINCT master."nameFirst", master."nameLast"
FROM master JOIN pitching ON (master."masterID" = pitching."masterID")
JOIN teams ON (pitching."teamID" = teams."teamID")
WHERE teams."name" = 'Montreal Expos'
ORDER BY master."nameLast";





-- Query 4 - Error Kings
-- List the name of the team, year, and number of errors (the number is 
-- the "E" column in the "teams" table) for every team that has had 160 or more errors
-- in a season.

SELECT DISTINCT teams."name", teams."yearID", teams."E"
FROM teams
WHERE teams."E" > 159
ORDER BY teams."yearID";

-- Query 5 - USU batters
-- List the first name, last name, year played, 
-- and batting average (h/ab) of every player
-- from the school named "Utah State University".

SELECT DISTINCT ROUND(batting."H"/NULLIF(batting."AB" + 0.0, 0),4) AS "Average", batting."H",batting."AB", master."nameFirst", master."nameLast", batting."yearID"
FROM master
 JOIN schoolsplayers ON (master."masterID" = schoolsplayers."masterID")
 JOIN batting ON (batting."masterID" = master."masterID")
WHERE schoolsplayers."schoolID" = (SELECT distinct "schoolID" FROM schools WHERE schools."schoolName" = 'Utah State University') AND batting."AB" IS NOT NULL
ORDER BY "yearID";


-- Query 6 - Yankee Run Kings
-- List the name, year, and number of home runs hit for each New York Yankee batter, 
-- but only if they hit the most home runs for any player in that season. 

SELECT DISTINCT master."nameFirst", master."nameLast", batting."yearID", batting."HR"
FROM master JOIN batting ON (master."masterID" = batting."masterID") JOIN teams
    ON (batting."teamID" = teams."teamID")
WHERE teams."name" = 'New York Yankees' AND (batting."yearID", batting."HR") IN
(SELECT DISTINCT batting."yearID", MAX(batting."HR") as "homeRuns"
FROM batting
GROUP BY batting."yearID")
ORDER BY batting."yearID";

-- Query 7 - Bumper Salary Teams 
-- List the total salary for two consecutive years, team name, and year 
-- for every team that had a total salary 
-- which was 1.5 times as much as for the previous year.

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

-- Query 8 - Montreal Expos Three
-- List the first name and last name of every player that has batted for the Montreal Expos in at
-- least three consecutive years. List each player only once.

SELECT DISTINCT master."nameFirst", master."nameLast"
FROM master JOIN
(SELECT DISTINCT b1."masterID", b1."teamID"
    FROM batting AS b1
    JOIN batting AS b2 ON (b1."yearID"+1 = b2."yearID" AND b1."masterID" = b2."masterID" AND b2."teamID" = 'MON')
    JOIN batting AS b3 ON (b1."yearID"+2 = b3."yearID" AND b1."masterID" = b3."masterID" AND b3."teamID" = 'MON')
    WHERE b1."teamID" = 'MON') AS batters
    ON (master."masterID" = batters."masterID")
JOIN teams ON (batters."teamID" = teams."teamID")
WHERE teams."name" = 'Montreal Expos'
ORDER BY master."nameLast";

-- Query 9 - Home Run Kings
-- List the first name, last name, year, and number of HRs of every player 
-- that has hit the most home runs in a single season. 
-- Order by the year

SELECT m."nameFirst", m."nameLast", batting."yearID", h
FROM batting
JOIN (SELECT "yearID", MAX("HR") as h
FROM batting
GROUP BY "yearID") AS m_hr ON (m_hr."yearID" = batting."yearID" AND m_hr.h = batting."HR")
JOIN (SELECT DISTINCT "masterID", "nameFirst", "nameLast" FROM master) AS m ON (m."masterID" = batting."masterID")
ORDER BY batting."yearID";

-- Query 10 - Third best home runs each year
-- List the first name, last name, year, and number of HRs of every player that hit
-- the third most home runs for that year. Order by the year.

SELECT master."nameFirst", master."nameLast", batting."yearID", batting."HR"
FROM master JOIN batting ON (master."masterID" = batting."masterID")
WHERE batting."HR" IS NOT NULL
ORDER BY batting."HR" DESC
LIMIT 1 OFFSET 2;

-- Query 11 - Triple happy team mates 
-- List the team name, year, names of player, 
-- the number of triples hit (column "3B" in the batting table), 
-- in which two or more players on the same team hit 10 or more triples each
-- (includes b1:b2 and b2:b1 relationships will come back if time permits and refine)

SELECT DISTINCT b1."yearID", t1."name", m1."nameFirst", m1."nameLast", b1."3B", m2."nameFirst", m2."nameLast",
b2."teamID", b2."yearID", b2."3B"
FROM batting AS b1
JOIN (SELECT DISTINCT "name", "teamID", "yearID" FROM teams) AS t1 ON (t1."teamID" = b1."teamID" AND t1."yearID" = b1."yearID")
JOIN (SELECT DISTINCT "masterID", "nameFirst", "nameLast" FROM master) AS m1 ON (b1."masterID" = m1."masterID")
JOIN batting AS b2 ON (b1."yearID" = b2."yearID" AND b1."teamID" = b2."teamID" AND b2."3B" > 10 AND b1."masterID" < b2."masterID")
JOIN (SELECT DISTINCT "masterID", "nameFirst", "nameLast" FROM master) AS m2 ON (b2."masterID" = m2."masterID")

WHERE b1."3B" > 10
ORDER BY b1."yearID";

-- Query 12 - Ranking the teams
-- Rank each team in terms of the winning percentage (wins divided by (wins + losses)) over
-- its entire history. Consider a "team" to be a team with the same name, so if the team
-- changes name, it is considered to be two different teams. Show the team name, 
-- win percentage, and the rank.

SELECT name, rank() over (ORDER BY win_percent DESC) AS "Rank", win_percent, total_win, total_loss
FROM (
SELECT DISTINCT teams."name", CAST(team_totals."total_win" AS FLOAT)/team_totals."total_games" AS win_percent, 
team_totals."total_win", team_totals."total_loss"
FROM teams JOIN (
    SELECT teams."name", SUM(teams."W") AS total_win, SUM(teams."L") AS total_loss, SUM(teams."W")+SUM(teams."L") AS total_games
    FROM teams
    GROUP BY teams."name"
) AS team_totals ON (teams."name" = team_totals."name")) AS team_results;

-- Query 13 - Pitchers for Manager Casey Stengel 
-- List the year, first name, and last name of each pitcher 
-- who was a on a team managed by Casey Stengel 
-- postgres

SELECT managers."yearID", mnames."nameFirst", mnames."nameLast" FROM managers
JOIN pitching
 ON (managers."teamID" = pitching."teamID"
 AND managers."yearID" = pitching."yearID")
JOIN (SELECT master."nameFirst", master."nameLast", master."masterID"
 FROM master) AS mnames
 ON (pitching."masterID" = mnames."masterID")
WHERE managers."masterID" =
 (SELECT DISTINCT master."masterID"
  FROM master
  WHERE master."nameLast" = 'Stengel'
  AND master."nameFirst" = 'Casey')

 ORDER BY managers."yearID";

-- Query 14 - Two Degrees from Yogi Berra
-- List the name of each player who appeared on a team with a player that was at one time
-- was a teammate of Yogi Berra. So suppose player A was a teammate of Yogi Berra.
-- Then player A is one-degree of separation from Yogi Berra. Let player B be related to 
-- player A because B played on a team in the same year with player A. Then player B
-- is two-degrees of separation from player A.
-- Note: takes 36 secs to run 


SELECT DISTINCT player_b."nameFirst", player_b."nameLast"
FROM (
SELECT DISTINCT master."masterID", master."nameLast", master."nameFirst", teams."name", appearances."yearID"
FROM master JOIN appearances ON (master."masterID" = appearances."masterID")
JOIN teams ON (appearances."teamID" = teams."teamID" AND appearances."yearID" = teams."yearID")) AS player_B
JOIN (
SELECT player."masterID", player."name", player."yearID"
FROM (
SELECT DISTINCT master."masterID", teams."name", appearances."yearID"
FROM master JOIN appearances ON (master."masterID" = appearances."masterID")
JOIN teams ON (appearances."teamID" = teams."teamID" AND appearances."yearID" = teams."yearID")) AS player
JOIN (
SELECT DISTINCT teammate."masterID" 
FROM (SELECT master."masterID", teams."name", appearances."yearID"
FROM master JOIN appearances ON (master."masterID" = appearances."masterID")
JOIN teams ON (appearances."teamID" = teams."teamID")) AS teammate
JOIN (
SELECT DISTINCT master."masterID",teams."name", appearances."yearID"
FROM master JOIN appearances ON (master."masterID" = appearances."masterID")
JOIN teams ON (appearances."teamID" = teams."teamID" AND appearances."yearID" = teams."yearID")
WHERE master."nameFirst" = 'Yogi' AND master."nameLast" = 'Berra')
 AS yogi_table
ON (teammate."masterID" != yogi_table."masterID" AND teammate."name" = yogi_table."name"
AND teammate."yearID" = yogi_table."yearID")) AS player_A
ON (player."masterID" = player_A."masterID")) AS p_a
ON (player_B."masterID" != p_a."masterID" AND player_B."name" = p_a."name" AND player_B."yearID" = p_a."yearID")
ORDER BY player_B."nameLast", player_B."nameFirst";

-- Query 15 - Median team wins 
-- For the 1970s, 
-- list the team name for teams 
-- in the National League ("NL") 
-- that had the median number of total wins in the decade (1970-1979 inclusive).
-- Only works in postgres

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
   AND teams."lgID" = 'NL');


