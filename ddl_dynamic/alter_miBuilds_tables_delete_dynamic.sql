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
SELECT t.Name
FROM BI_MIP.sys.tables AS t
JOIN BI_MIP.sys.schemas AS s ON t.schema_id = s.schema_id
WHERE s.name = 'miBuilds'
	and (t.name like 'app_%'
			OR t.name like 'rpt_%')
GROUP BY t.name

OPEN @myCursor
FETCH NEXT FROM @myCursor
INTO @TableName
WHILE @@FETCH_STATUS = 0
	BEGIN

		SELECT @SQL = N'delete from ' + @DbName + '.' + @SchemaName + '.' + @TableName + ' where probuild_id in (38,39,40,46)'
		--PRINT @SQL
		EXEC (@SQL)

	FETCH NEXT FROM @myCursor
	INTO @TableName
	
	END

CLOSE @myCursor
DEALLOCATE @myCursor



