/* Hitting table HR (homeruns) sub query example */
select * from batting where "HR" = (select max("HR") from batting )