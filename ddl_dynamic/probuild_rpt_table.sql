USE [BI_MIP]
GO

IF OBJECT_ID('miBuilds.rpt_Probuild') IS NOT NULL DROP TABLE miBuilds.rpt_Probuild
CREATE TABLE miBuilds.rpt_Probuild (
	Probuild_Id INT NOT NULL CONSTRAINT FK_rpt_Probuild_app_Probuild_Probuild_Id FOREIGN KEY REFERENCES miBuilds.app_Probuild(Probuild_Id),
	Fund_Bucket VARCHAR(255) ,
	SMB_QB_Ct INT ,
	ENT_QB_Ct INT ,
	Building_Ct INT ,
	Multi_Tenant_Building_Ct INT ,
	CAR_Value DECIMAL(20,8) ,
	IRR_Pct DECIMAL(20,8) ,
	IRR_Pct_Less_HE_Trnsprt DECIMAL(20,8) ,
	NPV DECIMAL(20,8) ,
	Payback_Mo INT ,
	Passing_Cost_Per DECIMAL(20,8) ,
	Additional_OSP_Lateral_Cost_per_Connect DECIMAL(20,8)
)