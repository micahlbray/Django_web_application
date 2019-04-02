update a
set		Total_CAR_Value = CAR_Value
from	rpt_Probuild as a
join app_Probuild as b
on a.Probuild_Id = b.Probuild_Id
WHERE b.ROW_Est_Build_Cost > 0
	and a.Total_CAR_Value IS NOT NULL
	and b.Legacy = 1
	
update a
set		ROW_CAR_Value = 
			ISNULL(b.ROW_Est_Build_Cost,0)
			+ ISNULL(b.HeadEnd_Cost,0)
			+ ISNULL(b.Transport_Cost,0)
from	rpt_Probuild as a
join app_Probuild as b
on a.Probuild_Id = b.Probuild_Id
WHERE b.ROW_Est_Build_Cost > 0
	and a.Total_CAR_Value IS NOT NULL
	and b.Legacy = 1

update a
set		Lat_CAR_Value = ISNULL(Total_CAR_Value,0) - ISNULL(ROW_CAR_Value,0)
from	rpt_Probuild as a
join app_Probuild as b
on a.Probuild_Id = b.Probuild_Id
WHERE b.ROW_Est_Build_Cost > 0
	and a.Total_CAR_Value IS NOT NULL
	and b.Legacy = 1

-----------------------------------------------------------------------------
-------  MAKE SURE LEGACY COSTS ARE CORRECT ----------
-----------------------------------------------------------------------------
UPDATE	b
SET		b.ROW_Est_Build_Cost = a.ROW_Est_Build_Cost
		,b.HeadEnd_Cost = a.HeadEnd_Cost
		,b.Transport_Cost = a.Transport_Cost
FROM MIP2.PROBUILD_summary_mbray201_20180712_backup as a
	JOIN app_Probuild as b
	ON a.Build_Name = b.Name
WHERE	b.Legacy = 1
		AND	(EditedOn IS NULL
			OR EditedOn < ApprovedOn)	

/*select *
from app_Probuild
where approved = 1
order by ApprovedOn desc

select *
from rpt_Probuild
where Probuild_Id IN (857
,600
)
order by probuild_id

update a
set		Total_CAR_Value = CAR_Value
		,ROW_CAR_Value = 
			ISNULL(b.ROW_Est_Build_Cost,0)
			+ ISNULL(b.HeadEnd_Cost,0)
			+ ISNULL(b.Transport_Cost,0)
from	rpt_Probuild as a
join app_Probuild as b
on a.Probuild_Id = b.Probuild_Id
where Record_Id = 7045

update a
set		Lat_CAR_Value = ISNULL(Total_CAR_Value,0) - ISNULL(ROW_CAR_Value,0)
from	rpt_Probuild as a
where Record_Id = 7045


delete 
from rpt_Probuild
where record_id = 10926
*/

