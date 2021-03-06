---- CHANGE CAR_Value TO Total_CAR_Value for a different look -----

if OBJECT_ID('tempdb..#a') IS NOT NULL DROP TABLE #a
select	probuild_id
		, record_id
		, LAT_CAR_Value
		, row_number() OVER(PARTITION BY probuild_id ORDER BY record_id ASC) as Row
into	#a
from	rpt_probuild
where	isnull(deleted,0) = 0
	--and approved = 1

if OBJECT_ID('tempdb..#b') IS NOT NULL DROP TABLE #b
select	a.*
into	#b
from	#a as a
	join (
			select probuild_id, max(row) as mxrow
			from #a
			group by probuild_id
		) as b
	on a.Probuild_Id = b.Probuild_Id and a.row = b.mxrow
where	mxrow > 1

if OBJECT_ID('tempdb..#c') IS NOT NULL DROP TABLE #c
select	a.*
into	#c
from	#a as a
	join (
			select	probuild_id, row - 1 as row
			from	#b as b
		) as b
	on a.Probuild_Id = b.Probuild_Id and a.row = b.row

if OBJECT_ID('tempdb..#d') IS NOT NULL DROP TABLE #d
select	b.Probuild_Id
		,b.LAT_CAR_Value as CAR_Value_New
		,c.LAT_CAR_Value as CAR_Value_Old
		,b.LAT_CAR_Value/c.LAT_CAR_Value as Pct_CAR_Change
into	#d
from	#b as b
	join #c as c
	on b.Probuild_Id = c.Probuild_Id
where c.LAT_CAR_Value <> 0
	and b.LAT_CAR_Value/c.LAT_CAR_Value > 1.1

UNION ALL

select b.Probuild_Id
		,b.LAT_CAR_Value as CAR_Value_New
		,c.LAT_CAR_Value as CAR_Value_Old
		,c.LAT_CAR_Value/b.LAT_CAR_Value as Pct_CAR_Change
from	#b as b
	join #c as c
	on b.Probuild_Id = c.Probuild_Id
where b.LAT_CAR_Value <> 0
	and c.LAT_CAR_Value/b.LAT_CAR_Value > 1.1

select app.Probuild_Id, app.Name, reg.Name as Region, d.CAR_Value_New, d.CAR_Value_Old, d.Pct_CAR_Change
from	#d as d
	join app_Probuild as app
	ON d.Probuild_Id = app.Probuild_Id
	join lk_Region as reg
	ON app.Region_Id = reg.Region_Id

/*
delete
from rpt_Probuild
where record_id IN (11172)
*/