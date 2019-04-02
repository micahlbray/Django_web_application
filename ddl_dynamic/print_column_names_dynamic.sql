--===== Variable declarations
DECLARE  @pDBName       SYSNAME      --Could be a parameter for a stored proc
        ,@pTableName    SYSNAME      --Could be a parameter for a stored proc
        ,@ColumnNames   VARCHAR(MAX) --Could be an output parameter for a stored proc
        ,@SQL           NVARCHAR(MAX)
;
--===== Preset the variables for the database and table name
 SELECT  @pDBName    = 'BI_MIP'
        ,@pTableName = 'app_Building'
;
--===== Make sure the @pDBName (the only variable with concatenation properties in the dynamic SQL)
     -- is actually a database name rather than SQL injection.  The other two variables are fully
     -- parameterized and of the correct length to prevent injection by truncation. Note that if 
     -- the database name does not exist, we do nothing but return so as to give no hint to a 
     -- a possible attacker.  This makes the QuOTENAME thing I did further down total overkill
     -- but I left that there anyway.
     IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = @pDBName) 
        RETURN
;
--===== Setup the variable contents including the "double-dynamic" SQL.
 SELECT @SQL        = REPLACE(REPLACE('
 SELECT @ColumnNames = COALESCE(@ColumnNames+",","")  + COLUMN_NAME
   FROM <<@pDBName>>.INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_NAME = @pTableName
 OPTION (MAXDOP 1);'
        ,'"'              ,'''')
        ,'<<@pDBName>>'   ,QUOTENAME(@pDBName)) --QUOTENAME() to help prevent SQL-INJECTION
;
--===== Get the column names from the desired database and table.
EXECUTE sp_executesql @SQL
                    , N'@pTableName SYSNAME, @ColumnNames VARCHAR(MAX) OUT'       --Parameter Definitions
                    , @pTableName = @pTableName, @ColumnNames = @ColumnNames OUT  --Value Assignment
;
--===== Here are the desired results
  PRINT @ColumnNames;

--===== Here's the SQL that was executed
  PRINT @SQL;