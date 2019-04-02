USE BI_MIP_Dev
GO

--CREATE SCHEMA miBuilds;

DECLARE @myCursor CURSOR
--DECLARE @DbName NVARCHAR(50)
DECLARE @SchemaName NVARCHAR(50)
DECLARE @TableName NVARCHAR(50)
DECLARE @SQL NVARCHAR(MAX)

SET @SchemaName = 'Dev'

SET @myCursor = CURSOR FAST_FORWARD FOR
SELECT t.Name
FROM BI_MIP.sys.tables AS t
JOIN BI_MIP.sys.schemas AS s ON t.schema_id = s.schema_id
WHERE s.name = 'miBuilds'
GROUP BY t.name

OPEN @myCursor
FETCH NEXT FROM @myCursor
INTO @TableName
WHILE @@FETCH_STATUS = 0
	BEGIN

		SET @SQL =	'IF OBJECT_ID(''' + @SchemaName + '.' + @TableName + ''') IS NOT NULL DROP TABLE ' + @SchemaName + '.' + @TableName + ''
		PRINT @SQL
		EXECUTE (@SQL)

		SET @SQL =	'SELECT * INTO ' + @SchemaName + '.' + @TableName + ' FROM BI_MIP.miBuilds.' + @TableName + ''
		PRINT @SQL
		EXECUTE (@SQL)

	FETCH NEXT FROM @myCursor
	INTO @TableName
	
	END

CLOSE @myCursor
DEALLOCATE @myCursor



