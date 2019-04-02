USE BI_MIP
GO

DECLARE @myCursor CURSOR
--DECLARE @DbName NVARCHAR(50)
DECLARE @SchemaName NVARCHAR(50)
DECLARE @TableName NVARCHAR(50)
DECLARE @SQL NVARCHAR(MAX)

SET @SchemaName = 'MIP2'

SET @myCursor = CURSOR FAST_FORWARD FOR
SELECT t.Name
FROM BI_MIP_Dev.sys.tables AS t
JOIN BI_MIP_Dev.sys.schemas AS s ON t.schema_id = s.schema_id
WHERE s.name = 'Dev'
	AND t.Name IN ('probuild_Summary'
					,'probuild_Buildings'
					,'probuild_Businesses'
					,'probuild_Cashflow'
					,'probuild_Mducashflow'
					,'probuild_Dealsinhand'
					,'probuild_Completion_date'
					,'probuild_rev'
					,'probuild_all_proj_financial_from_py'
					,'probuild_180_month_date_info'
					,'probuild_Rev_2'
					,'probuild_Act_pen'
					,'probuild_Completion_date2'
					,'probuild_Date_info'
					,'probuild_Date_info_2'
					,'probuild_Date_info_3'
					,'probuild_APP_MIBUILDS_REGION_SELECTION'
					,'probuild_APP_MIBUILDS_REGION_SELECTION2'
					,'probuild_APP_MIBUILDS_PROBUILD_SELECTION'
					,'probuild_APP_MIBUILDS_SELECTED_BUILD'
					) --use the list that Anders provides here and import into table
GROUP BY t.name

OPEN @myCursor
FETCH NEXT FROM @myCursor
INTO @TableName
WHILE @@FETCH_STATUS = 0
	BEGIN

		SET @SQL =	'IF OBJECT_ID(''' + @SchemaName + '.' + @TableName + ''') IS NOT NULL DROP TABLE ' + @SchemaName + '.' + @TableName + ''
		PRINT @SQL
		EXECUTE (@SQL)

		SET @SQL =	'SELECT * INTO ' + @SchemaName + '.' + @TableName + ' FROM BI_MIP_Dev.Dev.' + @TableName + ''
		PRINT @SQL
		EXECUTE (@SQL)

	FETCH NEXT FROM @myCursor
	INTO @TableName
	
	END

CLOSE @myCursor
DEALLOCATE @myCursor


/***************************************************
	Handling the change of Building Id 
****************************************************/
SET @myCursor = CURSOR FAST_FORWARD FOR
SELECT t.Name
FROM BI_MIP_Dev.sys.tables AS t
JOIN BI_MIP_Dev.sys.schemas AS s ON t.schema_id = s.schema_id
JOIN BI_MIP_Dev.sys.columns as c on t.object_id = c.object_id
WHERE s.name = 'Dev'
	AND c.Name LIKE '%Building%Id%'
	AND t.Name IN ('probuild_Summary'
					,'probuild_Buildings'
					,'probuild_Businesses'
					,'probuild_Cashflow'
					,'probuild_Mducashflow'
					,'probuild_Dealsinhand'
					,'probuild_Completion_date'
					,'probuild_rev'
					,'probuild_all_proj_financial_from_py'
					,'probuild_180_month_date_info'
					,'probuild_Rev_2'
					,'probuild_Act_pen'
					,'probuild_Completion_date2'
					,'probuild_Date_info'
					,'probuild_Date_info_2'
					,'probuild_Date_info_3'
					,'probuild_APP_MIBUILDS_REGION_SELECTION'
					,'probuild_APP_MIBUILDS_REGION_SELECTION2'
					,'probuild_APP_MIBUILDS_PROBUILD_SELECTION'
					,'probuild_APP_MIBUILDS_SELECTED_BUILD'
					) --use the list that Anders provides here and import into table
GROUP BY t.name

OPEN @myCursor
FETCH NEXT FROM @myCursor
INTO @TableName
WHILE @@FETCH_STATUS = 0
	BEGIN

		SET @SQL =	'ALTER TABLE ' + @SchemaName + '.' + @TableName + ' ADD NAX_BUILDING_ID numeric(20,0)'
		PRINT @SQL
		EXECUTE (@SQL)

		SET @SQL =	'UPDATE a ' +
					'SET a.NAX_BUILDING_ID = b.NAX_BUILDING_ID ' +
					'FROM ' + @SchemaName + '.' + @TableName + ' as a ' +
					'JOIN ExternalUser.MIP.MIP2_Building_XREF as b on a.MIP_BUILDING_ID = b.MIP_BUILDING_ID '
		PRINT @SQL
		EXECUTE (@SQL)

	FETCH NEXT FROM @myCursor
	INTO @TableName
	
	END

CLOSE @myCursor
DEALLOCATE @myCursor


delete 
from MIP2.PROBUILD_BUSINESSES
where [MIP Building Id] = 'N/A'

delete 
from MIP2.PROBUILD_BUSINESSES
where [MIP Building Id] = '#REF!'

delete 
FROM MIP2.PROBUILD_BUSINESSES
where IsNumeric([MIP Building Id]) = 0

UPDATE a 
SET a.NAX_BUILDING_ID = b.NAX_BUILDING_ID
FROM MIP2.PROBUILD_BUSINESSES as a 
JOIN ExternalUser.MIP.MIP2_Building_XREF as b on a.[MIP Building Id] = b.MIP_BUILDING_ID

delete 
from MIP2.PROBUILD_BUILDINGS
where [MIP Building Id] = 'N/A'

delete 
from MIP2.PROBUILD_BUILDINGS
where [MIP Building Id] = '#REF!'

delete 
FROM MIP2.PROBUILD_BUILDINGS
where IsNumeric([MIP Building Id]) = 0

UPDATE a 
SET a.NAX_BUILDING_ID = b.NAX_BUILDING_ID
FROM MIP2.PROBUILD_BUILDINGS as a 
JOIN ExternalUser.MIP.MIP2_Building_XREF as b on a.[MIP Building Id] = b.MIP_BUILDING_ID
