USE [BI_MIP]
GO
/****** Object:  Table [miBuilds].[lk_Region]    Script Date: 1/8/2019 3:27:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [miBuilds].[lk_Region](
	[Region_Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[Lead_Email] [varchar](150) NULL,
	[Lead_Backup_Email] [varchar](150) NULL,
	[Invest_Committ_Email_Distro] [varchar](150) NULL,
	[IsActive] [int] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [varchar](50) NULL,
	[EditedOn] [datetime] NULL,
	[EditedBy] [varchar](100) NULL,
	[Review_Email] [varchar](150) NULL,
	[Construction_Email] [varchar](255) NULL,
	[Other_Email] [varchar](255) NULL,
 CONSTRAINT [PK_lk_Region_Region_Id] PRIMARY KEY CLUSTERED 
(
	[Region_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
