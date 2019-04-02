USE BI_MIP
GO

--CREATE SCHEMA miBuilds
IF OBJECT_ID('miBuilds.app_Building') IS NOT NULL DROP TABLE miBuilds.app_Building
CREATE TABLE miBuilds.app_Building (
	Record_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_app_Building_Record_Id PRIMARY KEY,
	Building_Id INT NULL ,
	Probuild_Id INT NOT NULL CONSTRAINT FK_app_Building_app_Probuild_Probuild_Id FOREIGN KEY REFERENCES miBuilds.app_Probuild(Probuild_Id),
	ParentBuilding_Id INT,
	Address VARCHAR(255) ,
	City VARCHAR(150) ,
	State_Id INT NOT NULL CONSTRAINT FK_app_Building_lk_State_State_Id FOREIGN KEY REFERENCES miBuilds.lk_State(State_Id) ,
	Zip varchar(50) ,
	Sellability_Color_Coax VARCHAR(12),
	Sellability_Color_Fiber VARCHAR(12),
	Building_Type_Id INT NOT NULL CONSTRAINT FK_app_Building_lk_Building_Type_Building_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Building_Type(Building_Type_Id),
	Dwelling_Type_Id INT NOT NULL CONSTRAINT FK_app_Building_lk_Dwelling_Type_Dwelling_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Dwelling_Type(Dwelling_Type_Id),
	Building_ROE_Id INT,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , -- may need to be varchar depeding on user Id type
	EditedOn DATETIME ,
	EditedBy VARCHAR(100),
	Deleted INT,
	DeletedOn DATETIME,
	DeletedBy VARCHAR(100)
)

IF OBJECT_ID('miBuilds.app_Business') IS NOT NULL DROP TABLE miBuilds.app_Business
CREATE TABLE miBuilds.app_Business (
	Record_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_app_Business_Record_Id PRIMARY KEY,
	Building_Id INT NULL ,
	ProBuild_Id INT NOT NULL CONSTRAINT FK_app_Business_app_Business_Probuild_Id FOREIGN KEY REFERENCES miBuilds.app_Probuild(Probuild_Id),
	Business_Id INT ,
	Business_Name VARCHAR(255) ,
	Address_Id BIGINT,
	Address_1 VARCHAR(255),
	Address_2 VARCHAR(255),
	Sellability_Color_Coax VARCHAR(12),
	Sellability_Color_Fiber VARCHAR(12),
	Segment_Type_Id INT NOT NULL CONSTRAINT FK_app_Business_lk_Segment_Type_Segment_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Segment_Type(Segment_Type_Id),
	Segment_Assump_Id INT NOT NULL CONSTRAINT FK_app_Business_assump_Segment_Segment_Assump_Id FOREIGN KEY REFERENCES miBuilds.assump_Segment(Segment_Assump_Id),--this will contain ID to compare to all below
	Revised_Segment_Type_Id INT NULL CONSTRAINT FK_app_Business_lk_Segment_Type_Revised_Segment_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Segment_Type(Segment_Type_Id),
	Revised_Segment_Notes VARCHAR(255),
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , -- may need to be varchar depeding on user Id type
	EditedOn DATETIME ,
	EditedBy VARCHAR(100),
	Deleted INT,
	DeletedOn DATETIME,
	DeletedBy VARCHAR(100)
)

IF OBJECT_ID('miBuilds.app_CashFlow') IS NOT NULL DROP TABLE miBuilds.app_CashFlow
CREATE TABLE miBuilds.app_CashFlow (
	CashFlow_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_app_CashFlow_CashFlow_Id PRIMARY KEY,
	Probuild_Id INT NOT NULL CONSTRAINT FK_app_CashFlow_app_Probuild_Probuild_Id FOREIGN KEY REFERENCES miBuilds.app_Probuild(Probuild_Id),
	Category VARCHAR(255) ,
	Mnth INT ,
	Value DECIMAL(22,6),
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , -- may need to be varchar depeding on user Id type
	EditedOn DATETIME ,
	EditedBy VARCHAR(100),
	Deleted INT,
	DeletedOn DATETIME,
	DeletedBy VARCHAR(100)
)

