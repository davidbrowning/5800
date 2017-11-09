/* Exists v not exists 
if subquery is completely empty, not exists is true
if subquery returns ANYTHING, exists is true 

Correlated subquery - use a table variable from outer query. Reevaluated for every tuple in outer query. 

 correlated subquery is another way to write a join.
*/

/*
Windowing function

Select masterID, RANK() over order by HR from batting 

ONLY EXISTS IN POSTGRES! 