USE [BI_MIP]
GO
/****** Object:  StoredProcedure [miBuilds].[reports_building_business_not_matched_df]    Script Date: 1/8/2019 2:54:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [miBuilds].[reports_building_business_not_matched_df]
		@probuild_id NVARCHAR(25)

as

DECLARE @sql NVARCHAR(MAX)

SET @sql =	'SELECT	a.Building_Id
					,NULL AS Business_Id
			FROM	BI_MIP.miBuilds.app_Building as a
			WHERE	a.Probuild_Id = ' + @probuild_id + '
					and ISNULL(a.Deleted,0) = 0
					and NOT EXISTS(SELECT Building_Id 
								FROM BI_MIP.miBuilds.app_Business as b 
								WHERE a.Building_Id = b.Building_Id 
									and ISNULL(b.Deleted,0) = 0)

			UNION ALL

			SELECT	NULL as Building_Id
					,a.Business_Id
			FROM	BI_MIP.miBuilds.app_Business as a
			WHERE	a.Probuild_Id = ' + @probuild_id + '
					and ISNULL(a.Deleted,0) = 0
					and NOT EXISTS(SELECT Building_Id 
								FROM BI_MIP.miBuilds.app_Building as b 
								WHERE a.Building_Id = b.Building_Id 
									and ISNULL(b.Deleted,0) = 0)'
EXECUTE(@sql)
GO
