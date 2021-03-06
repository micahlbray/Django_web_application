USE [BI_MIP]
GO
/****** Object:  Table [miBuilds].[django_migrations]    Script Date: 1/8/2019 3:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [miBuilds].[django_migrations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[app] [nvarchar](255) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[applied] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
