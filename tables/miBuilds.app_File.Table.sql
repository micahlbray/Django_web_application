USE [BI_MIP]
GO
/****** Object:  Table [miBuilds].[app_File]    Script Date: 1/8/2019 3:27:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [miBuilds].[app_File](
	[File_Id] [int] IDENTITY(1,1) NOT NULL,
	[Probuild_Id] [int] NOT NULL,
	[Name] [varchar](255) NULL,
	[Path] [varchar](255) NULL,
	[Root] [varchar](255) NULL,
	[File_Type_Id] [int] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [varchar](100) NULL,
	[EditedOn] [datetime] NULL,
	[EditedBy] [varchar](100) NULL,
	[Deleted] [int] NULL,
	[DeletedOn] [datetime] NULL,
	[DeletedBy] [varchar](100) NULL,
	[Image] [varchar](max) NULL,
 CONSTRAINT [PK_app_File_File_Id] PRIMARY KEY CLUSTERED 
(
	[File_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [miBuilds].[app_File]  WITH CHECK ADD  CONSTRAINT [FK_app_File_app_Probuild_Probuild_Id] FOREIGN KEY([Probuild_Id])
REFERENCES [miBuilds].[app_Probuild] ([Probuild_Id])
GO
ALTER TABLE [miBuilds].[app_File] CHECK CONSTRAINT [FK_app_File_app_Probuild_Probuild_Id]
GO
ALTER TABLE [miBuilds].[app_File]  WITH CHECK ADD  CONSTRAINT [FK_app_File_lk_File_Type_File_Type_Id] FOREIGN KEY([File_Type_Id])
REFERENCES [miBuilds].[lk_File_Type] ([File_Type_Id])
GO
ALTER TABLE [miBuilds].[app_File] CHECK CONSTRAINT [FK_app_File_lk_File_Type_File_Type_Id]
GO
