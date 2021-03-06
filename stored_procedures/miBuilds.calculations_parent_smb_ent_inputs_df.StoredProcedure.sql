USE [BI_MIP]
GO
/****** Object:  StoredProcedure [miBuilds].[calculations_parent_smb_ent_inputs_df]    Script Date: 1/8/2019 2:54:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [miBuilds].[calculations_parent_smb_ent_inputs_df]
	@probuild_id int

	as

SELECT	SUM(app_pro.customer_contribution) as customer_contribution
		,SUM(app_pro.access_fees_one_time) as access_fees_one_time
		,SUM(app_pro.access_fees_monthly) as access_fees_monthly
		,SUM(app_pro.row_est_build_cost) as row_est_build_cost
		,SUM(app_pro.headend_cost) as headend_cost
		,SUM(app_pro.transport_cost) as transport_cost
		,SUM(app_pro.private_property_cost) as private_property_cost
		,SUM(building_ct.record_ct) as record_ct
        ,SUM(building_ct.address_ct) as address_ct
		,SUM(building_ct.address_null) as address_null
        ,SUM(building_ct.multi_tenant_building_ct) as multi_tenant_building_ct
		,SUM(business_ct.business_ct) as business_ct
		,SUM(business_ct.smb_qb_ct) as smb_qb_ct
		,SUM(business_ct.ent_qb_ct) as ent_qb_ct
		,SUM(dih_ct.dih_ct) as dih_ct
		,SUM(mdu_ct.mdu_ct) as mdu_ct
		,SUM(mdu_ct.mdu_building_ct) as mdu_building_ct
		,SUM(dc_ct.dc_ct) as dc_ct
		,SUM(building_ct.Probuild_Id)
FROM	miBuilds.app_Probuild as app_pro
	LEFT JOIN miBuilds.rpt_Probuild as rpt_pro 
	ON app_pro.Probuild_Id = rpt_pro.Probuild_id
		AND rpt_pro.Record_Id = (SELECT MAX(Record_Id) FROM miBuilds.rpt_Probuild as z WHERE app_pro.Probuild_Id = z.Probuild_Id)
	LEFT JOIN	(
					SELECT	Probuild_Id
							,COUNT(Record_Id) as record_ct
                            ,COUNT(DISTINCT lower(Address)) as address_ct
							,SUM(IIF(Address IS NULL, 1, 0)) as address_null
                        	,SUM(IIF(Dwelling_Type_Id = 2, 1, 0)) as multi_tenant_building_ct
                    FROM miBuilds.app_Building 
                    WHERE ISNULL(Deleted, 0) = 0
						and Probuild_Id IN (
												SELECT Probuild_Id 
												FROM miBuilds.app_Probuild as app_pro 
												WHERE app_pro.Parent_Probuild_Id = @probuild_id
														and ISNULL(app_pro.Deleted, 0) = 0
														and ISNULL(Cloned, 0) = 0
											)											
					GROUP BY Probuild_Id
				) as building_ct
	ON app_pro.Probuild_Id = building_ct.Probuild_Id
	LEFT JOIN	(
					SELECT	Probuild_Id
							,COUNT(Record_Id) as business_ct
                        	,SUM(IIF(ISNULL(Revised_Segment_Type_Id, Segment_Type_Id) = 1, 1, 0)) as smb_qb_ct
                            ,SUM(IIF(ISNULL(Revised_Segment_Type_Id, Segment_Type_Id) <> 1, 1, 0)) as ent_qb_ct
                    FROM miBuilds.app_Business
                    WHERE ISNULL(Deleted, 0) = 0
						and Probuild_Id IN (
												SELECT Probuild_Id 
												FROM miBuilds.app_Probuild as app_pro 
												WHERE app_pro.Parent_Probuild_Id = @probuild_id
														and ISNULL(app_pro.Deleted, 0) = 0
														and ISNULL(Cloned, 0) = 0
											)
					GROUP BY Probuild_Id
				) as business_ct
	ON app_pro.Probuild_Id = business_ct.Probuild_Id
	LEFT JOIN	(
					SELECT Probuild_Id, COUNT(SF_DealInHand_Id) as dih_ct
					FROM miBuilds.app_SF_DealInHand as a
					WHERE ISNULL(a.Deleted, 0) = 0
						and Probuild_Id IN (
												SELECT Probuild_Id 
												FROM miBuilds.app_Probuild as app_pro 
												WHERE app_pro.Parent_Probuild_Id = @probuild_id
														and ISNULL(app_pro.Deleted, 0) = 0
														and ISNULL(Cloned, 0) = 0
											)
					GROUP BY Probuild_Id
				) as dih_ct
	ON app_pro.Probuild_Id = dih_ct.Probuild_Id
	LEFT JOIN	(
					SELECT	Probuild_Id
							,COUNT(MDU_Id) as mdu_ct
							,SUM(ISNULL(Building_Ct,0)) as mdu_building_ct
					FROM miBuilds.app_MDU as a
					WHERE ISNULL(a.Deleted, 0) = 0
						and Probuild_Id IN (
												SELECT Probuild_Id 
												FROM miBuilds.app_Probuild as app_pro 
												WHERE app_pro.Parent_Probuild_Id = @probuild_id
														and ISNULL(app_pro.Deleted, 0) = 0
														and ISNULL(Cloned, 0) = 0
											)
					GROUP BY Probuild_Id
				) as mdu_ct
	ON app_pro.Probuild_Id = mdu_ct.Probuild_Id
	LEFT JOIN	(
					SELECT Probuild_Id, COUNT(DataCenter_Id) as dc_ct
					FROM miBuilds.app_DataCenter as a
					WHERE ISNULL(a.Deleted, 0) = 0
						and Probuild_Id IN (
												SELECT Probuild_Id 
												FROM miBuilds.app_Probuild as app_pro 
												WHERE app_pro.Parent_Probuild_Id = @probuild_id
														and ISNULL(app_pro.Deleted, 0) = 0
														and ISNULL(Cloned, 0) = 0
											)
					GROUP BY Probuild_Id
				) as dc_ct
	ON app_pro.Probuild_Id = mdu_ct.Probuild_Id
WHERE	app_pro.Parent_Probuild_Id = @probuild_id
	and ISNULL(app_pro.Deleted, 0) = 0
	and ISNULL(Cloned, 0) = 0
GO
