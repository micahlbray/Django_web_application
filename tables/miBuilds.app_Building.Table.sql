USE [BI_MIP]
GO
/****** Object:  Table [miBuilds].[app_Building]    Script Date: 1/8/2019 3:27:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [miBuilds].[app_Building](
	[Record_Id] [int] IDENTITY(1,1) NOT NULL,
	[Building_Id] [bigint] NULL,
	[Probuild_Id] [int] NOT NULL,
	[ParentBuilding_Id] [int] NULL,
	[Address] [varchar](255) NULL,
	[City] [varchar](150) NULL,
	[State_Id] [int] NULL,
	[Zip] [varchar](50) NULL,
	[Building_Type_Id] [int] NULL,
	[Dwelling_Type_Id] [int] NULL,
	[ROE_Id] [int] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [varchar](100) NULL,
	[EditedOn] [datetime] NULL,
	[EditedBy] [varchar](100) NULL,
	[Deleted] [int] NULL,
	[DeletedOn] [datetime] NULL,
	[DeletedBy] [varchar](100) NULL,
	[Sellability_Color_Coax] [varchar](20) NULL,
	[Sellability_Color_Fiber] [varchar](20) NULL,
	[ROE_Status_Id] [int] NULL,
 CONSTRAINT [PK_app_Building_Record_Id] PRIMARY KEY CLUSTERED 
(
	[Record_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [miBuilds].[app_Building]  WITH CHECK ADD  CONSTRAINT [FK_app_Building_app_Probuild_Probuild_Id] FOREIGN KEY([Probuild_Id])
REFERENCES [miBuilds].[app_Probuild] ([Probuild_Id])
GO
ALTER TABLE [miBuilds].[app_Building] CHECK CONSTRAINT [FK_app_Building_app_Probuild_Probuild_Id]
GO
ALTER TABLE [miBuilds].[app_Building]  WITH CHECK ADD  CONSTRAINT [FK_app_Building_lk_Building_Type_Building_Type_Id] FOREIGN KEY([Building_Type_Id])
REFERENCES [miBuilds].[lk_Building_Type] ([Building_Type_Id])
GO
ALTER TABLE [miBuilds].[app_Building] CHECK CONSTRAINT [FK_app_Building_lk_Building_Type_Building_Type_Id]
GO
ALTER TABLE [miBuilds].[app_Building]  WITH CHECK ADD  CONSTRAINT [FK_app_Building_lk_Dwelling_Type_Dwelling_Type_Id] FOREIGN KEY([Dwelling_Type_Id])
REFERENCES [miBuilds].[lk_Dwelling_Type] ([Dwelling_Type_Id])
GO
ALTER TABLE [miBuilds].[app_Building] CHECK CONSTRAINT [FK_app_Building_lk_Dwelling_Type_Dwelling_Type_Id]
GO
ALTER TABLE [miBuilds].[app_Building]  WITH CHECK ADD  CONSTRAINT [FK_app_Building_lk_ROE_Status_ROE_Status_Id] FOREIGN KEY([ROE_Status_Id])
REFERENCES [miBuilds].[lk_ROE_Status] ([ROE_Status_Id])
GO
ALTER TABLE [miBuilds].[app_Building] CHECK CONSTRAINT [FK_app_Building_lk_ROE_Status_ROE_Status_Id]
GO
ALTER TABLE [miBuilds].[app_Building]  WITH CHECK ADD  CONSTRAINT [FK_app_Building_lk_State_State_Id] FOREIGN KEY([State_Id])
REFERENCES [miBuilds].[lk_State] ([State_Id])
GO
ALTER TABLE [miBuilds].[app_Building] CHECK CONSTRAINT [FK_app_Building_lk_State_State_Id]
GO
