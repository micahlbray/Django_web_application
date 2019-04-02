USE BI_MIP_Dev
GO

--CREATE SCHEMA miBuilds;

DECLARE @myCursor CURSOR
DECLARE @DbName NVARCHAR(50)
DECLARE @SchemaName NVARCHAR(50)
DECLARE @TableName NVARCHAR(50)
DECLARE @ColName NVARCHAR(50)
DECLARE @SQL NVARCHAR(MAX)

SET @DbName = 'BI_MIP_Dev'
SET @SchemaName = 'Dev'

SET @myCursor = CURSOR FAST_FORWARD FOR
SELECT t.Name
FROM BI_MIP_Dev.sys.tables AS t
JOIN BI_MIP_Dev.sys.schemas AS s ON t.schema_id = s.schema_id
WHERE s.name = 'Dev'
	and (t.name like 'app_%'
			OR t.name like 'rpt_%')
GROUP BY t.name

OPEN @myCursor
FETCH NEXT FROM @myCursor
INTO @TableName
WHILE @@FETCH_STATUS = 0
	BEGIN

		SELECT @SQL = N'delete from ' + @DbName + '.' + @SchemaName + '.' + @TableName + ' where probuild_id in (4169)'
		PRINT @SQL
		EXEC (@SQL)

	FETCH NEXT FROM @myCursor
	INTO @TableName
	
	END

CLOSE @myCursor
DEALLOCATE @myCursor



