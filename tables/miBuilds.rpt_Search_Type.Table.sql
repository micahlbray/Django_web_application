USE [BI_MIP]
GO
/****** Object:  Table [miBuilds].[rpt_Search_Type]    Script Date: 1/8/2019 3:27:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [miBuilds].[rpt_Search_Type](
	[Record_Id] [int] IDENTITY(1,1) NOT NULL,
	[Search_Type_Id] [int] NOT NULL,
	[Search_Value] [nvarchar](255) NULL,
	[Stored_Procedure] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [varchar](100) NULL,
 CONSTRAINT [PK_rpt_Search_Type_Record_Id] PRIMARY KEY CLUSTERED 
(
	[Record_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [miBuilds].[rpt_Search_Type]  WITH CHECK ADD  CONSTRAINT [FK_rpt_Search_Type_lk_Search_Type_Id] FOREIGN KEY([Search_Type_Id])
REFERENCES [miBuilds].[lk_Search_Type] ([Search_Type_Id])
GO
ALTER TABLE [miBuilds].[rpt_Search_Type] CHECK CONSTRAINT [FK_rpt_Search_Type_lk_Search_Type_Id]
GO
