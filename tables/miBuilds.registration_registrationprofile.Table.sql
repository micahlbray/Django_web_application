USE [BI_MIP]
GO
/****** Object:  Table [miBuilds].[registration_registrationprofile]    Script Date: 1/8/2019 3:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [miBuilds].[registration_registrationprofile](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[status] [nvarchar](10) NOT NULL,
	[activation_key] [nvarchar](40) NULL,
	[user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [miBuilds].[registration_registrationprofile]  WITH CHECK ADD  CONSTRAINT [registration_registrationprofile_user_id_5fcbf725_fk_auth_user_id] FOREIGN KEY([user_id])
REFERENCES [miBuilds].[auth_user] ([id])
GO
ALTER TABLE [miBuilds].[registration_registrationprofile] CHECK CONSTRAINT [registration_registrationprofile_user_id_5fcbf725_fk_auth_user_id]
GO
