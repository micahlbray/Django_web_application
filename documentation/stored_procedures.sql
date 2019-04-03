select * 
  from information_schema.routines 
 where routine_type = 'PROCEDURE' 
	and SPECIFIC_SCHEMA = 'miBuilds'
   and Left(Routine_Name, 3) NOT IN ('sp_', 'xp_', 'ms_')