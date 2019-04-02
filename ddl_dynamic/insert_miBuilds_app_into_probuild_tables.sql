USE [BI_MIP]
GO

/*********************************************************************************************
---------- BUILDINGS ------------------
*********************************************************************************************/
INSERT INTO [MIP2].[PROBUILD_BUILDINGS]
           ([Probuild_Id]
           ,[MIP Building ID]
           ,[Building Address]
           ,[City]
           ,[State]
           ,[Zip]
           ,[BUILDING_TYPE]
           ,[BUILD_NAME]
           ,[DWELLING_TYPE]
           ,[Filename]
           ,[Parent Bldg ID]
           ,[NAX_BUILDING_ID])
SELECT	NULL as Probuild_Id
		,NULL as [MIP Building ID]
		,build.Address as [Building Address]
		,build.City as City
		,state.Abbrev as State
		,build.Zip as Zip
		,build_type.Name as BUILDING_TYPE
		,app_pro.Name as BUILD_NAME
		,dwell_type.Name as DWELLING_TYPE
		,'miBuilds_app_' + CONVERT(VARCHAR(8), ApprovedOn, 112) + '_' + app_pro.Name as Filename
		,build.ParentBuilding_Id as [Parent Bldg ID]
		,build.Building_Id	as NAX_BUILDING_ID
FROM miBuilds.app_Building as build
LEFT JOIN miBuilds.app_Probuild as app_pro ON build.Probuild_Id = app_pro.Probuild_Id
LEFT JOIN miBuilds.lk_State as state ON build.State_Id = state.State_Id
LEFT JOIN miBuilds.lk_Building_Type as build_type ON build.Building_Type_Id = build_type.Building_Type_Id
LEFT JOIN miBuilds.lk_Dwelling_Type as dwell_type ON build.Dwelling_Type_Id = dwell_type.Dwelling_Type_Id
WHERE app_pro.Approved = 1
	and ISNULL(build.Deleted,0) = 0

/*********************************************************************************************
---------- BUSINESSES ------------------
*********************************************************************************************/
INSERT INTO [MIP2].[PROBUILD_BUSINESSES]
           ([Probuild_Id]
           ,[MIP Building Id]
           ,[BUSN_ID]
           ,[MIP Qb Name]
           ,[Qb Segment]
           ,[BUILD_NAME]
           ,[Filename]
           ,[Revised_Segment]
           ,[Revised_Segment_NOTES]
           ,[NAX_BUILDING_ID])
SELECT	NULL as Probuild_Id
		,NULL as [MIP Building ID]
		,bus.Business_Id as BUSN_ID
		,bus.Business_Name as [MIP Qb Name]
		,seg.Name as [Qb Segment]
		,app_pro.Name as BUILD_NAME
		,'miBuilds_app_' + CONVERT(VARCHAR(8), ApprovedOn, 112) + '_' + app_pro.Name as Filename
		,rev_seg.Name as Revised_Segment
		,bus.Revised_Segment_Notes as Revised_Segment_NOTES
		,bus.Building_Id as NAX_BUILDING_ID
FROM miBuilds.app_Business as bus
LEFT JOIN miBuilds.app_Probuild as app_pro ON bus.Probuild_Id = app_pro.Probuild_Id
LEFT JOIN miBuilds.lk_Segment_Type as seg ON bus.Segment_Type_Id = seg.Segment_Type_Id
LEFT JOIN miBuilds.lk_Segment_Type as rev_seg ON bus.Revised_Segment_Type_Id = rev_seg.Segment_Type_Id
WHERE app_pro.Approved = 1
	and ISNULL(bus.Deleted,0) = 0

/*********************************************************************************************
---------- DEALS IN HAND ------------------
*********************************************************************************************/
INSERT INTO [MIP2].[PROBUILD_DEALSINHAND]
           ([Probuild_Id]
           ,[Build_Name]
           ,[Salesforce_Opportunity_ID]
           ,[Customer_Name]
           ,[Product_Type]
           ,[Num_Sites]
           ,[MRR]
           ,[Filename])
