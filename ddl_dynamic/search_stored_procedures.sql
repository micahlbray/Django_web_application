alter procedure miBuilds.search_business_case_name_df
	@region_id nvarchar(2)
	,@search_value nvarchar(255)

as

DECLARE @sql NVARCHAR(MAX)

--SET @search_value = 'test'

SET @sql =	'DECLARE @probuild_id_list ProbuildIdList;

			INSERT INTO @probuild_id_list
			SELECT DISTINCT a.Probuild_Id
			FROM miBuilds.app_Probuild as a
			WHERE a.Name LIKE ''%' + @search_value + '%''
			
			EXEC miBuilds.search_business_case_detail_df @probuild_id_list, @region_id = ' + @region_id + ' '
EXEC (@sql)

----------------------------------
----------------------------------
----------------------------------
ALTER procedure miBuilds.search_business_case_addedby_df
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
EXEC (@sql)
----------------------------------
----------------------------------
----------------------------------

create procedure miBuilds.search_building_id_df
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
----------------------------------
----------------------------------
----------------------------------
create procedure miBuilds.search_building_address_df
	@region_id nvarchar(2)
	,@search_value nvarchar(255)

as

DECLARE @sql NVARCHAR(MAX)

SET @sql =	'DECLARE @probuild_id_list ProbuildIdList;

			INSERT INTO @probuild_id_list
			SELECT DISTINCT a.Probuild_Id
			FROM miBuilds.app_Building as a
			WHERE a.Address LIKE ''%' + @search_value + '%''
				AND ISNULL(a.Deleted, 0) = 0
			
			EXEC miBuilds.search_business_case_detail_df @probuild_id_list, @region_id = ' + @region_id + ' '
EXEC (@sql)

create procedure miBuilds.search_business_name_df
	@region_id nvarchar(2)
	,@search_value nvarchar(255)

as

DECLARE @sql NVARCHAR(MAX)

SET @sql =	'DECLARE @probuild_id_list ProbuildIdList;

			INSERT INTO @probuild_id_list
			SELECT DISTINCT a.Probuild_Id
			FROM miBuilds.app_Business as a
			WHERE a.Business_Name LIKE ''%' + @search_value + '%''
				AND ISNULL(a.Deleted, 0) = 0
			
			EXEC miBuilds.search_business_case_detail_df @probuild_id_list, @region_id = ' + @region_id + ' '
EXEC (@sql)

create procedure miBuilds.search_business_address_df
	@region_id nvarchar(2)
	,@search_value nvarchar(255)

as

DECLARE @sql NVARCHAR(MAX)

SET @sql =	'DECLARE @probuild_id_list ProbuildIdList;

			INSERT INTO @probuild_id_list
			SELECT DISTINCT a.Probuild_Id
			FROM miBuilds.app_Business as a
			WHERE a.Address_1 LIKE ''%' + @search_value + '%''
				AND ISNULL(a.Deleted, 0) = 0
			
			UNION ALL

			SELECT DISTINCT a.Probuild_Id
			FROM miBuilds.app_Business as a
			WHERE a.Address_2 LIKE ''%' + @search_value + '%''
				AND ISNULL(a.Deleted, 0) = 0

			EXEC miBuilds.search_business_case_detail_df @probuild_id_list, @region_id = ' + @region_id + ' '
EXEC (@sql)

create procedure miBuilds.search_mdu_name_df
	@region_id nvarchar(2)
	,@search_value nvarchar(255)

as

DECLARE @sql NVARCHAR(MAX)

SET @sql =	'DECLARE @probuild_id_list ProbuildIdList;

			INSERT INTO @probuild_id_list
			SELECT DISTINCT a.Probuild_Id
			FROM miBuilds.app_MDU as a
			WHERE a.Property_Name LIKE ''%' + @search_value + '%''
				AND ISNULL(a.Deleted, 0) = 0
			
			EXEC miBuilds.search_business_case_detail_df @probuild_id_list, @region_id = ' + @region_id + ' '
EXEC (@sql)

create procedure miBuilds.search_data_center_name_df
	@region_id nvarchar(2)
	,@search_value nvarchar(255)

as

DECLARE @sql NVARCHAR(MAX)

SET @sql =	'DECLARE @probuild_id_list ProbuildIdList;

			INSERT INTO @probuild_id_list
			SELECT DISTINCT a.Probuild_Id
			FROM miBuilds.app_DataCenter as a
			WHERE a.Name LIKE ''%' + @search_value + '%''
				AND ISNULL(a.Deleted, 0) = 0
			
			EXEC miBuilds.search_business_case_detail_df @probuild_id_list, @region_id = ' + @region_id + ' '
EXEC (@sql)

create procedure miBuilds.search_sf_opportunity_id_df
	@region_id nvarchar(2)
	,@search_value nvarchar(255)

as

DECLARE @sql NVARCHAR(MAX)

SET @sql =	'DECLARE @probuild_id_list ProbuildIdList;

			INSERT INTO @probuild_id_list
			SELECT DISTINCT a.Probuild_Id
			FROM miBuilds.app_SF_DealInHand as a
			WHERE a.Opportunity_Id LIKE ''%' + @search_value + '%''
				AND ISNULL(a.Deleted, 0) = 0
			
			EXEC miBuilds.search_business_case_detail_df @probuild_id_list, @region_id = ' + @region_id + ' '
EXEC (@sql)

create procedure miBuilds.search_sf_customer_name_df
	@region_id nvarchar(2)
	,@search_value nvarchar(255)

as

DECLARE @sql NVARCHAR(MAX)

SET @sql =	'DECLARE @probuild_id_list ProbuildIdList;

			INSERT INTO @probuild_id_list
			SELECT DISTINCT a.Probuild_Id
			FROM miBuilds.app_SF_DealInHand as a
			WHERE a.Customer_Name LIKE ''%' + @search_value + '%''
				AND ISNULL(a.Deleted, 0) = 0
			
			EXEC miBuilds.search_business_case_detail_df @probuild_id_list, @region_id = ' + @region_id + ' '
EXEC (@sql)


create procedure miBuilds.search_business_id_df
	@region_id nvarchar(2)
	,@search_value nvarchar(255)

as

DECLARE @sql NVARCHAR(MAX)

SET @sql =	'DECLARE @probuild_id_list ProbuildIdList;

			INSERT INTO @probuild_id_list
			SELECT DISTINCT a.Probuild_Id
			FROM miBuilds.app_Business as a
			WHERE a.Business_Id LIKE ''%' + @search_value + '%''
				AND ISNULL(a.Deleted, 0) = 0
			
			EXEC miBuilds.search_business_case_detail_df @probuild_id_list, @region_id = ' + @region_id + ' '
EXEC (@sql)