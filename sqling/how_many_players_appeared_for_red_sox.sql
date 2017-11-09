/*select * from teams where "teamID" = 'LAN'*/

/*select * from teams where name = 'Boston Red Sox'*/

/*

select "teamID" from teams where name = 'Boston Red Sox'

*/


(select count (distinct "masterID") from appearances where "teamID" = 
(select distinct "teamID" from teams where name = 'Boston Red Sox'))
