select "yearID", max("HR")
from batting
group by "yearID"
having max ("HR") > 50