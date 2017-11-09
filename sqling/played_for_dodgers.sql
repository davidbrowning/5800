
select distinct master.nameFirst, master.nameLast from master, appearances, teams 
where master.masterID = appearances.masterID 
and appearances.teamID in (select teams.teamID from teams where teams.name = 'Los Angeles Dodgers') 

order by master.nameLast