IF OBJECT_ID('miBuilds.app_SF_DealInHand') IS NOT NULL DROP TABLE miBuilds.app_SF_DealInHand
CREATE TABLE miBuilds.app_SF_DealInHand ( -- how to tie directly to Sales Force?
	SF_DealInHand_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_app_SF_DealInHand_SF_DealInHand_Id PRIMARY KEY,
	Probuild_Id INT NOT NULL CONSTRAINT FK_app_SF_DealInHand_app_Probuild_Probuild_Id FOREIGN KEY REFERENCES miBuilds.app_Probuild(Probuild_Id),
	Opportunity_Id VARCHAR(255) ,
	Customer_Name VARCHAR(255) ,
	Term_Length_Id INT NOT NULL CONSTRAINT FK_app_SF_DealInHand_lk_Term_Length_Term_Length_Id FOREIGN KEY REFERENCES miBuilds.lk_Term_Length(Term_Length_Id) , 
	Segment_Type_Id INT NOT NULL CONSTRAINT FK_app_SF_DealInHand_lk_Segment_Type_Segment_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Segment_Type(Segment_Type_Id) ,
	MRR DECIMAL(20,2),
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , -- may need to be varchar depeding on user Id type
	EditedOn DATETIME ,
	EditedBy VARCHAR(100),
	Deleted INT,
	DeletedOn DATETIME,
	DeletedBy VARCHAR(100)
)

IF OBJECT_ID('miBuilds.app_MDU') IS NOT NULL DROP TABLE miBuilds.app_MDU
CREATE TABLE miBuilds.app_MDU ( -- how to tie directly to Sales Force?
	MDU_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_app_MDU_MDU_Id PRIMARY KEY,
	Probuild_Id INT NOT NULL CONSTRAINT FK_app_MDU_app_Probuild_Probuild_Id FOREIGN KEY REFERENCES miBuilds.app_Probuild(Probuild_Id),
	Property_Name VARCHAR(255) ,
	System_Name VARCHAR(255) ,
	Property_Owner VARCHAR(255),
	Est_Compl_Dt DATE,
	MDU_Build_Type_Id INT NOT NULL CONSTRAINT FK_app_MDU_lk_MDU_Build_Type_MDU_Build_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_MDU_Build_Type(MDU_Build_Type_Id),
	Current_Service_Type_Id INT NOT NULL CONSTRAINT FK_MDU_lk_Current_Service_Type_Current_Service_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Current_Service_Type(Current_Service_Type_Id) ,
	Term_Length_Id INT NOT NULL CONSTRAINT FK_app_MDU_lk_Term_Length_Term_Length_Id FOREIGN KEY REFERENCES miBuilds.lk_Term_Length(Term_Length_Id) , 
	MDU_Build_Assump_Id INT NULL CONSTRAINT FK_app_MDU_assump_MDU_Build_MDU_Build_Assump_Id FOREIGN KEY REFERENCES miBuilds.assump_MDU_Build(MDU_Build_Assump_Id), 
	MDU_Build_Region_Assump_Id INT NULL CONSTRAINT FK_app_MDU_assump_MDU_Build_Region_MDU_Build_Region_Assump_Id FOREIGN KEY REFERENCES miBuilds.assump_MDU_Build_Region(MDU_Build_Region_Assump_Id), 
	Building_Ct INT,
	Unit_Ct INT,
	Video_Subscr_Target INT,
	Voice_Subscr_Target INT,
	Data_Subscr_Target INT,
	Video_Penetration DECIMAL(5,3),
	Data_Penetration DECIMAL(5,3),
	Voice_Penetration DECIMAL(5,3),
	Video_ARPU DECIMAL(20,2),
	Data_ARPU DECIMAL(20,2),
	Voice_ARPU DECIMAL(20,2),
	Video_Rev_Share DECIMAL(5,3),
	Data_Rev_Share DECIMAL(5,3),
	Voice_Rev_Share DECIMAL(5,3),
	Opex_Load DECIMAL(5,3),
	Door_Fees DECIMAL(20,2),
	ISP_Per_Unit DECIMAL(20,2),
	Converter DECIMAL(20,2),
	Modem DECIMAL(20,2),
	eMTA DECIMAL(20,2),
	Commission DECIMAL(20,2),
	Penetration_Ramp INT,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , -- may need to be varchar depeding on user Id type
	EditedOn DATETIME ,
	EditedBy VARCHAR(100),
	Deleted INT,
	DeletedOn DATETIME,
	DeletedBy VARCHAR(100)
)

