USE [BI_MIP]
GO
/****** Object:  Table [miBuilds].[assump_Data_Center_Type]    Script Date: 1/8/2019 3:27:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [miBuilds].[assump_Data_Center_Type](
	[Data_Center_Type_Assump_Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[Data_Center_Type_Id] [int] NOT NULL,
	[Data_Center_Equip_Type_Id] [int] NOT NULL,
	[Rack] [decimal](20, 2) NULL,
	[MRR_Per_Circ_Avg] [decimal](20, 2) NULL,
	[Colo_Fee] [decimal](20, 2) NULL,
	[Connect_Cost] [decimal](20, 2) NULL,
	[Opex_Pct] [decimal](5, 3) NULL,
	[IsActive] [int] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [varchar](100) NULL,
	[EditedOn] [datetime] NULL,
	[EditedBy] [varchar](100) NULL,
 CONSTRAINT [PK_assump_Data_Center_Data_Center_Assump_Id] PRIMARY KEY CLUSTERED 
(
	[Data_Center_Type_Assump_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [miBuilds].[assump_Data_Center_Type]  WITH CHECK ADD  CONSTRAINT [FK_assump_Data_Center_lk_Data_Center_Equip_Type_Data_Center_Equip_Type_Id] FOREIGN KEY([Data_Center_Equip_Type_Id])
REFERENCES [miBuilds].[lk_Data_Center_Equip_Type] ([Data_Center_Equip_Type_Id])
GO
ALTER TABLE [miBuilds].[assump_Data_Center_Type] CHECK CONSTRAINT [FK_assump_Data_Center_lk_Data_Center_Equip_Type_Data_Center_Equip_Type_Id]
GO
ALTER TABLE [miBuilds].[assump_Data_Center_Type]  WITH CHECK ADD  CONSTRAINT [FK_assump_Data_Center_lk_Data_Center_Type_Data_Center_Type_Id] FOREIGN KEY([Data_Center_Type_Id])
REFERENCES [miBuilds].[lk_Data_Center_Type] ([Data_Center_Type_Id])
GO
ALTER TABLE [miBuilds].[assump_Data_Center_Type] CHECK CONSTRAINT [FK_assump_Data_Center_lk_Data_Center_Type_Data_Center_Type_Id]
GO
