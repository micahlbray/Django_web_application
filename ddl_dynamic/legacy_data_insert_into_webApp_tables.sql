if object_id('tempdb..#a') is not null drop table #a
select	miBuilds.udf_ReplaceTextLegacyProbuildData(BUILD_NAME) as Name
		,Region_Id = 
			CASE
				WHEN miBuilds.udf_ReplaceTextLegacyProbuildData(Region) IN ('Mountain', 'Mile High') THEN 'Mountain West'
				ELSE miBuilds.udf_ReplaceTextLegacyProbuildData(Region)
			END
		,miBuilds.udf_ReplaceTextLegacyProbuildData(City) as Probuild_City
		,miBuilds.udf_ReplaceTextLegacyProbuildData(State) as State_Id
		,miBuilds.udf_ReplaceTextLegacyProbuildData(Build_Type) as Build_Type_Id
		,miBuilds.udf_ReplaceTextLegacyProbuildData(Survey_Type) as Survey_Type_Id
		,miBuilds.udf_ReplaceDateLegacyProbuildData(Cross_Functional_Review_Held) as Cross_Functional_Review_On
		,miBuilds.udf_ReplaceIntLegacyProbuildData(Historical_Opportunities) as Historical_Opportunities
		,miBuilds.udf_ReplaceIntLegacyProbuildData(JT_ID) as JT_Id
		,miBuilds.udf_ReplaceDateLegacyProbuildData(Est_Completion_Date) as Est_Compl_Dt
		,miBuilds.udf_ReplaceIntLegacyProbuildData(ROE_Gate) as ROE_Gate
		,miBuilds.udf_ReplaceDateLegacyProbuildData(ROE_Gate_Date) as ROE_Gate_Dt
		,miBuilds.udf_ReplaceDateLegacyProbuildData(Permitting_Gate_Date) as Permitting_Gate_Dt
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(ROW_Est_Build_Cost) as ROW_Est_Build_Cost
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(HeadEnd_Cost) as HeadEnd_Cost
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Transport_Cost) as Transport_Cost
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(SMB_ARPU) as SMB_ARPU
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(ENT_ARPU) as ENT_ARPU
		,miBuilds.udf_ReplacePercentLegacyProbuildData(SMB_12_Month_Pen) as SMB_12mo_Pen
		,miBuilds.udf_ReplacePercentLegacyProbuildData(SMB_36_Month_Pen) as SMB_36mo_Pen
		,miBuilds.udf_ReplacePercentLegacyProbuildData(ENT_12_Month_Pen) as ENT_12mo_Pen
		,miBuilds.udf_ReplacePercentLegacyProbuildData(ENT_36_Month_Pen) as ENT_36mo_Pen
		,miBuilds.udf_ReplaceIntLegacyProbuildData(Count_Fiber_Competitors) as Fiber_Competitors_Ct
		,miBuilds.udf_ReplaceTextLegacyProbuildData(Competitive_Commentary) as Fiber_Competitors
		,miBuilds.udf_ReplaceTextLegacyProbuildData(DSL_Max_Available) as Download_Speed_Id
		,miBuilds.udf_ReplaceIntLegacyProbuildData(TERM) as Term_Length_Id
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(ACCESS_FEES_ONE_TIME) as Access_Fees_One_Time
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(ACCESS_FEES_MONTHLY) as Access_Fees_Monthly
		,miBuilds.udf_ReplaceTextLegacyProbuildData(Comments) as Comments
		,miBuilds.udf_ReplaceTextLegacyProbuildData(Considerations) as Considerations
		,miBuilds.udf_ReplaceTextLegacyProbuildData(Investment_Committee_Takeaway) as Investment_Committee_Takeaway
		,1 as Added
		,1 as Submitted
		,1 as Approved
		,miBuilds.udf_ReplaceDateLegacyProbuildData(Approval_Date) as ApprovedOn
		,miBuilds.udf_ReplaceTextLegacyProbuildData(Approver) as ApprovedBy
into	#a
from	MIP2.PROBUILD_SUMMARY_mbray201_20180712_backup as a
where	a.build_name IN ('HAPPY TERIYAKI 4', 'SBF_Tracy_157 Sloan Ct')

