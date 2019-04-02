USE [BI_MIP]
GO

TRUNCATE TABLE [MIP2].[PROBUILD_BUSINESSES]

INSERT INTO [MIP2].[PROBUILD_BUSINESSES]
           ([Probuild_Id]
           ,[MIP Building Id]
           ,[MIP Qb Id]
           ,[MIP Qb Name]
           ,[Qb Segment]
           ,[BUILD_NAME]
           ,[Filename]
           ,[Revised_Segment]
           ,[Revised_Segment_NOTES]
           ,[NAX_BUILDING_ID])
SELECT	NULL
		,cast([MIP Building ID] as int)
		,[MIP QB ID]
		,[MIP QB Name]
		,[MIP Segment]
		,[Build Name]
		,[Filename]
		,[Rvsd Segment]
		,[Revised Segment Notes]
		,NULL
FROM [BI_MIP].[MIP2].[Micah_Businesses_Scrape]

UPDATE a 
SET a.NAX_BUILDING_ID = b.NAX_BUILDING_ID
FROM MIP2.PROBUILD_BUSINESSES as a 
JOIN [BI_MIP].[MIP2].Building_XREF as b on cast(a.[MIP Building Id] as int) = b.MIP_BUILDING_ID

UPDATE a 
SET a.NAX_BUILDING_ID = 0
FROM MIP2.PROBUILD_BUSINESSES as a 
WHERE NAX_BUILDING_ID IS NULL

