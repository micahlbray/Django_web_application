USE [BI_MIP]
GO
/****** Object:  Table [miBuilds].[assump_Data_Center_Circuit_EOY]    Script Date: 1/8/2019 3:27:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [miBuilds].[assump_Data_Center_Circuit_EOY](
	[Record_Id] [int] IDENTITY(1,1) NOT NULL,
	[Data_Center_Circuit_EOY_Assump_Id] [int] NOT NULL,
	[Name] [varchar](100) NULL,
	[Data_Center_Type_Id] [int] NOT NULL,
	[Yr] [int] NULL,
	[Circuit_Ct] [int] NULL,
	[IsActive] [int] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [varchar](100) NULL,
	[EditedOn] [datetime] NULL,
	[EditedBy] [varchar](100) NULL,
 CONSTRAINT [PK_assump_Data_Center_Circuit_EOY_Record_Id] PRIMARY KEY CLUSTERED 
(
	[Record_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [miBuilds].[assump_Data_Center_Circuit_EOY]  WITH CHECK ADD  CONSTRAINT [FK_assump_Data_Center_Circuit_EOY_lk_Data_Center_Type_Data_Center_Type_Id] FOREIGN KEY([Data_Center_Type_Id])
REFERENCES [miBuilds].[lk_Data_Center_Type] ([Data_Center_Type_Id])
GO
ALTER TABLE [miBuilds].[assump_Data_Center_Circuit_EOY] CHECK CONSTRAINT [FK_assump_Data_Center_Circuit_EOY_lk_Data_Center_Type_Data_Center_Type_Id]
GO