update	a
SET		a.Region_Id = reg.Region_Id
from	#a as a
	LEFT JOIN miBuilds.lk_Region as reg
	ON a.Region_Id = reg.Name

update	a
SET		a.State_Id = state.State_Id
from	#a as a
	LEFT JOIN miBuilds.lk_State as state
	ON a.State_Id = CASE
						WHEN LEN(a.State_Id) > 2 THEN state.Name
						ELSE state.Abbrev
					END

update	a
SET		a.Build_Type_Id = build.Build_Type_Id
from	#a as a
	LEFT JOIN miBuilds.lk_Build_Type as build
	ON a.Build_Type_Id = build.Name

update	a
SET		a.Survey_Type_Id = survey.Survey_Type_Id
from	#a as a
	LEFT JOIN miBuilds.lk_Survey_Type as survey
	ON a.Survey_Type_Id = survey.Name

update	a
SET		a.Download_Speed_Id = down.Download_Speed_Id
from	#a as a	
	LEFT JOIN miBuilds.lk_Download_Speed as down
	ON a.Download_Speed_Id = down.Name

update	a
SET		a.Term_Length_Id = term.Term_Length_Id
from	#a as a
	LEFT JOIN miBuilds.lk_Term_Length as term
	ON a.Term_Length_Id = term.Term

select * from #a


insert into app_Probuild(
		Name
		,Region_Id
		,Probuild_City
		,State_Id
		,Build_Type_Id
		,Survey_Type_Id
		,Cross_Functional_Review_On
		,Historical_Opportunities
		,JT_Id
		,Est_Compl_Dt
		,ROE_Gate
		,ROE_Gate_Dt
		,Permitting_Gate_Dt
		,ROW_Est_Build_Cost
		,HeadEnd_Cost
		,Transport_Cost
		,SMB_ARPU
		,ENT_ARPU
		,SMB_12mo_Pen
		,SMB_36mo_Pen
		,ENT_12mo_Pen
		,ENT_36mo_Pen
		,Fiber_Competitors_Ct
		,Fiber_Competitors
		,Download_Speed_Id
		,Term_Length_Id
		,Access_Fees_One_Time
		,Access_Fees_Monthly
		,Comments
		,Considerations
		,Investment_Committee_Takeaway
		,Added
		,Submitted
		,Approved
		,ApprovedOn
		,ApprovedBy
		,Legacy
		)
select	Name
		,Region_Id
		,Probuild_City
		,State_Id
		,Build_Type_Id
		,Survey_Type_Id
		,Cross_Functional_Review_On
		,Historical_Opportunities
		,JT_Id
		,Est_Compl_Dt
		,ROE_Gate
		,ROE_Gate_Dt
		,Permitting_Gate_Dt
		,ROW_Est_Build_Cost
		,HeadEnd_Cost
		,Transport_Cost
		,SMB_ARPU
		,ENT_ARPU
		,SMB_12mo_Pen
		,SMB_36mo_Pen
		,ENT_12mo_Pen
		,ENT_36mo_Pen
		,Fiber_Competitors_Ct
		,Fiber_Competitors
		,Download_Speed_Id
		,Term_Length_Id
		,Access_Fees_One_Time
		,Access_Fees_Monthly
		,Comments
		,Considerations
		,Investment_Committee_Takeaway
		,Added
		,Submitted
		,Approved
		,ApprovedOn
		,ApprovedBy
		,1
from	#a

