/*select * from appearances a, (select "teamID","yearID" from teams where name = 'Atlanta Braves') t where t."teamID" = a."teamID" and t."yearID" = a."yearID"

^^ this works */

select * from appearances a
 where "G_batting" > 150 and exists
 (select "teamID", "yearID"
   from teams t where 
    name = 'Atlanta Braves'
   and t."teamID" = a."teamID" and t."yearID" = a."yearID")