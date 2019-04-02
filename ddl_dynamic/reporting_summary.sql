SELECT	app_pro.Name as Probuild_Name
		,rpt_pro.Fund_Bucket
		,Probuild_Status =
			CASE
				WHEN app_pro.Approved = 1 THEN 'Approved'
				WHEN app_pro.Approved <> 1 and app_pro.Submitted = 1 THEN 'Submitted'
				WHEN app_pro.Approved <> 1 and app_pro.Submitted <> 1 and app_pro.Added = 1 'Pending'
			END
		,region.Name as Region
		,app_pro.Probuild_City
		,state.Name as State
		,build.Name as Build_Type
		,trans.Name as Transport_Type
		,survey.Name
		,app_pro.ROE_Gate
		,app_pro.ROE_Gate_Dt
		,app_pro.Permitting_Gate_Dt
		,app_pro.Est_Compl_Dt
		,app_pro.Cross_Functional_Review_On
		,app_pro.Historical_Opportunities
		,app_pro.JT_Id
		,app_pro.Access_Fees_One_Time
		,app_pro.Access_Fees_Monthly	
		,app_pro.ROW_Est_Build_Cost
		,app_pro.HeadEnd_Cost
		,app_pro.Transport_Cost
		,app_pro.SMB_12mo_Pen
		,app_pro.SMB_36mo_Pen
		,app_pro.ENT_12mo_Pen
		,app_pro.ENT_36mo_Pen
		,app_pro.SMB_ARPU
		,app_pro.ENT_ARPU
		,rpt_pro.Lateral_Construct_Upfront_Pct
		,rpt_pro.SMB_QB_Ct
		,rpt_pro.ENT_QB_Ct
		,rpt_pro.Building_Ct
		,rpt_pro.Multi_Tenant_Building_Ct
		,rpt_pro.CAR_Value
		,rpt_pro.IRR_Pct
		,rpt_pro.NPV
		,rpt_pro.Payback_Mo
		,rpt_pro.Passing_Cost_Per
		,rpt_pro.Additional_OSP_Lateral_Cost_per_Connect
		,app_pro.Fiber_Competitors_Ct
		,app_pro.Fiber_Competitors
		,app_pro.Comments
		,app_pro.Considerations
		,app_pro.Investment_Committee_Takeaway
		,rpt_pro.IRR_Pct_Less_HE_Trnsprt
		,app_pro.AddedOn
		,app_pro.AddedBy
		,app_pro.ApprovedOn
		,app_pro.ApprovedBy		
FROM [BI_MIP].[miBuilds].[app_Probuild] as app_pro
LEFT JOIN [BI_MIP].[miBuilds].[rpt_Probuild] as rpt_pro ON app_pro.Probuild_Id = rpt_pro.Probuild_id
	AND rpt_pro.Record_Id = (SELECT MAX(Record_Id) FROM [BI_MIP].[miBuilds].[rpt_Probuild] as z WHERE app_pro.Probuild_Id = z.Probuild_Id)
LEFT JOIN BI_MIP.miBuilds.lk_Region as region ON app_pro.Region_Id = region.Region_Id
LEFT JOIN BI_MIP.miBuilds.lk_State as state on app_pro.State_Id = state.State_Id
LEFT JOIN BI_MIP.miBuilds.lk_Build_Type as build ON app_pro.Build_Type_Id = build.Build_Type_Id
LEFT JOIN BI_MIP.miBuilds.lk_Transport_Type as trans ON app_pro.Transport_Type_Id = trans.Transport_Type_Id
LEFT JOIN BI_MIP.miBuilds.lk_Survey_Type as survey ON app_pro.Survey_Type_Id = survey.Survey_Type_Id
LEFT JOIN BI_MIP.miBuilds.lk_Download_Speed as download ON app_pro.Download_Speed_Id = download.Download_Speed_Id
LEFT JOIN BI_MIP.miBuilds.lk_Term_Length as term ON app_pro.Term_Length_Id = term.Term_Length_Id
WHERE app_pro.Approved = 1