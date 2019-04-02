delete
from miBuilds.app_Building
where probuild_id in (select probuild_id 
						from app_Probuild
		where spectrum_job_id = '{23c1b857-4291-4b72-bc5a-fa0aa95e09e8}')

delete
from miBuilds.app_Business
where probuild_id in (select probuild_id 
						from app_Probuild
		where spectrum_job_id = '{23c1b857-4291-4b72-bc5a-fa0aa95e09e8}')
		
		
delete 
from miBuilds.app_Probuild
where spectrum_job_id = '{23c1b857-4291-4b72-bc5a-fa0aa95e09e8}'


select *
from miBuilds.app_Probuild
where probuild_id in (select probuild_id 
						from app_Probuild
		where spectrum_job_id = '{23c1b857-4291-4b72-bc5a-fa0aa95e09e8}')