IF OBJECT_ID('miBuilds.app_DataCenter') IS NOT NULL DROP TABLE miBuilds.app_DataCenter
CREATE TABLE miBuilds.app_DataCenter (
	DataCenter_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_app_DataCenter_DataCenter_Id PRIMARY KEY,
	Probuild_Id INT NOT NULL CONSTRAINT FK_app_DataCenter_app_Probuild_Probuild_Id FOREIGN KEY REFERENCES miBuilds.app_Probuild(Probuild_Id),
	Name VARCHAR(255) ,
	Data_Center_Type_Id INT NULL CONSTRAINT FK_app_DataCenter_lk_Data_Center_Type_Data_Center_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Data_Center_Type(Data_Center_Type_Id) , 
	Data_Center_Equip_Type_Id INT NOT NULL CONSTRAINT FK_app_DataCenter_lk_Data_Center_Equip_Type_Data_Center_Equip_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Data_Center_Equip_Type(Data_Center_Equip_Type_Id) , 
	Data_Center_Type_Assump_Id INT NULL CONSTRAINT FK_app_DataCenter_assump_Data_Center_Type_Data_Center_Type_Assump_Id FOREIGN KEY REFERENCES miBuilds.assump_Data_Center_Type(Data_Center_Type_Assump_Id),
	Data_Center_Equip_Type_Assump_Id INT NULL CONSTRAINT FK_app_DataCenter_assump_Data_Center_Equip_Type_Data_Center_Equip_Type_Assump_Id FOREIGN KEY REFERENCES miBuilds.assump_Data_Center_Equip_Type(Data_Center_Equip_Type_Assump_Id),
	Data_Center_Circuit_EOY_Assump_Id INT NULL, --CONSTRAINT FK_app_DataCenter_assump_Data_Center_Circuit_EOY_Data_Center_Circuit_EOY_Assump_Id FOREIGN KEY REFERENCES miBuilds.assump_Data_Center_Circuit_EOY(Data_Center_Circuit_EOY_Assump_Id),
	Comments VARCHAR(255) ,
	IsConnected INT,
	DC_Circuit_Ct INT,
	Rack DECIMAL(20,2),
	Colo_Fee DECIMAL(20,2),
	Connect_Cost DECIMAL(20,2),
	MRR_Per_Circ_Avg DECIMAL(20,2),
	Equip_Capex DECIMAL(20,2),
	Equip_Opex DECIMAL(20,2),
	Opex_Pct DECIMAL(5,3),
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , -- may need to be varchar depeding on user Id type
	EditedOn DATETIME ,
	EditedBy VARCHAR(100),
	Deleted INT,
	DeletedOn DATETIME,
	DeletedBy VARCHAR(100)
)

IF OBJECT_ID('miBuilds.app_File') IS NOT NULL DROP TABLE miBuilds.app_File
CREATE TABLE miBuilds.app_File (
	File_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_app_File_File_Id PRIMARY KEY,
	Probuild_Id INT NOT NULL CONSTRAINT FK_app_File_app_Probuild_Probuild_Id FOREIGN KEY REFERENCES miBuilds.app_Probuild(Probuild_Id),
	Name varchar(255),
	Path varchar(255),
	Root varchar(255),
	File_Type_Id INT NOT NULL CONSTRAINT FK_app_File_lk_File_Type_File_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_File_Type(File_Type_Id), 
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100),
	Deleted INT,
	DeletedOn DATETIME,
	DeletedBy VARCHAR(100)
)

