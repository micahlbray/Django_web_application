IF OBJECT_ID('tempdb..#a') IS NOT NULL DROP TABLE #a
select b.*, a.Building_Id, a.AddedOn, a.AddedBy, a.Record_Id
into #a
from app_Building as a
	join (
			select address, a.probuild_id, count(1) as ct
			from app_Building as a
				join app_Probuild as b
				on a.Probuild_Id = b.Probuild_Id
			where isnull(a.deleted,0) = 0
				and isnull(legacy,0) = 1
				--and building_id is not null
			group by address, a.probuild_id
			having count(1) > 1
		) as b
	ON a.Address = b.Address and a.Probuild_Id = b.Probuild_Id
where isnull(a.deleted,0) = 0
order by b.Probuild_Id desc

IF OBJECT_ID('tempdb..#b') IS NOT NULL DROP TABLE #b
select	*
		,ROW_NUMBER() OVER(PARTITION BY Address ORDER BY AddedOn) as Row
into	#b
from	#a

select *
from #b
where ct = 2
order by Probuild_Id, address

/*
delete
from app_Building
where record_id IN (select Record_Id
					from #b
					where ct = 2
						and row = 1
						and addedby IS NULL
					)
*/

select *
from #b
where ct > 2




