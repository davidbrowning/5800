select master.nameFirst, master.nameLast
from master join appearances on (master.masterID = appearances.masterID) join teams on (teams.teamID = appearances.teamID)
where teams.name = 'Los Angeles Dodgers'