ALTER TABLE miBuilds.app_File
ADD Image varchar(max)

IF OBJECT_ID('miBuilds.app_Building_Upload') IS NOT NULL DROP TABLE miBuilds.app_Building_Upload
CREATE TABLE miBuilds.app_Building_Upload (
	Building_Upload_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_app_Building_Upload_Building_Upload_Id PRIMARY KEY,
	Probuild_Id INT NOT NULL CONSTRAINT FK_app_Building_Upload_app_Probuild_Probuild_Id FOREIGN KEY REFERENCES miBuilds.app_Probuild(Probuild_Id),
	Name varchar(255),
	Path varchar(255),
	Root varchar(255),
	Upload_Type_Id INT NOT NULL CONSTRAINT FK_app_Building_Upload_lk_Upload_Type_Upload_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Upload_Type(Upload_Type_Id), 
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100),
	Deleted INT,
	DeletedOn DATETIME,
	DeletedBy VARCHAR(100)
)

IF OBJECT_ID('miBuilds.app_Business_Upload') IS NOT NULL DROP TABLE miBuilds.app_Business_Upload
CREATE TABLE miBuilds.app_Business_Upload (
	Business_Upload_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_app_Business_Upload_Business_Upload_Id PRIMARY KEY,
	Probuild_Id INT NOT NULL CONSTRAINT FK_app_Business_Upload_app_Probuild_Probuild_Id FOREIGN KEY REFERENCES miBuilds.app_Probuild(Probuild_Id),
	Name varchar(255),
	Path varchar(255),
	Root varchar(255),
	Upload_Type_Id INT NOT NULL CONSTRAINT FK_app_Business_Upload_lk_Upload_Type_Upload_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Upload_Type(Upload_Type_Id),  
	IsDeleted INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100),
	Deleted INT,
	DeletedOn DATETIME,
	DeletedBy VARCHAR(100) 
)

IF OBJECT_ID('miBuilds.rpt_Probuild') IS NOT NULL DROP TABLE miBuilds.rpt_Probuild
CREATE TABLE miBuilds.rpt_Probuild (
	Record_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_rpt_Probuild_Record_Id PRIMARY KEY,
	Probuild_Id INT NOT NULL CONSTRAINT FK_rpt_Probuild_app_Probuild_Probuild_Id FOREIGN KEY REFERENCES miBuilds.app_Probuild(Probuild_Id),
	Lateral_Construct_Upfront_Pct DECIMAL(5,3) ,
	Fund_Bucket VARCHAR(255) ,
	SMB_QB_Ct INT ,
	ENT_QB_Ct INT ,
	Building_Ct INT ,
	Multi_Tenant_Building_Ct INT ,
	CAR_Value DECIMAL(20,2) ,
	IRR_Pct DECIMAL(5,3) ,
	IRR_Pct_Less_HE_Trnsprt DECIMAL(5,3) ,
	NPV DECIMAL(20,2) ,
	Payback_Mo INT ,
	Passing_Cost_Per DECIMAL(20,2) ,
	Additional_OSP_Lateral_Cost_per_Connect DECIMAL(20,2),
	Business_Max_Actual_Capital DECIMAL(20,2) ,
	Resi_Max_Actual_Capital DECIMAL(20,2) ,
	Saved INT,
	Submitted INT,
	Approved INT,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) 	
)


