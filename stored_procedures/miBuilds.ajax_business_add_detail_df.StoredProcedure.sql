USE [BI_MIP]
GO
/****** Object:  StoredProcedure [miBuilds].[ajax_business_add_detail_df]    Script Date: 1/8/2019 2:54:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [miBuilds].[ajax_business_add_detail_df]
		@probuild_id int
as

--DECLARE @probuild_id int = 234

;WITH
	
	cteUnmatchedFlag (Record_Id)
	AS
	(
		SELECT	a.Record_Id
		FROM	BI_MIP.miBuilds.app_Business as a
		WHERE	a.Probuild_Id = @probuild_id
				and ISNULL(a.Deleted,0) = 0
				and NOT EXISTS(SELECT Building_Id 
								FROM BI_MIP.miBuilds.app_Building as b 
								WHERE a.Building_Id = b.Building_Id 
									and ISNULL(b.Deleted,0) = 0)
	),

	cteRoeFlag (Record_Id, RoeFlag)
	AS
	(
		SELECT	a.Record_Id
				,RoeFlag = 
					CASE
						WHEN b.pramata_number IS NULL THEN 1
						ELSE 0
					END
		FROM	app_Business as a
			LEFT JOIN (
					SELECT DISTINCT 
							pramata_number 
					FROM	MIP2.PRAMATA_NUMBER as a
					WHERE	ISNULL(a.is_deleted, 'False') = 'False'
				) as b
			ON a.ROE_Id = b.pramata_number
		WHERE	a.Probuild_Id = @probuild_id 
				and ISNULL(a.Deleted,0) = 0
				and b.pramata_number IS NULL
	)

SELECT	DISTINCT
		biz.Record_Id
		--,biz.ProBuild_Id
		,biz.Business_Id
		,Building_Id
		,Business_Name
		,Address_1
		,Address_2
		,City
		,st.Name as State
		,Zip
		,Sellability_Color_Coax as Coax_Color
		,Sellability_Color_Fiber as Fiber_Color
		,MIP_In_Or_Out as In_Or_Out
		,seg.Name as Segment
		,rev_seg.Name as Revised_Segment
		,Revised_Segment_Notes
		,ROE_Id
		,UnmatchedFlag = IIF(cteUnmatchedFlag.Record_Id IS NOT NULL, 1, 0)
		,RoeFlag = ISNULL(RoeFlag, 0)
FROM	BI_MIP.miBuilds.app_Business as biz
		LEFT JOIN lk_State as st
		ON biz.State_Id = st.State_Id
		LEFT JOIN lk_Segment_Type as seg
		ON biz.Segment_Type_Id = seg.Segment_Type_Id
		LEFT JOIN lk_Segment_Type as rev_seg
		ON biz.Revised_Segment_Type_Id = rev_seg.Segment_Type_Id
		LEFT JOIN cteUnmatchedFlag
		ON biz.Record_Id = cteUnmatchedFlag.Record_Id
		LEFT JOIN cteRoeFlag
		ON biz.Record_Id = cteRoeFlag.Record_Id
WHERE	ISNULL(biz.Deleted, 0) = 0
		AND biz.Probuild_Id = @probuild_id
ORDER BY biz.Record_Id
GO