if object_id('tempdb..#b') is not null drop table #b
select	a.Probuild_Id
		,miBuilds.udf_ReplacePercentLegacyProbuildData([Perc_Connects_Supported_by_Up_Front_Laterals]) as [Lateral_Construct_Upfront_Pct]
		,miBuilds.udf_ReplaceTextLegacyProbuildData([Funding_Type]) as [Fund_Bucket]
		,miBuilds.udf_ReplaceIntLegacyProbuildData([SMB_Passings]) as [SMB_QB_Ct]
		,miBuilds.udf_ReplaceIntLegacyProbuildData([ENT_Passings]) as [ENT_QB_Ct]
		,miBuilds.udf_ReplaceIntLegacyProbuildData([Building_Count]) as [Building_Ct]
		,miBuilds.udf_ReplaceIntLegacyProbuildData([Building_Count_Multi_Tenant]) as [Multi_Tenant_Building_Ct]
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData([Total_CAR_Value]) as [CAR_Value]
		,miBuilds.udf_ReplacePercentLegacyProbuildData([IRR]) as [IRR_Pct]
		,miBuilds.udf_ReplacePercentLegacyProbuildData([IRR_HE_Transport]) as [IRR_Pct_Less_HE_Trnsprt]
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData([NPV]) as [NPV]
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData([Payback_Month]) as [Payback_Mo]
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData([Cost_Per_Passing]) as [Passing_Cost_Per]
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData([TOTAL_Additional_OSP_Lateral_Cost_per_Connect]) as [Additional_OSP_Lateral_Cost_per_Connect]
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData([Business_Max_Actual_Capital]) as [Business_Max_Actual_Capital]
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData([Resi_Max_Actual_Capital]) as [Resi_Max_Actual_Capital]
into	#b
from	app_Probuild as a
	JOIN MIP2.PROBUILD_SUMMARY_mbray201_20180712_backup as b
	ON a.Name = b.BUILD_NAME
	JOIN #a as c
	ON a.Name = c.Name
where a.name IN ('HAPPY TERIYAKI 4', 'SBF_Tracy_157 Sloan Ct')

insert into rpt_Probuild(
		Probuild_Id
		,Lateral_Construct_Upfront_Pct
		,Fund_Bucket
		,SMB_QB_Ct
		,ENT_QB_Ct
		,Building_Ct
		,Multi_Tenant_Building_Ct
		,CAR_Value
		,IRR_Pct
		,IRR_Pct_Less_HE_Trnsprt
		,NPV
		,Payback_Mo
		,Passing_Cost_Per
		,Additional_OSP_Lateral_Cost_per_Connect
		,Business_Max_Actual_Capital
		,Resi_Max_Actual_Capital
		)
select	Probuild_Id
		,Lateral_Construct_Upfront_Pct
		,Fund_Bucket
		,SMB_QB_Ct
		,ENT_QB_Ct
		,Building_Ct
		,Multi_Tenant_Building_Ct
		,CAR_Value
		,IRR_Pct
		,IRR_Pct_Less_HE_Trnsprt
		,NPV
		,Payback_Mo
		,Passing_Cost_Per
		,Additional_OSP_Lateral_Cost_per_Connect
		,Business_Max_Actual_Capital
		,Resi_Max_Actual_Capital
from	#b

if object_id('tempdb..#c') is not null drop table #c
select	a.Probuild_Id
		,miBuilds.udf_ReplaceIntLegacyProbuildData(NAX_BUILDING_ID) as Building_Id
		,miBuilds.udf_ReplaceIntLegacyProbuildData([Parent Bldg ID]) as ParentBuilding_Id
		,miBuilds.udf_ReplaceTextLegacyProbuildData([Building Address]) as Address
		,miBuilds.udf_ReplaceTextLegacyProbuildData(City) as City
		,miBuilds.udf_ReplaceTextLegacyProbuildData(State) as State_Id
		,miBuilds.udf_ReplaceTextLegacyProbuildData(Zip) as Zip
		,miBuilds.udf_ReplaceTextLegacyProbuildData(BUILDING_TYPE) as Building_Type_Id
		,miBuilds.udf_ReplaceTextLegacyProbuildData(DWELLING_TYPE) as Dwelling_Type_Id
into	#c
from	BI_MIP.miBuilds.app_Probuild as a
	JOIN MIP2.[PROBUILD_BUILDINGS_mbray201_20180712_backup] as b
	ON a.Name = b.BUILD_NAME
	JOIN #a as c
	ON a.Name = c.Name
where a.name IN ('HAPPY TERIYAKI 4', 'SBF_Tracy_157 Sloan Ct')

update	c
SET		c.State_Id = state.State_Id
from	#c as c
	LEFT JOIN miBuilds.lk_State as state
	ON c.State_Id = CASE
						WHEN LEN(c.State_Id) > 2 THEN state.Name
						ELSE state.Abbrev
					END