/************************************************************
-------- User Group Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.app_User_Group_Permission') IS NOT NULL DROP TABLE miBuilds.app_User_Group_Permission
CREATE TABLE miBuilds.app_User_Group_Permission (
	User_Group_Permission_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_app_User_Group_Permission_User_Group_Permission_Id PRIMARY KEY
	,Name varchar(100)
	,User_Group_Id INT NOT NULL CONSTRAINT FK_app_User_Group_Permission_lk_User_Group_User_Group_Id FOREIGN KEY REFERENCES miBuilds.lk_User_Group(User_Group_Id)
	,CanCreate INT
	,CanSubmit INT
	,CanApprove INT
	,CanEditSubmitted INT
	,CanEditApproved INT
	,CanViewOnlyCreated INT
	,CanViewAllRegion INT
	,CanViewAllDivision INT
	,CanDeleteOnlyCreated INT
	,CanDeleteAllRegion INT
	,CanDeleteAllDivision INT
	,CAR_MinApproval DECIMAL(20,2)
	,CAR_MaxApproval DECIMAL(20,2)
	,IRR_MinApproval DECIMAL(5,3)
	,IRR_MaxApproval DECIMAL(5,3)
	,IsActive INT 
	,AddedOn DATETIME 
	,AddedBy VARCHAR(100)
	,EditedOn DATETIME
	,EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.app_User_Group_Permission (
	User_Group_Id
	,Name
	,CanCreate
	,CanSubmit 
	,CanApprove
	,CanEditSubmitted
	,CanEditApproved
	,CanViewOnlyCreated
	,CanViewAllRegion
	,CanViewAllDivision
	,CanDeleteOnlyCreated
	,CanDeleteAllRegion
	,CanDeleteAllDivision
	,CAR_MinApproval
	,CAR_MaxApproval
	,IRR_MinApproval
	,IRR_MaxApproval
	,IsActive 
	,AddedOn 
	,AddedBy 
)
VALUES (1, 'Level 2', 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, GETDATE(), 'mbray201')
, (2, 'Level 3', 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 25000, 0.1, 99, 1, GETDATE(), 'mbray201')
, (3, 'Level 4', 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 200000, 0.1, 99, 1, GETDATE(), 'mbray201')
, (4, 'Level 5', 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0.1, 99, 1, GETDATE(), 'mbray201')
, (5, 'Level 6', 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 9999999999999999, 0.1, 99, 1, GETDATE(), 'mbray201')
, (6, 'Level 1', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, GETDATE(), 'mbray201')

IF OBJECT_ID('miBuilds.app_User_Profile') IS NOT NULL DROP TABLE miBuilds.app_User_Profile
CREATE TABLE miBuilds.app_User_Profile (
	User_Profile_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_app_User_Profile_User_Profile_Id PRIMARY KEY 
	,Auth_User_Id INT NOT NULL CONSTRAINT FK_app_User_Profile_auth_User_Auth_User_Id FOREIGN KEY REFERENCES miBuilds.auth_User(Id)
	,NT_Login VARCHAR(255)
	,User_FirstName VARCHAR(255)
	,User_LastName VARCHAR(255)
	,Email VARCHAR(255)
	,Region_Id INT NULL CONSTRAINT FK_app_User_Profile_lk_Region_Region_Id FOREIGN KEY REFERENCES miBuilds.lk_Region(Region_Id)
	,User_Group_Id INT NULL CONSTRAINT FK_app_User_Profile_lk_User_Group_User_Group_Id FOREIGN KEY REFERENCES miBuilds.lk_User_Group(User_Group_Id)
	,User_Group_Permission_Id INT NULL CONSTRAINT FK_app_User_Profile_app_User_Group_Permission_User_Group_Permission_Id FOREIGN KEY REFERENCES miBuilds.app_User_Group_Permission(User_Group_Permission_Id)
	,IsActive INT 
	,AddedOn DATETIME 
	,AddedBy VARCHAR(100)
	,EditedOn DATETIME
	,EditedBy VARCHAR(100) 
)

IF OBJECT_ID('miBuilds.app_User_Feedback') IS NOT NULL DROP TABLE miBuilds.app_User_Feedback
CREATE TABLE miBuilds.app_User_Feedback (
	User_Feedback_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_app_User_Feedback_User_Feedback_Id PRIMARY KEY 
	,Auth_User_Id INT NOT NULL CONSTRAINT FK_app_User_Feedback_auth_User_Auth_User_Id FOREIGN KEY REFERENCES miBuilds.auth_User(Id)
	,Name VARCHAR(255)
	,Comments VARCHAR(MAX)
	,Path varchar(255)
	,Root varchar(255)
	,AddedOn DATETIME
	,AddedBy VARCHAR(100) 
)

IF OBJECT_ID('miBuilds.app_Probuild_Note') IS NOT NULL DROP TABLE miBuilds.app_Probuild_Note
CREATE TABLE miBuilds.app_Probuild_Note (
	Probuild_Note_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_app_Probuild_Note_Probuild_Note_Id PRIMARY KEY 
	,Probuild_Id INT NOT NULL CONSTRAINT FK_app_Probuild_Note_app_Probuild_Probuild_Id FOREIGN KEY REFERENCES miBuilds.app_Probuild(Probuild_Id)
	--,Auth_User_Id INT NOT NULL CONSTRAINT FK_app_Probuild_Note_auth_User_Auth_User_Id FOREIGN KEY REFERENCES miBuilds.auth_User(Id)
	,Note VARCHAR(MAX)
	,Note_Type_Id INT
	,AddedOn DATETIME 
	,AddedBy VARCHAR(100)
	,EditedOn DATETIME 
	,EditedBy VARCHAR(100)
	,Deleted INT
	,DeletedOn DATETIME
	,DeletedBy VARCHAR(100) 
)



IF OBJECT_ID('miBuilds.rpt_Calculator') IS NOT NULL DROP TABLE miBuilds.rpt_Calculator
CREATE TABLE miBuilds.rpt_Calculator (
	Record_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_rpt_Calculator_Record_Id PRIMARY KEY,
	Region_Id INT NOT NULL CONSTRAINT FK_rpt_Calculator_lk_Region_Region_Id FOREIGN KEY REFERENCES miBuilds.lk_Region(Region_Id),
	Region_Assump_Id INT NOT NULL CONSTRAINT FK_rpt_Calculator_assump_Region_Region_Assump_Id FOREIGN KEY REFERENCES miBuilds.assump_Region(Region_Assump_Id),
	MDU_Build_Region_Assump_Id INT NULL CONSTRAINT FK_rpt_Calculator_assump_MDU_Build_Region_MDU_Build_Region_Assump_Id FOREIGN KEY REFERENCES miBuilds.assump_MDU_Build_Region(MDU_Build_Region_Assump_Id),
	Customer_Contribution DECIMAL(20,2) ,
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
	Lateral_Construct_Upfront_Pct DECIMAL(5,3) ,
	Fund_Bucket VARCHAR(255) ,
	SMB_QB_Ct INT ,
	ENT_QB_Ct INT ,
	Building_Ct INT ,
	Multi_Tenant_Building_Ct INT ,
	[SMB_DealInHand_Ct] [int] NULL,
	SMB_DealInHand_MRC DECIMAL(20,2),
	ENT_DealInHand_Ct INT,
	ENT_DealInHand_MRC DECIMAL(20,2),
	[MDU_Ct] [int] NULL,
	[DataCenter_Ct] [int] NULL,
	CAR_Value DECIMAL(20,2) ,
	IRR_Pct DECIMAL(5,3) ,
	IRR_Pct_Less_HE_Trnsprt DECIMAL(5,3) ,
	NPV DECIMAL(20,2) ,
	[NPV_Less_HE_Trnsprt] [decimal](20, 2) NULL,
	Payback_Mo INT ,
	Passing_Cost_Per DECIMAL(20,2) ,
	Additional_OSP_Lateral_Cost_per_Connect DECIMAL(20,2),
	Business_Max_Actual_Capital DECIMAL(20,2) ,
	Resi_Max_Actual_Capital DECIMAL(20,2) ,
	[Business_Capital_Pct] [decimal](5, 3) NULL,
	[Resi_Capital_Pct] [decimal](5, 3) NULL,
	Added INT,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100),
	[Deleted] [int] NULL,
	[DeletedBy] [varchar](100) NULL,
	[DeletedOn] [datetime] NULL,	
)
