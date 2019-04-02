select *
from miBuilds.rpt_Probuild_Status_Log

select *
from miBuilds.app_Probuild
where Parent_Probuild_Id is not null

/*
truncate table miBuilds.rpt_Probuild_Status_Log

delete
from miBuilds.app_Probuild
where Parent_Probuild_Id is not null
*/
