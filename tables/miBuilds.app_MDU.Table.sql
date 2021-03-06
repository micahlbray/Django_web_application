USE [BI_MIP]
GO
/****** Object:  Table [miBuilds].[app_MDU]    Script Date: 1/8/2019 3:27:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [miBuilds].[app_MDU](
	[MDU_Id] [int] IDENTITY(1,1) NOT NULL,
	[Probuild_Id] [int] NOT NULL,
	[Property_Name] [varchar](255) NULL,
	[System_Name] [varchar](255) NULL,
	[Property_Owner] [varchar](255) NULL,
	[Est_Compl_Dt] [date] NULL,
	[MDU_Build_Type_Id] [int] NOT NULL,
	[Current_Service_Type_Id] [int] NOT NULL,
	[Term_Length_Id] [int] NOT NULL,
	[MDU_Build_Assump_Id] [int] NULL,
	[MDU_Build_Region_Assump_Id] [int] NULL,
	[Building_Ct] [int] NULL,
	[Unit_Ct] [int] NULL,
	[Video_Subscr_Target] [int] NULL,
	[Voice_Subscr_Target] [int] NULL,
	[Data_Subscr_Target] [int] NULL,
	[Video_Penetration] [decimal](5, 3) NULL,
	[Data_Penetration] [decimal](5, 3) NULL,
	[Voice_Penetration] [decimal](5, 3) NULL,
	[Video_ARPU] [decimal](20, 2) NULL,
	[Data_ARPU] [decimal](20, 2) NULL,
	[Voice_ARPU] [decimal](20, 2) NULL,
	[Video_Rev_Share] [decimal](5, 3) NULL,
	[Data_Rev_Share] [decimal](5, 3) NULL,
	[Voice_Rev_Share] [decimal](5, 3) NULL,
	[Opex_Load] [decimal](5, 3) NULL,
	[Door_Fees] [decimal](20, 2) NULL,
	[ISP_Per_Unit] [decimal](20, 2) NULL,
	[Converter] [decimal](20, 2) NULL,
	[Modem] [decimal](20, 2) NULL,
	[eMTA] [decimal](20, 2) NULL,
	[Commission] [decimal](20, 2) NULL,
	[Penetration_Ramp] [int] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [varchar](100) NULL,
	[EditedOn] [datetime] NULL,
	[EditedBy] [varchar](100) NULL,
	[Deleted] [int] NULL,
	[DeletedOn] [datetime] NULL,
	[DeletedBy] [varchar](100) NULL,
 CONSTRAINT [PK_app_MDU_MDU_Id] PRIMARY KEY CLUSTERED 
(
	[MDU_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [miBuilds].[app_MDU]  WITH CHECK ADD  CONSTRAINT [FK_app_MDU_app_Probuild_Probuild_Id] FOREIGN KEY([Probuild_Id])
REFERENCES [miBuilds].[app_Probuild] ([Probuild_Id])
GO
ALTER TABLE [miBuilds].[app_MDU] CHECK CONSTRAINT [FK_app_MDU_app_Probuild_Probuild_Id]
GO
ALTER TABLE [miBuilds].[app_MDU]  WITH CHECK ADD  CONSTRAINT [FK_app_MDU_assump_MDU_Build_MDU_Build_Assump_Id] FOREIGN KEY([MDU_Build_Assump_Id])
REFERENCES [miBuilds].[assump_MDU_Build] ([MDU_Build_Assump_Id])
GO
ALTER TABLE [miBuilds].[app_MDU] CHECK CONSTRAINT [FK_app_MDU_assump_MDU_Build_MDU_Build_Assump_Id]
GO
ALTER TABLE [miBuilds].[app_MDU]  WITH CHECK ADD  CONSTRAINT [FK_app_MDU_assump_MDU_Build_Region_MDU_Build_Region_Assump_Id] FOREIGN KEY([MDU_Build_Region_Assump_Id])
REFERENCES [miBuilds].[assump_MDU_Build_Region] ([MDU_Build_Region_Assump_Id])
GO
ALTER TABLE [miBuilds].[app_MDU] CHECK CONSTRAINT [FK_app_MDU_assump_MDU_Build_Region_MDU_Build_Region_Assump_Id]
GO
ALTER TABLE [miBuilds].[app_MDU]  WITH CHECK ADD  CONSTRAINT [FK_app_MDU_lk_MDU_Build_Type_MDU_Build_Type_Id] FOREIGN KEY([MDU_Build_Type_Id])
REFERENCES [miBuilds].[lk_MDU_Build_Type] ([MDU_Build_Type_Id])
GO
ALTER TABLE [miBuilds].[app_MDU] CHECK CONSTRAINT [FK_app_MDU_lk_MDU_Build_Type_MDU_Build_Type_Id]
GO
ALTER TABLE [miBuilds].[app_MDU]  WITH CHECK ADD  CONSTRAINT [FK_app_MDU_lk_Term_Length_Term_Length_Id] FOREIGN KEY([Term_Length_Id])
REFERENCES [miBuilds].[lk_Term_Length] ([Term_Length_Id])
GO
ALTER TABLE [miBuilds].[app_MDU] CHECK CONSTRAINT [FK_app_MDU_lk_Term_Length_Term_Length_Id]
GO
ALTER TABLE [miBuilds].[app_MDU]  WITH CHECK ADD  CONSTRAINT [FK_MDU_lk_Current_Service_Type_Current_Service_Type_Id] FOREIGN KEY([Current_Service_Type_Id])
REFERENCES [miBuilds].[lk_Current_Service_Type] ([Current_Service_Type_Id])
GO
ALTER TABLE [miBuilds].[app_MDU] CHECK CONSTRAINT [FK_MDU_lk_Current_Service_Type_Current_Service_Type_Id]
GO