SELECT	NULL as Probuild_Id
		,app_pro.Name as Build_Name
		,opp.Opportunity_Id as Salesforce_Opportunity_ID
		,opp.Customer_Name as Customer_Name
		,term.Term as Product_Type
		,seg.Name as Num_Sites
		,opp.MRR as MRR
		,'miBuilds_app_' + CONVERT(VARCHAR(8), ApprovedOn, 112) + '_' + app_pro.Name	
FROM miBuilds.app_SF_DealInHand as opp
LEFT JOIN miBuilds.app_Probuild as app_pro ON opp.Probuild_Id = app_pro.Probuild_Id
LEFT JOIN miBuilds.lk_Segment_Type as seg ON opp.Segment_Type_Id = seg.Segment_Type_Id
LEFT JOIN miBuilds.lk_Term_Length as term ON opp.Term_Length_Id = term.Term_Length_Id
WHERE app_pro.Approved = 1
	and ISNULL(opp.Deleted,0) = 0 

/*********************************************************************************************
---------- PROBUILD SUMMARY ------------------
*********************************************************************************************/
INSERT INTO [MIP2].[PROBUILD_SUMMARY]
           ([Region]
           ,[City]
           ,[State]
           ,[Build_Type]
           ,[Funding_Type]
           ,[ROE_Gate]
           ,[ROE_Gate_Date]
           ,[Permitting_Gate_Date]
           ,[Est_Completion_Date]
           ,[Approval_Date]
           ,[Cross_Functional_Review_Held]
           ,[Historical_Opportunities]
           ,[Survey_Type]
           ,[SMB_Passings]
           ,[ENT_Passings]
           ,[Building_Count]
           ,[Building_Count_Multi_Tenant]
           ,[ROW_Est_Build_Cost]
           ,[SMB_Additional_OSP_Lateral_Cost_per_Connect]
           ,[ENT_Additional_OSP_Lateral_Cost_per_Connect]
           ,[Perc_Connects_Supported_by_Up_Front_Laterals]
           ,[Total_CAR_Value]
           ,[IRR]
           ,[NPV]
           ,[Payback_Month]
           ,[Cost_Per_Passing]
           ,[TOTAL_Additional_OSP_Lateral_Cost_per_Connect]
           ,[SMB_12_Month_Pen]
           ,[SMB_36_Month_Pen]
           ,[ENT_12_Month_Pen]
           ,[ENT_36_Month_Pen]
           ,[SMB_ARPU]
           ,[ENT_ARPU]
           ,[Comments]
           ,[Considerations]
           ,[Count_Fiber_Competitors]
           ,[Competitive_Commentary]
           ,[DSL_Max_Available]
           ,[Investment_Committee_Takeaway]
           ,[PROBUILD_ID]
           ,[BUILD_NAME]
           ,[TERM]
           ,[DEAL_IN_HAND_MRC]
           ,[DEAL_IN_HAND_QTY]
           ,[ACCESS_FEES_ONE_TIME]
           ,[ACCESS_FEES_MONTHLY]
           ,[Filename]
           ,[HeadEnd_Cost]
           ,[Transport_Cost]
           ,[IRR_HE_Transport]
           ,[JT_ID]
           ,[Business_Max_Actual_Capital]
           ,[Resi_Max_Actual_Capital]
           ,[Approver])
