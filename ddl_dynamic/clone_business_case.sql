DECLARE @probuild_id NVARCHAR(25)
DECLARE @clonedby NVARCHAR(25)
DECLARE @DbName NVARCHAR(50)
DECLARE @SchemaName NVARCHAR(50)
DECLARE @TableName NVARCHAR(50)
DECLARE @TablePK NVARCHAR(50)
DECLARE @Clones int
DECLARE @ProbuildName NVARCHAR(255)
DECLARE @ClonedName NVARCHAR(255)
DECLARE @CloneId NVARCHAR(50)
DECLARE @SQL NVARCHAR(MAX)
DECLARE @s nvarchar(500)

SET @probuild_id = '234'
SET @clonedby = 'mbray201'
SET @TablePK = 'Probuild_Id'
SET @DbName = 'BI_MIP_Dev'
SET @SchemaName = 'dev'
SET @TableName = 'app_Probuild'

---- Set the clone variables based off of the probuild_id from the app
SET @Clones = (SELECT COUNT(1) FROM miBuilds.app_Probuild WHERE Parent_Probuild_Id = @probuild_id) + 1
SET @ProbuildName = (SELECT Name FROM miBuilds.app_Probuild WHERE Probuild_Id = @probuild_id)
SET @ClonedName = @ProbuildName + ' Clone ' + CAST(@Clones as NVARCHAR(50))

PRINT @Clones
PRINT @ProbuildName
PRINT @ClonedName

		IF @TableName = 'app_Probuild'
			BEGIN
				--- Drop temp table
				SET @SQL = 'IF OBJECT_ID(''tempdb..#z'') IS NOT NULL DROP TABLE #z '
				PRINT @SQL
				--- Insert values into temp table
				SET @SQL = @SQL + 'SELECT * INTO #z FROM ' + @DbName + '.' + @SchemaName + '.' + @TableName + ' WHERE Probuild_Id = ' + @probuild_id + ' '
				PRINT @SQL
				--- Update Probuild_Id to CloneID
				SET @SQL = @SQL + 'UPDATE #z SET Name = ' + @ClonedName + ' '
				PRINT @SQL
				--- Update Cloned value to 1
				SET @SQL = @SQL + 'UPDATE #z SET Cloned = 1 '
				PRINT @SQL
				--- Update Cloned on to current date/time
				SET @SQL = @SQL + 'UPDATE #z SET ClonedOn = GETDATE() '
				PRINT @SQL
				--- Update ClonedBy to App variable
				SET @SQL = @SQL + 'UPDATE #z SET ClonedBy = ' + @clonedby + ' '
				PRINT @SQL
				--- Drop PK column from temp table because it can't be inserted
				SET @SQL = @SQL + 'ALTER TABLE #z DROP COLUMN ' + @TablePK + ' '
				PRINT @SQL
				--- Insert values into main table
				SET @SQL = @SQL + 'INSERT INTO ' + @DbName + '.' + @SchemaName + '.' + @TableName + ' FROM #z '
				PRINT @SQL

				SET @CloneId = (SELECT Probuild_Id FROM miBuilds.app_Probuild WHERE Name = @ClonedName)

			END
			 
		ELSE
			BEGIN
				PRINT @CloneId
				--- Drop temp table
				SET @SQL = 'IF OBJECT_ID(''tempdb..#z'') IS NOT NULL DROP TABLE #z '
				--- Insert values into temp table
				SET @SQL = @SQL + 'SELECT * INTO #z FROM ' + @DbName + '.' + @SchemaName + '.' + @TableName + ' WHERE Probuild_Id = ' + @probuild_id + ' '
				--- Update Probuild_Id to CloneID
				SET @SQL = @SQL + 'UPDATE #z SET Probuild_Id = ' + @CloneId + ' '
				--- Drop PK column from temp table because it can't be inserted
				SET @SQL = @SQL + 'ALTER TABLE #z DROP COLUMN ' + @TablePK + ' '
				--- Insert values into main table
				SET @SQL = @SQL + 'INSERT INTO ' + @DbName + '.' + @SchemaName + '.' + @TableName + ' SELECT * FROM #z '

				PRINT @SQL
				--EXECUTE (@SQL)
			END

PRINT @SQL


exec [miBuilds].[ajax_business_case_clone] 
		@probuild_id = '234'
		,@clonedby = 'mbray201'

select * from BI_MIP_Dev.dev.app_MDU
where probuild_id  = 875