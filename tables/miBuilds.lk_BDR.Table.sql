USE [BI_MIP]
GO
/****** Object:  Table [miBuilds].[lk_BDR]    Script Date: 1/8/2019 3:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [miBuilds].[lk_BDR](
	[BDR_Id] [int] IDENTITY(1,1) NOT NULL,
	[Region_Id] [int] NULL,
	[BDR_Pernr] [varchar](50) NULL,
	[BDR_NTLogin] [varchar](50) NULL,
	[BDR_FirstName] [varchar](150) NULL,
	[BDR_LastName] [varchar](150) NULL,
	[Manager_Pernr] [varchar](50) NULL,
	[Manager_NTLogin] [varchar](50) NULL,
	[Manager_FirstName] [varchar](150) NULL,
	[Manager_LastName] [varchar](150) NULL,
	[IsActive] [int] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [varchar](100) NULL,
	[EditedOn] [datetime] NULL,
	[EditedBy] [varchar](100) NULL,
 CONSTRAINT [PK_BDR_BDR_Id] PRIMARY KEY CLUSTERED 
(
	[BDR_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
