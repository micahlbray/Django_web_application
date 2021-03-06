USE [BI_MIP]
GO
/****** Object:  StoredProcedure [miBuilds].[search_building_id_df]    Script Date: 1/8/2019 2:54:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [miBuilds].[search_building_id_df]
	@region_id nvarchar(2)
	,@search_value nvarchar(255)

as

DECLARE @sql NVARCHAR(MAX)

SET @sql =	'DECLARE @probuild_id_list ProbuildIdList;

			INSERT INTO @probuild_id_list
			SELECT DISTINCT a.Probuild_Id
			FROM miBuilds.app_Building as a
			WHERE a.Building_Id LIKE ''%' + @search_value + '%''
				AND ISNULL(a.Deleted, 0) = 0
			
			EXEC miBuilds.search_business_case_detail_df @probuild_id_list, @region_id = ' + @region_id + ' '
EXEC (@sql)
GO
