select * 
  from BI_MIP.information_schema.routines 
 where ROUTINE_TYPE = 'PROCEDURE'
	and SPECIFIC_SCHEMA = 'miBuilds' 
	and ROUTINE_DEFINITION like '%BI_MIP_Dev.%'