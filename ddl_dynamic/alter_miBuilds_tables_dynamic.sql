USE BI_MIP
GO

--CREATE SCHEMA miBuilds;

DECLARE @myCursor CURSOR
DECLARE @DbName NVARCHAR(50)
DECLARE @SchemaName NVARCHAR(50)
DECLARE @TableName NVARCHAR(50)
DECLARE @ColName NVARCHAR(50)
DECLARE @SQL NVARCHAR(MAX)

SET @DbName = 'BI_MIP'
SET @SchemaName = 'miBuilds'

SET @myCursor = CURSOR FAST_FORWARD FOR
SELECT t.Name, c.name
FROM BI_MIP.sys.tables AS t
JOIN BI_MIP.sys.columns as c on t.object_id = c.object_id
JOIN BI_MIP.sys.schemas AS s ON t.schema_id = s.schema_id
WHERE s.name = 'miBuilds'
	and t.name like 'rpt_%'
	and c.system_type_id = 106 --decimal
--GROUP BY t.name

--select *
--from BI_MIP.sys.types

OPEN @myCursor
FETCH NEXT FROM @myCursor
INTO @TableName, @ColName
WHILE @@FETCH_STATUS = 0
	BEGIN

		SELECT @SQL = N'alter table ' + @DbName + '.' + @SchemaName + '.' + @TableName + ' ' +
					'alter column ' + @ColName + ' DECIMAL(20,2)'
		PRINT @SQL
		--EXEC (@SQL)

	FETCH NEXT FROM @myCursor
	INTO @TableName, @ColName
	
	END

CLOSE @myCursor
DEALLOCATE @myCursor



