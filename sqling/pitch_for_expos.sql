select distinct 
master.nameFirst, master.nameLast
from master join pitching on (master.masterID = pitching.masterID) join teams on (teams.teamID = pitching.teamID)
where teams.name = 'Montreal Expos'

order by master.nameLast
