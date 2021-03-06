USE [BI_MIP]
GO
/****** Object:  StoredProcedure [miBuilds].[services_business_insert]    Script Date: 1/8/2019 2:54:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [miBuilds].[services_business_insert] 
		@probuild_id int,
		@addedby VARCHAR(50)
as

INSERT INTO miBuilds.app_Business
		(Building_Id
		,ProBuild_Id
		,Business_Id
		,Business_Name
		,Segment_Type_Id
		,Segment_Assump_Id
		,Address_Id
		,Address_1
		,Address_2
		,Sellability_Color_Coax
		,Sellability_Color_Fiber
		,MIP_In_Or_Out
		,AddedOn
		,AddedBy)
SELECT	a.nax_building_id as building_id
		,@probuild_id as probuild_id
		,a.busn_id as business_id
		,a.busn_name as business_name
		,c.segment_type_id as segment_type_id
		,d.segment_assump_id as segment_assump_id
		,a.nax_address_id as address_id
		,b.nax_conformed_address_1 as address_1
		,b.nax_conformed_address_2 as address_2
		,b.MIP_SUITE_SELLABILITY_COLOR_COAX as sellability_color_coax
		,b.MIP_SUITE_SELLABILITY_COLOR_FIBER as sellability_color_fiber
		,a.MIP_IN_OR_OUT as mip_in_or_out
		,getdate() as addedon
		,@addedby as addedby
FROM    ExternalUser.MIP.MIP2_BUSINESS_PROFILE as a
	JOIN ExternalUser.MIP.MIP2_ADDRESS_PROFILE as b
	ON a.nax_address_id = b.nax_address_id
	LEFT JOIN BI_MIP.miBuilds.lk_Segment_Type as c
	ON a.mip_segment = c.name
	LEFT JOIN BI_MIP.miBuilds.assump_Segment as d
	ON c.segment_type_id = d.segment_type_id
WHERE   a.NAX_BUILDING_ID IN (
							SELECT Building_Id
							FROM miBuilds.app_Building
							WHERE Probuild_Id = @probuild_id
							)
			and COMCAST_DIVISION = 'WEST DIVISION'
		AND a.MIP_IN_OR_OUT = 'IN'

GO
