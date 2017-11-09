select "yearID", max("HR")
from batting
group by "yearID"