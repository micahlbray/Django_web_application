USE [BI_MIP]
GO
/****** Object:  StoredProcedure [miBuilds].[search_business_case_addedby_df]    Script Date: 1/8/2019 2:54:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [miBuilds].[search_business_case_addedby_df]
	@region_id nvarchar(2)
	,@search_value nvarchar(255)

as

DECLARE @sql NVARCHAR(MAX)

SET @sql =	'DECLARE @probuild_id_list ProbuildIdList;

			INSERT INTO @probuild_id_list
			SELECT DISTINCT a.Probuild_Id
			FROM miBuilds.app_Probuild as a
			WHERE a.AddedBy LIKE ''%' + @search_value + '%''
			
			UNION ALL

			SELECT DISTINCT a.Probuild_Id
			FROM miBuilds.app_Probuild as a
				JOIN miBuilds.app_User_Profile as b
				ON a.AddedBy = b.NT_Login
			WHERE b.User_FirstName LIKE ''%' + @search_value + '%''
				OR b.User_LastName LIKE ''%' + @search_value + '%''
			
			EXEC miBuilds.search_business_case_detail_df @probuild_id_list, @region_id = ' + @region_id + ' '

--PRINT @sql
EXEC (@sql)
GO
