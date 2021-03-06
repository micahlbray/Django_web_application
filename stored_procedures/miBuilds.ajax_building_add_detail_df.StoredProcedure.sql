USE [BI_MIP]
GO
/****** Object:  StoredProcedure [miBuilds].[ajax_building_add_detail_df]    Script Date: 1/8/2019 2:54:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [miBuilds].[ajax_building_add_detail_df]
		@probuild_id int
as

--DECLARE @probuild_id int = 4895

;WITH
	
	cteUnmatchedFlag (Record_Id)
	AS
	(
		SELECT	a.Record_Id
		FROM	BI_MIP.miBuilds.app_Building as a
		WHERE	a.Probuild_Id = @probuild_id 
				and ISNULL(a.Deleted,0) = 0
				and NOT EXISTS (SELECT Building_Id 
								FROM BI_MIP.miBuilds.app_Business as b 
								WHERE a.Building_Id = b.Building_Id 
									and ISNULL(b.Deleted,0) = 0)
	),

	cteServiceableFlag (Record_Id, ServiceableFlag)
	AS
	(
		SELECT	a.Record_Id
				,ServiceableFlag = 
					CASE
						WHEN b.Transport_Type_Id = 1 
							AND a.Sellability_Color_Coax IN ('GREEN', 'LIME GREEN', 'PURPLE') THEN 1		-- single-tenant flag for buildings that have more than 1 business
						WHEN b.Transport_Type_Id = 2 
							AND a.Sellability_Color_Fiber IN ('GREEN', 'LIME GREEN', 'PURPLE') THEN 1		-- multi-tenant flag for buildings that have less than or equal to 1 business
						WHEN b.Transport_Type_Id = 3 
							AND 
							(
								a.Sellability_Color_Coax IN ('PURPLE') OR a.Sellability_Color_Fiber IN ('PURPLE')
							) THEN 1
						ELSE 0
					END
		FROM	BI_MIP.miBuilds.app_Building as a
			LEFT JOIN BI_MIP.miBuilds.app_Probuild as b
			ON a.Probuild_Id = b.Probuild_Id
		WHERE	a.Probuild_Id = @probuild_id 
				and ISNULL(a.Deleted,0) = 0
	),

	cteDwellingFlag (Record_Id, DwellingFlag)
	AS
	(
		SELECT	a.Record_Id
				,DwellingFlag = 
					CASE
						--WHEN a.Dwelling_Type_Id IN (1,2) AND ISNULL(b.CtBiz, 0) = 0 THEN 1
						WHEN a.Dwelling_Type_Id = 1 AND b.CtBiz > 1 THEN 1		-- single-tenant flag for buildings that have more than 1 business
						WHEN a.Dwelling_Type_Id = 2 AND b.CtBiz <= 1 THEN 1		-- multi-tenant flag for buildings that have less than or equal to 1 business
						ELSE 0
					END
		FROM	BI_MIP.miBuilds.app_Building as a
			LEFT JOIN	(
						SELECT		Building_Id
									,COUNT(Building_Id) as CtBiz
						FROM		BI_MIP.miBuilds.app_Business as a
						WHERE		a.Probuild_Id = @probuild_id 
									and ISNULL(a.Deleted,0) = 0
						GROUP BY	Building_Id
					) as b
			ON a.Building_Id = b.Building_Id
		WHERE	a.Probuild_Id = @probuild_id 
				and ISNULL(a.Deleted,0) = 0
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
		build.Record_Id
		--,Probuild_Id
		,build.Building_Id
		,ParentBuilding_Id
		,Address
		,City
		,st.Name as State
		,Zip
		,Sellability_Color_Coax as Coax_Color
		,Sellability_Color_Fiber as Fiber_Color
		,build_type.Name as Building_Type
		,dwell.Name as Dwelling_Type
		,ROE_Id
		,roe_stat.Name as ROE_Status
		,UnmatchedFlag = IIF(cteUnmatchedFlag.Record_Id IS NOT NULL, 1, 0)
		,ServiceableFlag = ISNULL(ServiceableFlag, 0) 
		,DwellingFlag = ISNULL(DwellingFlag, 0)
		,RoeFlag = ISNULL(RoeFlag, 0)
FROM	BI_MIP.miBuilds.app_Building as build
		LEFT JOIN lk_State as st
		ON build.State_Id = st.State_Id
		LEFT JOIN lk_Building_Type as build_type
		ON build.Building_Type_Id = build_type.Building_Type_Id
		LEFT JOIN lk_Dwelling_Type as dwell
		ON build.Dwelling_Type_Id = dwell.Dwelling_Type_Id
		LEFT JOIN lk_ROE_Status as roe_stat
		ON build.ROE_Status_Id = roe_stat.ROE_Status_Id
		LEFT JOIN cteUnmatchedFlag
		ON build.Record_Id = cteUnmatchedFlag.Record_Id
		LEFT JOIN cteServiceableFlag
		ON build.Record_Id = cteServiceableFlag.Record_Id
		LEFT JOIN cteDwellingFlag
		ON build.Record_Id = cteDwellingFlag.Record_Id
		LEFT JOIN cteRoeFlag
		ON build.Record_Id = cteRoeFlag.Record_Id
WHERE	ISNULL(build.Deleted, 0) = 0
		AND build.Probuild_Id = @probuild_id
ORDER BY build.Record_Id
GO
