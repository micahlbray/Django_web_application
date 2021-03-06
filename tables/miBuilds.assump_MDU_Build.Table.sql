USE [BI_MIP]
GO
/****** Object:  Table [miBuilds].[assump_MDU_Build]    Script Date: 1/8/2019 3:27:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [miBuilds].[assump_MDU_Build](
	[MDU_Build_Assump_Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NULL,
	[MDU_Build_Type_Id] [int] NOT NULL,
	[Current_Service_Type_Id] [int] NOT NULL,
	[MDU_Build_Region_Assump_Id] [int] NULL,
	[Video_Penetration] [decimal](5, 3) NULL,
	[Data_Penetration] [decimal](5, 3) NULL,
	[Voice_Penetration] [decimal](5, 3) NULL,
	[Video_ARPU] [decimal](20, 2) NULL,
	[Data_ARPU] [decimal](20, 2) NULL,
	[Voice_ARPU] [decimal](20, 2) NULL,
	[Video_Rev_Share] [decimal](5, 3) NULL,
	[Data_Rev_Share] [decimal](5, 3) NULL,
	[Voice_Rev_Share] [decimal](5, 3) NULL,
	[ISP_Per_Unit] [decimal](20, 2) NULL,
	[Door_Fees] [decimal](20, 2) NULL,
	[Min_Passings] [decimal](20, 2) NULL,
	[Opex_Load] [decimal](5, 3) NULL,
	[Converter] [decimal](20, 2) NULL,
	[Modem] [decimal](20, 2) NULL,
	[eMTA] [decimal](20, 2) NULL,
	[Penetration_Ramp] [int] NULL,
	[IsActive] [int] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [varchar](100) NULL,
	[EditedOn] [datetime] NULL,
	[EditedBy] [varchar](100) NULL,
 CONSTRAINT [PK_assump_MDU_Build_MDU_Build_Assump_Id] PRIMARY KEY CLUSTERED 
(
	[MDU_Build_Assump_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [miBuilds].[assump_MDU_Build]  WITH CHECK ADD  CONSTRAINT [FK_assump_MDU_Build_assump_MDU_Build_Region_MDU_Build_Region_Assump_Id] FOREIGN KEY([MDU_Build_Region_Assump_Id])
REFERENCES [miBuilds].[assump_MDU_Build_Region] ([MDU_Build_Region_Assump_Id])
GO
ALTER TABLE [miBuilds].[assump_MDU_Build] CHECK CONSTRAINT [FK_assump_MDU_Build_assump_MDU_Build_Region_MDU_Build_Region_Assump_Id]
GO
ALTER TABLE [miBuilds].[assump_MDU_Build]  WITH CHECK ADD  CONSTRAINT [FK_assump_MDU_Build_lk_Current_Service_Type_Current_Service_Type_Id] FOREIGN KEY([Current_Service_Type_Id])
REFERENCES [miBuilds].[lk_Current_Service_Type] ([Current_Service_Type_Id])
GO
ALTER TABLE [miBuilds].[assump_MDU_Build] CHECK CONSTRAINT [FK_assump_MDU_Build_lk_Current_Service_Type_Current_Service_Type_Id]
GO
ALTER TABLE [miBuilds].[assump_MDU_Build]  WITH CHECK ADD  CONSTRAINT [FK_assump_MDU_Build_lk_MDU_Build_Type_MDU_Build_Type_Id] FOREIGN KEY([MDU_Build_Type_Id])
REFERENCES [miBuilds].[lk_MDU_Build_Type] ([MDU_Build_Type_Id])
GO
ALTER TABLE [miBuilds].[assump_MDU_Build] CHECK CONSTRAINT [FK_assump_MDU_Build_lk_MDU_Build_Type_MDU_Build_Type_Id]
GO
