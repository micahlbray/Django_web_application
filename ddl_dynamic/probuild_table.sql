USE [BI_MIP]
GO

IF OBJECT_ID('miBuilds.app_Probuild') IS NOT NULL DROP TABLE miBuilds.app_Probuild
CREATE TABLE miBuilds.app_Probuild (
	--Build Detail
	Probuild_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_app_Probuild_Probuild_Id PRIMARY KEY,
	Name VARCHAR(255) NOT NULL CONSTRAINT UC_app_Probuild_Name UNIQUE ,
	Region_Id INT NOT NULL CONSTRAINT FK_app_Probuild_lk_Region_Region_Id FOREIGN KEY REFERENCES miBuilds.lk_Region(Region_Id),
	Probuild_City VARCHAR(255),
	State_Id INT NOT NULL CONSTRAINT FK_app_Probuild_lk_State_State_Id FOREIGN KEY REFERENCES miBuilds.lk_State(State_Id),
	Build_Type_Id INT NOT NULL CONSTRAINT FK_app_Probuild_lk_Build_Type_Build_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Build_Type(Build_Type_Id),
	Transport_Type_Id INT NOT NULL CONSTRAINT FK_app_Probuild_lk_Transport_Type_Transport_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Transport_Type(Transport_Type_Id),
	Survey_Type_Id INT NULL CONSTRAINT FK_app_Probuild_lk_Survey_Type_Survey_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Survey_Type(Survey_Type_Id),
	Cross_Functional_Review_On DATETIME,
	Historical_Opportunities INT,
	JT_Id BIGINT,
	
	--Benchmark Information
	Est_Compl_Dt DATETIME,
	ROE_Gate INT,
	ROE_Gate_Dt DATETIME,
	Permitting_Gate_Dt DATETIME,

	--Build Assumptions
	Region_Assump_Id INT NOT NULL CONSTRAINT FK_app_Probuild_assump_Region_Region_Assump_Id FOREIGN KEY REFERENCES miBuilds.assump_Region(Region_Assump_Id),
	MDU_Build_Region_Assump_Id INT NULL CONSTRAINT FK_app_Probuild_assump_MDU_Build_Region_MDU_Build_Region_Assump_Id FOREIGN KEY REFERENCES miBuilds.assump_MDU_Build_Region(MDU_Build_Region_Assump_Id),
	ROW_Est_Build_Cost DECIMAL(20,2) ,
	HeadEnd_Cost DECIMAL(20,2) ,
	Transport_Cost DECIMAL(20,2) ,
	Private_Property_Cost DECIMAL(20,2),
	SMB_ARPU DECIMAL(20,2) ,
	ENT_ARPU DECIMAL(20,2) ,
	SMB_12mo_Pen DECIMAL(5,3) ,
	SMB_36mo_Pen DECIMAL(5,3) ,
	ENT_12mo_Pen DECIMAL(5,3) ,
	ENT_36mo_Pen DECIMAL(5,3) ,

	--Competitive Intel
	Fiber_Competitors_Ct INT,
	Fiber_Competitors VARCHAR(max) NULL,
	Download_Speed_Id INT NULL CONSTRAINT FK_app_Probuild_lk_Download_Speed_Download_Speed_Id FOREIGN KEY REFERENCES miBuilds.lk_Download_Speed(Download_Speed_Id),

	--NonStandard Fields
	Term_Length_Id INT NULL CONSTRAINT FK_app_Probuild_lk_Term_Length_Term_Length_Id FOREIGN KEY REFERENCES miBuilds.lk_Term_Length(Term_Length_Id),
	Access_Fees_One_Time DECIMAL(20,2),
	Access_Fees_Monthly DECIMAL(20,2),

	--Comments
	Comments VARCHAR(max) NULL,
	Considerations VARCHAR(max) NULL,
	Investment_Committee_Takeaway VARCHAR(max) NULL,
	Added INT,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , -- may need to be varchar depeding on user Id type
	Edited INT,
	EditedOn DATETIME ,
	EditedBy VARCHAR(100),
	Submitted INT,
	SubmittedOn DATETIME ,
	SubmittedBy VARCHAR(100) ,
	Approved INT,
	ApprovedOn DATETIME,
	ApprovedBy VARCHAR(100),
	ToDelete INT,
	ToDeleteOn DATETIME,
	ToDeleteBy VARCHAR(100),
	Deleted INT,
	DeletedOn DATETIME,
	DeletedBy VARCHAR(100)
)



/*
	
	/****************************************************************/
	--------------- SHOULD WE STORE THESE IN A TABLE? ---------------
	/****************************************************************/
	--Build Assumptions
	SMB_Additional_OSP_Lateral_Cost_per_Connect VARCHAR(200) NULL,
	ENT_Additional_OSP_Lateral_Cost_per_Connect VARCHAR(200) NULL,
	Perc_Connects_Supported_by_Up_Front_Laterals VARCHAR(20) NULL, --they can change this
	--Build Case Calculations
	Funding_Type VARCHAR(20) NULL,
	SMB_Passings FLOAT NULL,
	ENT_Passings FLOAT NULL,
	Building_Count VARCHAR(200) NULL, --do we need?
	Building_Count_Multi_Tenant VARCHAR(200) NULL, --do we need?
	Total_CAR_Value FLOAT NULL,
	IRR FLOAT NULL,
	IRR_HE_Transport VARCHAR(100) NULL,
	NPV FLOAT NULL,
	Payback_Month VARCHAR(200) NULL,
	Cost_Per_Passing VARCHAR(200) NULL,
	TOTAL_Additional_OSP_Lateral_Cost_per_Connect VARCHAR(200) NULL,
	--Nonstandard Fields
	DEAL_IN_HAND_MRC VARCHAR(100) NULL, --do we need?
	DEAL_IN_HAND_QTY INT NULL, --do we need?
)

*/