SELECT	region.Name as Region
		,app_pro.Probuild_City
		,state.Name as State
		,build.Name as Build_Type
		,rpt_pro.Fund_Bucket
		,app_pro.ROE_Gate
		,app_pro.ROE_Gate_Dt
		,app_pro.Permitting_Gate_Dt
		,app_pro.Est_Compl_Dt
		,app_pro.ApprovedOn
		,app_pro.Cross_Functional_Review_On
		,app_pro.Historical_Opportunities
		,survey.Name
		,rpt_pro.SMB_QB_Ct
		,rpt_pro.ENT_QB_Ct
		,rpt_pro.Building_Ct
		,rpt_pro.Multi_Tenant_Building_Ct
		,app_pro.ROW_Est_Build_Cost
		,NULL as SMB_Additional_OSP_Lateral_Cost_per_Connect
		,NULL as ENT_Additional_OSP_Lateral_Cost_per_Connect
		,rpt_pro.Lateral_Construct_Upfront_Pct
		,rpt_pro.CAR_Value
		,rpt_pro.IRR_Pct
		,rpt_pro.NPV
		,rpt_pro.Payback_Mo
		,rpt_pro.Passing_Cost_Per
		,rpt_pro.Additional_OSP_Lateral_Cost_per_Connect
		,app_pro.SMB_12mo_Pen
		,app_pro.SMB_36mo_Pen
		,app_pro.ENT_12mo_Pen
		,app_pro.ENT_36mo_Pen
		,app_pro.SMB_ARPU
		,app_pro.ENT_ARPU
		,app_pro.Comments
		,app_pro.Considerations
		,app_pro.Fiber_Competitors_Ct
		,app_pro.Fiber_Competitors
		,download.Name
		,app_pro.Investment_Committee_Takeaway
		,NULL as PROBUILD_ID
		,app_pro.Name as BUILD_NAME
		,term.Term as TERM
		,NULL as DEAL_IN_HAND_MRC
		,NULL as DEAL_IN_HAND_QTY
		,app_pro.Access_Fees_One_Time
		,app_pro.Access_Fees_Monthly
		,'miBuilds_app_' + CONVERT(VARCHAR(8), ApprovedOn, 112) + '_' + app_pro.Name as Filename
		,app_pro.HeadEnd_Cost
		,app_pro.Transport_Cost
		,rpt_pro.IRR_Pct_Less_HE_Trnsprt
		,app_pro.JT_Id
		,rpt_pro.Business_Max_Actual_Capital as Business_Max_Actual_Capital
		,rpt_pro.Resi_Max_Actual_Capital as Resi_Max_Actual_Capital
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
	and ISNULL(app_pro.Deleted,0) = 0

