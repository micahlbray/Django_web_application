select a.*
into miBuilds.app_Building_legacy_data_issues
from app_building as a
join app_probuild as b on a.probuild_id = b.probuild_id
where legacy = 1
	and a.addedon is null
	and (a.editedon is not null
	or a.deleted is not null)


select a.*, b.*
from app_building as a
join app_probuild as b on a.probuild_id = b.probuild_id
where legacy = 1
	and a.addedon is null

/*
delete a
from app_building as a
join app_probuild as b on a.probuild_id = b.probuild_id
where legacy = 1
	and a.addedon is null
*/

select *
from miBuilds.app_Building_legacy_data_issues as a
join app_Building as b on a.Address = b.Address and a.Probuild_Id = b.Probuild_Id
where b.AddedOn is null
order by a.Record_Id

select *
from mip2.probuild_buildings
where build_name = 'Northcreek Bothell'
order by [Building Address]

select * from app_Building where probuild_id = '2491' order by Building_Id