update	c
SET		c.Building_Type_Id = build.Building_Type_Id
from	#c as c
	LEFT JOIN miBuilds.lk_Building_Type as build
	ON c.Building_Type_Id = build.Name

update	c
SET		c.Dwelling_Type_Id = dwell.Dwelling_Type_Id
from	#c as c
	LEFT JOIN miBuilds.lk_Dwelling_Type as dwell
	ON c.Dwelling_Type_Id = dwell.Name

update	c
SET		c.ParentBuilding_Id = NULL
from	#c as c
where	ParentBuilding_Id = 0

select * from #c

insert into app_Building(
		Probuild_Id
		,Building_Id
		,ParentBuilding_Id
		,Address
		,City
		,State_Id
		,Zip
		,Building_Type_Id
		,Dwelling_Type_Id
		)
select	Probuild_Id
		,Building_Id
		,ParentBuilding_Id
		,Address
		,City
		,State_Id
		,Zip
		,Building_Type_Id
		,Dwelling_Type_Id
from	#c


if object_id('tempdb..#d') is not null drop table #d
select	a.Probuild_Id
		,b.Build_Name
		,miBuilds.udf_ReplaceTextLegacyProbuildData(CATEGORY) as Cashflow_Category
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_0) as Month_0
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_1) as Month_1
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_2) as Month_2
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_3) as Month_3
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_4) as Month_4
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_5) as Month_5
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_6) as Month_6
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_7) as Month_7
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_8) as Month_8
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_9) as Month_9
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_10) as Month_10
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_11) as Month_11
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_12) as Month_12
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_13) as Month_13
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_14) as Month_14
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_15) as Month_15
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_16) as Month_16
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_17) as Month_17
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_18) as Month_18
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_19) as Month_19
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_20) as Month_20
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_21) as Month_21
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_22) as Month_22
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_23) as Month_23
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_24) as Month_24
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_25) as Month_25
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_26) as Month_26
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_27) as Month_27
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_28) as Month_28
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_29) as Month_29
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_30) as Month_30
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_31) as Month_31
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_32) as Month_32
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_33) as Month_33
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_34) as Month_34
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_35) as Month_35
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_36) as Month_36
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_37) as Month_37
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_38) as Month_38
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_39) as Month_39
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_40) as Month_40
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_41) as Month_41
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_42) as Month_42
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_43) as Month_43
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_44) as Month_44
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_45) as Month_45
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_46) as Month_46
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_47) as Month_47
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_48) as Month_48
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_49) as Month_49
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_50) as Month_50
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_51) as Month_51
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_52) as Month_52
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_53) as Month_53
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_54) as Month_54
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_55) as Month_55
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_56) as Month_56
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_57) as Month_57
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_58) as Month_58
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_59) as Month_59
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_60) as Month_60
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_61) as Month_61
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_62) as Month_62
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_63) as Month_63
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_64) as Month_64
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_65) as Month_65
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_66) as Month_66
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_67) as Month_67
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_68) as Month_68
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_69) as Month_69
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_70) as Month_70
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_71) as Month_71
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_72) as Month_72
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_73) as Month_73
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_74) as Month_74
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_75) as Month_75
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_76) as Month_76
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_77) as Month_77
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_78) as Month_78
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_79) as Month_79
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_80) as Month_80
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_81) as Month_81
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_82) as Month_82
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_83) as Month_83
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_84) as Month_84
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_85) as Month_85
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_86) as Month_86
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_87) as Month_87
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_88) as Month_88
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_89) as Month_89
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_90) as Month_90
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_91) as Month_91
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_92) as Month_92
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_93) as Month_93
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_94) as Month_94
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_95) as Month_95
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_96) as Month_96
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_97) as Month_97
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_98) as Month_98
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_99) as Month_99
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_100) as Month_100
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_101) as Month_101
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_102) as Month_102
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_103) as Month_103
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_104) as Month_104
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_105) as Month_105
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_106) as Month_106
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_107) as Month_107
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_108) as Month_108
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_109) as Month_109
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_110) as Month_110
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_111) as Month_111
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_112) as Month_112
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_113) as Month_113
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_114) as Month_114
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_115) as Month_115
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_116) as Month_116
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_117) as Month_117
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_118) as Month_118
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_119) as Month_119
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_120) as Month_120
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_121) as Month_121
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_122) as Month_122
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_123) as Month_123
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_124) as Month_124
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_125) as Month_125
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_126) as Month_126
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_127) as Month_127
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_128) as Month_128
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_129) as Month_129
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_130) as Month_130
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_131) as Month_131
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_132) as Month_132
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_133) as Month_133
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_134) as Month_134
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_135) as Month_135
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_136) as Month_136
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_137) as Month_137
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_138) as Month_138
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_139) as Month_139
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_140) as Month_140
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_141) as Month_141
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_142) as Month_142
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_143) as Month_143
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_144) as Month_144
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_145) as Month_145
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_146) as Month_146
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_147) as Month_147
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_148) as Month_148
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_149) as Month_149
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_150) as Month_150
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_151) as Month_151
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_152) as Month_152
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_153) as Month_153
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_154) as Month_154
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_155) as Month_155
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_156) as Month_156
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_157) as Month_157
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_158) as Month_158
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_159) as Month_159
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_160) as Month_160
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_161) as Month_161
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_162) as Month_162
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_163) as Month_163
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_164) as Month_164
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_165) as Month_165
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_166) as Month_166
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_167) as Month_167
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_168) as Month_168
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_169) as Month_169
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_170) as Month_170
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_171) as Month_171
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_172) as Month_172
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_173) as Month_173
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_174) as Month_174
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_175) as Month_175
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_176) as Month_176
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_177) as Month_177
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_178) as Month_178
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_179) as Month_179
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(Month_180) as Month_180
into	#d
from	BI_MIP.miBuilds.app_Probuild as a
	JOIN MIP2.PROBUILD_CASHFLOW_mbray201_20180712_backup as b
	ON a.Name = b.BUILD_NAME
	JOIN #a as c
	ON a.Name = c.Name
