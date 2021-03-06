USE [BI_MIP]
GO
/****** Object:  StoredProcedure [miBuilds].[construction_business_case_building_summary_df]    Script Date: 1/8/2019 2:54:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [miBuilds].[construction_business_case_building_summary_df] 
	@probuild_id INT
as

SELECT	app_build.Building_Id
		,app_build.ParentBuilding_Id
		,app_build.Address
		,app_build.City
		,app_build.State_Id
		,app_build.Zip
		,build_type.Name
		,dwell_type.Name
		,app_build.Sellability_Color_Coax
		,app_build.Sellability_Color_Fiber
		,app_build.ROE_Id	
		,roe.Name as ROE_Status
FROM [BI_MIP].[miBuilds].[app_Building] as app_build
	LEFT JOIN BI_MIP.miBuilds.lk_Building_Type as build_type 
	ON app_build.Building_Type_Id = build_type.Building_Type_Id
	LEFT JOIN BI_MIP.miBuilds.lk_Dwelling_Type as dwell_type 
	ON app_build.Dwelling_Type_Id = dwell_type.Dwelling_Type_Id
	LEFT JOIN BI_MIP.miBuilds.lk_ROE_Status as roe 
	ON app_build.ROE_Status_Id = roe.ROE_Status_Id
WHERE ISNULL(app_build.Deleted,0) = 0
	and app_build.Probuild_Id = @probuild_id
GO
