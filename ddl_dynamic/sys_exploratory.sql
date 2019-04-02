USE BI_MIP_Dev
GO

SELECT t.name, c.name, c.max_length, typ.name
FROM sys.tables AS t
JOIN sys.columns AS c ON t.object_id = c.object_id
JOIN sys.schemas AS s ON t.schema_id = s.schema_id
JOIN sys.types AS typ ON c.system_type_id = typ.system_type_id
WHERE s.name LIKE 'Dev%'
	AND t.name LIKE 'PROBUILD%'
	AND c.name LIKE 'Probuild%'
--GROUP BY t.name, c.name, typ.name
ORDER BY 1