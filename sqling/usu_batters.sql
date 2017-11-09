select distinct schoolsplayers.schoolID, (batting.H/batting.AB), batting.H ,batting.AB, master.nameFirst, master.nameLast, batting.yearID
from master join schoolsplayers on (master.masterID = schoolsplayers.masterID) join batting on (batting.masterID = master.masterID)
where schoolsplayers.schoolID = (select distinct schoolID from schools where schools.schoolName = 'Utah State University') and batting.AB is not null

order by yearID
