SELECT DISTINCT *
FROM INFORMATION_SCHEMA.COLUMNS as c
	LEFT JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu ON c.COLUMN_NAME = ccu.COLUMN_NAME AND c.TABLE_NAME = ccu.TABLE_NAME
	LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc ON ccu.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
WHERE c.TABLE_SCHEMA IN ('miBuilds','miBuilds_rpt','miBuilds_View')
ORDER BY c.TABLE_SCHEMA, c.TABLE_NAME, c.ORDINAL_POSITION

