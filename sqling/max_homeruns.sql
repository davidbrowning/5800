select B."masterID", B."HR"
from (select max("HR") as m
from batting) T, batting B
where T."m" = B."HR"

/* Group by "thing" <---- thing is the only thing that should be in the query */

/* NOTHING IN SELECT CLAUSE group something...."*/