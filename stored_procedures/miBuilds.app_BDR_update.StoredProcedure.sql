USE [BI_MIP]
GO
/****** Object:  StoredProcedure [miBuilds].[app_BDR_update]    Script Date: 1/8/2019 2:54:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [miBuilds].[app_BDR_update] as

update a
set		BDR_FirstName = FirstName
		,BDR_LastName = LastName
from miBuilds.lk_BDR as a
	join WISDM.dim.employee as b
	on a.BDR_NTLogin = b.ntlogin

update a
set		Manager_FirstName = FirstName
		,Manager_LastName = LastName
from miBuilds.lk_BDR as a
	join WISDM.dim.employee as b
	on a.Manager_NTLogin = b.ntlogin

GO
