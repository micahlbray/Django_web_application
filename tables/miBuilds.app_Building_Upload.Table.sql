USE [BI_MIP]
GO
/****** Object:  Table [miBuilds].[app_Building_Upload]    Script Date: 1/8/2019 3:27:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [miBuilds].[app_Building_Upload](
	[Building_Upload_Id] [int] IDENTITY(1,1) NOT NULL,
	[Probuild_Id] [int] NOT NULL,
	[Name] [varchar](255) NULL,
	[Path] [varchar](255) NULL,
	[Root] [varchar](255) NULL,
	[Upload_Type_Id] [int] NOT NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [varchar](100) NULL,
	[EditedOn] [datetime] NULL,
	[EditedBy] [varchar](100) NULL,
	[Deleted] [int] NULL,
	[DeletedOn] [datetime] NULL,
	[DeletedBy] [varchar](100) NULL,
	[Greenfield] [int] NULL,
	[Post_Approval] [int] NULL,
 CONSTRAINT [PK_app_Building_Upload_Building_Upload_Id] PRIMARY KEY CLUSTERED 
(
	[Building_Upload_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [miBuilds].[app_Building_Upload]  WITH CHECK ADD  CONSTRAINT [FK_app_Building_Upload_app_Probuild_Probuild_Id] FOREIGN KEY([Probuild_Id])
REFERENCES [miBuilds].[app_Probuild] ([Probuild_Id])
GO
ALTER TABLE [miBuilds].[app_Building_Upload] CHECK CONSTRAINT [FK_app_Building_Upload_app_Probuild_Probuild_Id]
GO
ALTER TABLE [miBuilds].[app_Building_Upload]  WITH CHECK ADD  CONSTRAINT [FK_app_Building_Upload_lk_Upload_Type_Upload_Type_Id] FOREIGN KEY([Upload_Type_Id])
REFERENCES [miBuilds].[lk_Upload_Type] ([Upload_Type_Id])
GO
ALTER TABLE [miBuilds].[app_Building_Upload] CHECK CONSTRAINT [FK_app_Building_Upload_lk_Upload_Type_Upload_Type_Id]
GO
