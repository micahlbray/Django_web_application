USE [BI_MIP]
GO
/****** Object:  Table [miBuilds].[assump_Region_new]    Script Date: 1/8/2019 3:27:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [miBuilds].[assump_Region_new](
	[Region_Id] [float] NULL,
	[Name] [nvarchar](255) NULL,
	[SMB_ARPU] [float] NULL,
	[ENT_ARPU] [float] NULL,
	[SMB_12mo_Pen] [float] NULL,
	[SMB_36mo_Pen] [float] NULL,
	[ENT_12mo_Pen] [float] NULL,
	[ENT_36mo_Pen] [float] NULL
) ON [PRIMARY]
GO