where a.name IN ('HAPPY TERIYAKI 4', 'SBF_Tracy_157 Sloan Ct')

INSERT INTO miBuilds.rpt_Cashflow_SMB_ENT
           (Probuild_Id
           ,Cashflow_Category
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
		   )
select	Probuild_Id
           ,Cashflow_Category
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
from	#d

if object_id('tempdb..#e') is not null drop table #e
select	a.Probuild_Id
		,miBuilds.udf_ReplaceTextLegacyProbuildData(Salesforce_Opportunity_ID) as Opportunity_Id
		,miBuilds.udf_ReplaceTextLegacyProbuildData(Customer_Name) as Customer_Name
		,miBuilds.udf_ReplaceTextLegacyProbuildData(Product_Type) as Term_Length_Id
		,miBuilds.udf_ReplaceTextLegacyProbuildData(Num_Sites) as Segment_Type_Id
		,miBuilds.udf_ReplaceDecimalLegacyProbuildData(MRR) as MRR
into	#e
from	BI_MIP.miBuilds.app_Probuild as a
	JOIN MIP2.PROBUILD_DEALSINHAND_mbray201_20180712_backup as b
	ON a.Name = b.BUILD_NAME
	JOIN #a as c
	ON a.Name = c.Name
where a.name IN ('HAPPY TERIYAKI 4', 'SBF_Tracy_157 Sloan Ct')

update	a
SET		a.Term_Length_Id = term.Term_Length_Id
from	#e as a
	LEFT JOIN miBuilds.lk_Term_Length as term
	ON a.Term_Length_Id = term.Term

update	a
SET		a.Segment_Type_Id = seg.Segment_Type_Id
from	#e as a
	LEFT JOIN miBuilds.lk_Segment_Type as seg
	ON a.Term_Length_Id = seg.Name
	
insert into app_SF_DealInHand(
		Probuild_Id
		,Opportunity_Id
		,Customer_Name
		,Term_Length_Id
		,Segment_Type_Id
		,MRR
		)
select	Probuild_Id
		,Opportunity_Id
		,Customer_Name
		,Term_Length_Id
		,Segment_Type_Id
		,MRR
from	#e