/*********************************************************************************************
---------- PROBUILD CASHFLOW ------------------
*********************************************************************************************/
INSERT INTO [MIP2].[PROBUILD_CASHFLOW]
           ([PROBUILD_ID]
           ,[BUILD_NAME]
		   ,[Filename]
           ,[CATEGORY]
           ,[Month_0]
           ,[Month_1]
           ,[Month_2]
           ,[Month_3]
           ,[Month_4]
           ,[Month_5]
           ,[Month_6]
           ,[Month_7]
           ,[Month_8]
           ,[Month_9]
           ,[Month_10]
           ,[Month_11]
           ,[Month_12]
           ,[Month_13]
           ,[Month_14]
           ,[Month_15]
           ,[Month_16]
           ,[Month_17]
           ,[Month_18]
           ,[Month_19]
           ,[Month_20]
           ,[Month_21]
           ,[Month_22]
           ,[Month_23]
           ,[Month_24]
           ,[Month_25]
           ,[Month_26]
           ,[Month_27]
           ,[Month_28]
           ,[Month_29]
           ,[Month_30]
           ,[Month_31]
           ,[Month_32]
           ,[Month_33]
           ,[Month_34]
           ,[Month_35]
           ,[Month_36]
           ,[Month_37]
           ,[Month_38]
           ,[Month_39]
           ,[Month_40]
           ,[Month_41]
           ,[Month_42]
           ,[Month_43]
           ,[Month_44]
           ,[Month_45]
           ,[Month_46]
           ,[Month_47]
           ,[Month_48]
           ,[Month_49]
           ,[Month_50]
           ,[Month_51]
           ,[Month_52]
           ,[Month_53]
           ,[Month_54]
           ,[Month_55]
           ,[Month_56]
           ,[Month_57]
           ,[Month_58]
           ,[Month_59]
           ,[Month_60]
           ,[Month_61]
           ,[Month_62]
           ,[Month_63]
           ,[Month_64]
           ,[Month_65]
           ,[Month_66]
           ,[Month_67]
           ,[Month_68]
           ,[Month_69]
           ,[Month_70]
           ,[Month_71]
           ,[Month_72]
           ,[Month_73]
           ,[Month_74]
           ,[Month_75]
           ,[Month_76]
           ,[Month_77]
           ,[Month_78]
           ,[Month_79]
           ,[Month_80]
           ,[Month_81]
           ,[Month_82]
           ,[Month_83]
           ,[Month_84]
           ,[Month_85]
           ,[Month_86]
           ,[Month_87]
           ,[Month_88]
           ,[Month_89]
           ,[Month_90]
           ,[Month_91]
           ,[Month_92]
           ,[Month_93]
           ,[Month_94]
           ,[Month_95]
           ,[Month_96]
           ,[Month_97]
           ,[Month_98]
           ,[Month_99]
           ,[Month_100]
           ,[Month_101]
           ,[Month_102]
           ,[Month_103]
           ,[Month_104]
           ,[Month_105]
           ,[Month_106]
           ,[Month_107]
           ,[Month_108]
           ,[Month_109]
           ,[Month_110]
           ,[Month_111]
           ,[Month_112]
           ,[Month_113]
           ,[Month_114]
           ,[Month_115]
           ,[Month_116]
           ,[Month_117]
           ,[Month_118]
           ,[Month_119]
           ,[Month_120]
           ,[Month_121]
           ,[Month_122]
           ,[Month_123]
           ,[Month_124]
           ,[Month_125]
           ,[Month_126]
           ,[Month_127]
           ,[Month_128]
           ,[Month_129]
           ,[Month_130]
           ,[Month_131]
           ,[Month_132]
           ,[Month_133]
           ,[Month_134]
           ,[Month_135]
           ,[Month_136]
           ,[Month_137]
           ,[Month_138]
           ,[Month_139]
           ,[Month_140]
           ,[Month_141]
           ,[Month_142]
           ,[Month_143]
           ,[Month_144]
           ,[Month_145]
           ,[Month_146]
           ,[Month_147]
           ,[Month_148]
           ,[Month_149]
           ,[Month_150]
           ,[Month_151]
           ,[Month_152]
           ,[Month_153]
           ,[Month_154]
           ,[Month_155]
           ,[Month_156]
           ,[Month_157]
           ,[Month_158]
           ,[Month_159]
           ,[Month_160]
           ,[Month_161]
           ,[Month_162]
           ,[Month_163]
           ,[Month_164]
           ,[Month_165]
           ,[Month_166]
           ,[Month_167]
           ,[Month_168]
           ,[Month_169]
           ,[Month_170]
           ,[Month_171]
           ,[Month_172]
           ,[Month_173]
           ,[Month_174]
           ,[Month_175]
           ,[Month_176]
           ,[Month_177]
           ,[Month_178]
           ,[Month_179]
           ,[Month_180])
