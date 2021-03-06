USE [BI_MIP]
GO
/****** Object:  Table [miBuilds].[assump_Region]    Script Date: 1/8/2019 3:27:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [miBuilds].[assump_Region](
	[Region_Assump_Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[Region_Id] [int] NOT NULL,
	[SMB_ARPU] [decimal](20, 2) NULL,
	[ENT_ARPU] [decimal](20, 2) NULL,
	[SMB_12mo_Pen] [decimal](5, 3) NULL,
	[SMB_36mo_Pen] [decimal](5, 3) NULL,
	[ENT_12mo_Pen] [decimal](5, 3) NULL,
	[ENT_36mo_Pen] [decimal](5, 3) NULL,
	[IsActive] [int] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [varchar](50) NULL,
	[EditedOn] [datetime] NULL,
	[EditedBy] [varchar](100) NULL,
 CONSTRAINT [PK_assump_Region_Region_Assump_Id] PRIMARY KEY CLUSTERED 
(
	[Region_Assump_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [miBuilds].[assump_Region]  WITH CHECK ADD  CONSTRAINT [FK_assump_Region_lk_Region_Region_Id] FOREIGN KEY([Region_Id])
REFERENCES [miBuilds].[lk_Region] ([Region_Id])
GO
ALTER TABLE [miBuilds].[assump_Region] CHECK CONSTRAINT [FK_assump_Region_lk_Region_Region_Id]
GO