if object_id('tempdb..#a') is not null drop table #a
select 
bi_mip.miBuilds.udf_ReplaceIntLegacyProbuildData([NAX_BUILDING_ID]) as [Building_Id]
,b.Probuild_Id
,bi_mip.miBuilds.udf_ReplaceTextLegacyProbuildData([MIP Qb Name]) as [Business_Name]
,[Qb Segment] as [Segment_Type_Id]
,[Revised_Segment] as [Revised_Segment_Type_Id]
,bi_mip.miBuilds.udf_ReplaceTextLegacyProbuildData([Revised_Segment_NOTES]) as [Revised_Segment_Notes]
into #a
from bi_mip.MIP2.PROBUILD_BUSINESSES_mbray201_20180712_backup 
join  [BI_MIP].[miBuilds].[app_Probuild] as b on b.name = build_name
where b.legacy = '1'
and b.name IN ('HAPPY TERIYAKI 4', 'SBF_Tracy_157 Sloan Ct')

update	a
SET		a.[Segment_Type_Id] = seg.Segment_Type_Id
from	#a as a
	LEFT JOIN miBuilds.lk_Segment_Type as seg
	ON a.[Segment_Type_Id] = seg.Name

update	a
SET		a.[Revised_Segment_Type_Id] = seg.Segment_Type_Id
from	#a as a
	LEFT JOIN miBuilds.lk_Segment_Type as seg
	ON a.[Revised_Segment_Type_Id] = seg.Name

insert into bi_mip.mibuilds.app_Business 
(
[Building_Id]
,[ProBuild_Id]
,[Business_Name]
,[Segment_Type_Id]
,[Revised_Segment_Type_Id]
,[Revised_Segment_Notes]
)
select 
[Building_Id]
,[ProBuild_Id]
,[Business_Name]
,[Segment_Type_Id]
,[Revised_Segment_Type_Id]
,[Revised_Segment_Notes]
from #a 


/*
/*****************************************************************************************************
---------------- FIXING ISSUES CAUSED BY THE INSERT
*******************************************************************************************************/
update	rpt_pro
SET	 rpt_pro.Total_CAR_Value = a.Legacy_CAR_Value
	,rpt_pro.CAR_Value = a.Legacy_CAR_Value
from [BI_MIP].[miBuilds].rpt_CAR_Value_Diff as a
	LEFT JOIN [BI_MIP].[miBuilds].[rpt_Probuild] as rpt_pro 
	ON a.Probuild_Id = rpt_pro.Probuild_id
				AND rpt_pro.Record_Id = (SELECT MAX(Record_Id) FROM [BI_MIP].[miBuilds].[rpt_Probuild] as z WHERE a.Probuild_Id = z.Probuild_Id)
WHERE a.Legacy = 1
	and a.CAR_Diff > 5

update	rpt_pro
SET	 rpt_pro.Total_CAR_Value = a.Legacy_CAR_Value
	,rpt_pro.CAR_Value = a.Legacy_CAR_Value
from [BI_MIP].[miBuilds].rpt_CAR_Value_Diff as a
	LEFT JOIN [BI_MIP].[miBuilds].[rpt_Probuild] as rpt_pro 
	ON a.Probuild_Id = rpt_pro.Probuild_id
				AND rpt_pro.Record_Id = (SELECT MAX(Record_Id) FROM [BI_MIP].[miBuilds].[rpt_Probuild] as z WHERE a.Probuild_Id = z.Probuild_Id)
WHERE a.Legacy = 1
	and a.CAR_Diff < -5

update	rpt_pro
SET	 rpt_pro.DealInHand_Ct = a.DEAL_IN_HAND_QTY
FROM MIP2.PROBUILD_SUMMARY_mbray201_20180712_backup as a
	JOIN app_Probuild as b
	ON a.BUILD_NAME = b.Name
	JOIN [BI_MIP].[miBuilds].[rpt_Probuild] as rpt_pro 
	ON b.Probuild_Id = rpt_pro.Probuild_id
				AND rpt_pro.Record_Id = (SELECT MAX(Record_Id) FROM [BI_MIP].[miBuilds].[rpt_Probuild] as z WHERE b.Probuild_Id = z.Probuild_Id)
WHERE b.Legacy = 1
*/