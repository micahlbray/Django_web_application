USE BI_MIP
GO

--CREATE SCHEMA Dev

DECLARE @myCursor CURSOR
DECLARE @DbName NVARCHAR(50)
DECLARE @SchemaName NVARCHAR(50)
DECLARE @TableName NVARCHAR(50)
DECLARE @SQL NVARCHAR(MAX)

SET @DbName = 'BI_MIP_Dev'
SET @SchemaName = 'Dev'

SET @myCursor = CURSOR FAST_FORWARD FOR
SELECT t.Name
FROM BI_MIP.sys.tables AS t
JOIN BI_MIP.sys.schemas AS s ON t.schema_id = s.schema_id
WHERE s.name = 'Dev'
	AND t.Name IN ('probuild_Summary'
					--,'probuild_Buildings'
					--,'probuild_Businesses'
					,'probuild_Cashflow'
					,'probuild_Mducashflow'
					,'probuild_Dealsinhand'
					,'probuild_Completion_date'
					,'probuild_rev'
					--,'probuild_all_proj_financial_from_py'
					--,'probuild_180_month_date_info'
					,'probuild_Rev_2'
					--,'probuild_Act_pen'
					,'probuild_Completion_date2'
					,'probuild_Date_info'
					,'probuild_Date_info_2'
					,'probuild_Date_info_3'
					,'probuild_APP_MIBUILDS_REGION_SELECTION'
					,'probuild_APP_MIBUILDS_REGION_SELECTION2'
					,'probuild_APP_MIBUILDS_PROBUILD_SELECTION'
					,'probuild_APP_MIBUILDS_SELECTED_BUILD'
					) --use the list that Anders provides here and import into table

OPEN @myCursor
FETCH NEXT FROM @myCursor
INTO @TableName
WHILE @@FETCH_STATUS = 0
	BEGIN

		SET @SQL =	'ALTER TABLE Dev.' + @TableName + ' DROP COLUMN NAX_BUILDING_ID'
		PRINT @SQL
		EXECUTE (@SQL)

	FETCH NEXT FROM @myCursor
	INTO @TableName
	
	END

CLOSE @myCursor
DEALLOCATE @myCursor