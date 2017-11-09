select master.nameFirst, master.nameLast

from master 

join appearances on 
(master.masterID = appearances.masterID) 

join teams on (teams.teamID = appearances.teamID)
where teams.name = 'Los Angeles Dodgers'

and 

master.masterID not in 
(select distinct master.masterID
from master join appearances on (master.masterID = appearances.masterID) join teams on (teams.teamID = appearances.teamID)
where teams.name != 'Los Angeles Dodgers')