SELECT NULL as PROBUILD_ID
      ,app_pro.Name as BUILD_NAME
	  ,'miBuilds_app_' + CONVERT(VARCHAR(8), ApprovedOn, 112) + '_' + app_pro.Name as Filename
      ,Cashflow_Category as CATEGORY
      ,Month_0
      ,Month_1
      ,Month_2
      ,Month_3
      ,Month_4
      ,Month_5
      ,Month_6
      ,Month_7
      ,Month_8
      ,Month_9
      ,Month_10
      ,Month_11
      ,Month_12
      ,Month_13
      ,Month_14
      ,Month_15
      ,Month_16
      ,Month_17
      ,Month_18
      ,Month_19
      ,Month_20
      ,Month_21
      ,Month_22
      ,Month_23
      ,Month_24
      ,Month_25
      ,Month_26
      ,Month_27
      ,Month_28
      ,Month_29
      ,Month_30
      ,Month_31
      ,Month_32
      ,Month_33
      ,Month_34
      ,Month_35
      ,Month_36
      ,Month_37
      ,Month_38
      ,Month_39
      ,Month_40
      ,Month_41
      ,Month_42
      ,Month_43
      ,Month_44
      ,Month_45
      ,Month_46
      ,Month_47
      ,Month_48
      ,Month_49
      ,Month_50
      ,Month_51
      ,Month_52
      ,Month_53
      ,Month_54
      ,Month_55
      ,Month_56
      ,Month_57
      ,Month_58
      ,Month_59
      ,Month_60
      ,Month_61
      ,Month_62
      ,Month_63
      ,Month_64
      ,Month_65
      ,Month_66
      ,Month_67
      ,Month_68
      ,Month_69
      ,Month_70
      ,Month_71
      ,Month_72
      ,Month_73
      ,Month_74
      ,Month_75
      ,Month_76
      ,Month_77
      ,Month_78
      ,Month_79
      ,Month_80
      ,Month_81
      ,Month_82
      ,Month_83
      ,Month_84
      ,Month_85
      ,Month_86
      ,Month_87
      ,Month_88
      ,Month_89
      ,Month_90
      ,Month_91
      ,Month_92
      ,Month_93
      ,Month_94
      ,Month_95
      ,Month_96
      ,Month_97
      ,Month_98
      ,Month_99
      ,Month_100
      ,Month_101
      ,Month_102
      ,Month_103
      ,Month_104
      ,Month_105
      ,Month_106
      ,Month_107
      ,Month_108
      ,Month_109
      ,Month_110
      ,Month_111
      ,Month_112
      ,Month_113
      ,Month_114
      ,Month_115
      ,Month_116
      ,Month_117
      ,Month_118
      ,Month_119
      ,Month_120
      ,Month_121
      ,Month_122
      ,Month_123
      ,Month_124
      ,Month_125
      ,Month_126
      ,Month_127
      ,Month_128
      ,Month_129
      ,Month_130
      ,Month_131
      ,Month_132
      ,Month_133
      ,Month_134
      ,Month_135
      ,Month_136
      ,Month_137
      ,Month_138
      ,Month_139
      ,Month_140
      ,Month_141
      ,Month_142
      ,Month_143
      ,Month_144
      ,Month_145
      ,Month_146
      ,Month_147
      ,Month_148
      ,Month_149
      ,Month_150
      ,Month_151
      ,Month_152
      ,Month_153
      ,Month_154
      ,Month_155
      ,Month_156
      ,Month_157
      ,Month_158
      ,Month_159
      ,Month_160
      ,Month_161
      ,Month_162
      ,Month_163
      ,Month_164
      ,Month_165
      ,Month_166
      ,Month_167
      ,Month_168
      ,Month_169
      ,Month_170
      ,Month_171
      ,Month_172
      ,Month_173
      ,Month_174
      ,Month_175
      ,Month_176
      ,Month_177
      ,Month_178
      ,Month_179
      ,Month_180
FROM BI_MIP.miBuilds.app_Probuild as app_pro
LEFT JOIN BI_MIP.miBuilds.rpt_Cashflow_SMB_ENT as rpt_cash on app_pro.Probuild_Id = rpt_cash.Probuild_Id
WHERE app_pro.Approved = 1
	and record_id <= (SELECT MAX(Record_Id) FROM BI_MIP.miBuilds.rpt_Cashflow_SMB_ENT as z WHERE app_pro.Probuild_Id = z.Probuild_Id GROUP BY Probuild_Id)
	and record_id >= (SELECT MAX(Record_Id) -5 FROM BI_MIP.miBuilds.rpt_Cashflow_SMB_ENT as z WHERE app_pro.Probuild_Id = z.Probuild_Id GROUP BY Probuild_Id)
	and ISNULL(app_pro.Deleted,0) = 0