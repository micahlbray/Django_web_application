USE BI_MIP
GO

--CREATE SCHEMA miBuilds

/************************************************************
-------- Building Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_Building_Type') IS NOT NULL DROP TABLE miBuilds.lk_Building_Type
CREATE TABLE miBuilds.lk_Building_Type (
	Building_Type_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_Building_Type_Building_Type_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_Building_Type (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy
)
VALUES ('Standard', 1, GETDATE(), 'mbray201')
, ('MDU', 1, GETDATE(), 'mbray201')
, ('SFU', 1, GETDATE(), 'mbray201')
, ('Data Center', 1, GETDATE(), 'mbray201')
, ('Greenfield', 1, GETDATE(), 'mbray201')

/************************************************************
-------- Dwelling Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_Dwelling_Type') IS NOT NULL DROP TABLE miBuilds.lk_Dwelling_Type
CREATE TABLE miBuilds.lk_Dwelling_Type (
	Dwelling_Type_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_Dwelling_Type_Dwelling_Type_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_Dwelling_Type (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy
)
VALUES ('Single-Tenant', 1, GETDATE(), 'mbray201')
, ('Multi-Tenant', 1, GETDATE(), 'mbray201')
, ('Part of Multi-Tenant', 1, GETDATE(), 'mbray201')

/************************************************************
-------- Segment Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_Segment_Type') IS NOT NULL DROP TABLE miBuilds.lk_Segment_Type
CREATE TABLE miBuilds.lk_Segment_Type (
	Segment_Type_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_Segment_Type_Segment_Type_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) ,
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_Segment_Type (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy 
)
VALUES ('SMB', 1, GETDATE(), 'mbray201')
, ('ENT', 1, GETDATE(), 'mbray201')
, ('MAJ', 1, GETDATE(), 'mbray201')
, ('NAT', 1, GETDATE(), 'mbray201')
, ('GED', 1, GETDATE(), 'mbray201')
, ('FED', 1, GETDATE(), 'mbray201')

/************************************************************
-------- Term Length --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_Term_Length') IS NOT NULL DROP TABLE miBuilds.lk_Term_Length
CREATE TABLE miBuilds.lk_Term_Length (
	Term_Length_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_Term_Length_Term_Length_Id PRIMARY KEY,
	Term varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_Term_Length (
	Term ,
	IsActive ,
	AddedOn ,
	AddedBy 
)
VALUES ('12', 1, GETDATE(), 'mbray201')
, ('24', 1, GETDATE(), 'mbray201')
, ('36', 1, GETDATE(), 'mbray201')
, ('48', 1, GETDATE(), 'mbray201')
, ('60', 1, GETDATE(), 'mbray201')
, ('120', 1, GETDATE(), 'mbray201')
, ('180', 1, GETDATE(), 'mbray201')

/************************************************************
-------- Build Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_Build_Type') IS NOT NULL DROP TABLE miBuilds.lk_Build_Type
CREATE TABLE miBuilds.lk_Build_Type (
	Build_Type_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_Build_Type_Build_Type_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_Build_Type (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy 
)
VALUES ('Probuild', 1, GETDATE(), 'mbray201')
, ('Smartbuild', 1, GETDATE(), 'mbray201')
, ('Greenfield', 1, GETDATE(), 'mbray201')
, ('Data Center', 1, GETDATE(), 'mbray201')

/************************************************************
-------- Transport Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_Transport_Type') IS NOT NULL DROP TABLE miBuilds.lk_Transport_Type
CREATE TABLE miBuilds.lk_Transport_Type (
	Build_Type_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_Transport_Type_Transport_Type_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_Transport_Type (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy 
)
VALUES ('Coax', 1, GETDATE(), 'mbray201')
, ('Fiber', 1, GETDATE(), 'mbray201')
, ('Both', 1, GETDATE(), 'mbray201')

/************************************************************
-------- Survey Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_Survey_Type') IS NOT NULL DROP TABLE miBuilds.lk_Survey_Type
CREATE TABLE miBuilds.lk_Survey_Type (
	Survey_Type_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_Survey_Type_Survey_Type_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) ,
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_Survey_Type (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy 
)
VALUES ('Walkout', 1, GETDATE(), 'mbray201')
, ('Desktop', 1, GETDATE(), 'mbray201')

/************************************************************
-------- Conduit Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_Conduit_Type') IS NOT NULL DROP TABLE miBuilds.lk_Conduit_Type
CREATE TABLE miBuilds.lk_Conduit_Type (
	Conduit_Type_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_Conduit_Type_Conduit_Type_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_Conduit_Type (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy 
)
VALUES ('Coax', 1, GETDATE(), 'mbray201')
, ('Fiber', 1, GETDATE(), 'mbray201')
, ('Both', 1, GETDATE(), 'mbray201')

/************************************************************
-------- Download Speed --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_Download_Speed') IS NOT NULL DROP TABLE miBuilds.lk_Download_Speed
CREATE TABLE miBuilds.lk_Download_Speed (
	Download_Speed_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_Download_Speed_Download_Speed_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_Download_Speed (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy 
)
VALUES ('768-1.5 mbps', 1, GETDATE(), 'mbray201')
, ('1.5-3 mbps', 1, GETDATE(), 'mbray201')
, ('3-6 mbps', 1, GETDATE(), 'mbray201')
, ('6-10 mbps', 1, GETDATE(), 'mbray201')
, ('10-25 mbps', 1, GETDATE(), 'mbray201')
, ('25-50 mbps', 1, GETDATE(), 'mbray201')
, ('50-100 mbps', 1, GETDATE(), 'mbray201')
, ('100 mbps-1 gps', 1, GETDATE(), 'mbray201')
, ('>1 gps', 1, GETDATE(), 'mbray201')
, ('UNKNOWN', 1, GETDATE(), 'mbray201')

/************************************************************
-------- MDU Build Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_MDU_Build_Type') IS NOT NULL DROP TABLE miBuilds.lk_MDU_Build_Type
CREATE TABLE miBuilds.lk_MDU_Build_Type (
	MDU_Build_Type_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_MDU_Build_Type_MDU_Build_Type_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_MDU_Build_Type (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy 
)
VALUES ('Greenfield', 1, GETDATE(), 'mbray201')
, ('Brownfield', 1, GETDATE(), 'mbray201')
, ('SFU', 1, GETDATE(), 'mbray201')

/************************************************************
-------- Current Service Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_Current_Service_Type') IS NOT NULL DROP TABLE miBuilds.lk_Current_Service_Type
CREATE TABLE miBuilds.lk_Current_Service_Type (
	Current_Service_Type_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_Current_Service_Type_Current_Service_Type_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100)
)
INSERT INTO miBuilds.lk_Current_Service_Type (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy 
)
VALUES ('Coax', 1, GETDATE(), 'mbray201')
, ('Fiber', 1, GETDATE(), 'mbray201')
, ('In Bulk Contract', 1, GETDATE(), 'mbray201')
, ('None', 1, GETDATE(), 'mbray201')

/************************************************************
-------- Region --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_Region') IS NOT NULL DROP TABLE miBuilds.lk_Region
CREATE TABLE miBuilds.lk_Region (
	Region_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_Region_Region_Id PRIMARY KEY ,
	Name varchar(100) ,
	Lead_Email VARCHAR(150) ,
	Lead_Backup_Email VARCHAR(150) ,
	Review_Email VARCHAR(150) ,
	Review_Backup_Email VARCHAR(150) ,
	Invest_Committ_Email_Distro VARCHAR(150) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(50) ,
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_Region (
	Name ,
	Lead_Email ,
	Lead_Backup_Email ,
	Review_Email ,
	Review_Backup_Email ,
	Invest_Committ_Email_Distro ,
	IsActive ,
	AddedOn ,
	AddedBy
)
VALUES ('California', 'KENNETH_BRODOFF@comcast.com', 'Ted_Girdner@cable.comcast.com','_WD_CA_MDInvestmentCommitteeApproval_@comcast.com', NULL, NULL, 1, GETDATE(), 'mbray201')
, ('Houston','Jamie_Lazaro@cable.comcast.com','John_Phillips@comcast.com','_WD_HOU_MDInvestmentCommitteeApproval_@comcast.com', 'Jake_Fowler@comcast.com', 'Chad_LeBrun@comcast.com', 1, GETDATE(), 'mbray201')
, ('Mountain West','Kirk_Joss@cable.comcast.com','Shawn_Adamson@cable.comcast.com','_WD_MTN_MDInvestmentCommitteeApproval_@comcast.com', NULL, NULL, 1, GETDATE(), 'mbray201')
, ('Portland','Chris_Carey2@cable.comcast.com','Joni_Pierce@cable.comcast.com','_WD_OR_MDInvestmentCommitteeApproval_@comcast.com', NULL, NULL,  1, GETDATE(), 'mbray201')
, ('Seattle','Tim_Klinefelter@cable.comcast.com','Matthew_Fassnacht@cable.comcast.com','_WD_WA_MDInvestmentCommitteeApproval_@comcast.com', NULL, NULL, 1, GETDATE(), 'mbray201')
, ('Twin Cities','Thomas_Salmi-Bydalek@cable.comcast.com','Kaylene_Hautamaki@cable.comcast.com','_WD_TC_MDInvestmentCommitteeApproval_@comcast.com', NULL, NULL, 1, GETDATE(), 'mbray201')
, ('Division', NULL, NULL, NULL, NULL, NULL, 1, GETDATE(), 'mbray201')

/************************************************************
-------- State --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_State') IS NOT NULL DROP TABLE miBuilds.lk_State
CREATE TABLE miBuilds.lk_State (
	State_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_State_State_Id PRIMARY KEY,
	Name varchar(100),
	Abbrev varchar(2) ,
	Region_Id INT NOT NULL CONSTRAINT FK_lk_State_lk_Region_Region_Id FOREIGN KEY REFERENCES miBuilds.lk_Region(Region_Id),
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) ,
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_State (
	Name,
	Abbrev ,
	Region_Id,
	IsActive ,
	AddedOn ,
	AddedBy
)
VALUES ('California','CA', 1, 1, GETDATE(), 'mbray201')
, ('Texas','TX', 2, 1, GETDATE(), 'mbray201')
, ('Colorado','CO', 3, 1, GETDATE(), 'mbray201')
, ('New Mexico','NM', 3, 1, GETDATE(), 'mbray201')
, ('Arizona','AZ', 3, 1, GETDATE(), 'mbray201')
, ('Utah','UT', 3, 1, GETDATE(), 'mbray201')
, ('Idaho','ID', 3, 1, GETDATE(), 'mbray201')
, ('Oregon','OR', 4, 1, GETDATE(), 'mbray201')
, ('Washington','WA', 4, 1, GETDATE(), 'mbray201')
, ('Washington','WA', 5, 1, GETDATE(), 'mbray201')
, ('Kansas','KS', 6, 1, GETDATE(), 'mbray201')
, ('Minnesota','MN', 6, 1, GETDATE(), 'mbray201')
, ('Missouri','MO', 6, 1, GETDATE(), 'mbray201')
, ('Wisconsin','WI', 6, 1, GETDATE(), 'mbray201')

/************************************************************
-------- Region Assumptions --------
*************************************************************/
IF OBJECT_ID('miBuilds.assump_Region') IS NOT NULL DROP TABLE miBuilds.assump_Region
CREATE TABLE miBuilds.assump_Region (
	Region_Assump_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_assump_Region_Region_Assump_Id PRIMARY KEY,
	Name varchar(100) ,
	Region_Id INT NOT NULL CONSTRAINT FK_assump_Region_lk_Region_Region_Id FOREIGN KEY REFERENCES miBuilds.lk_Region(Region_Id),
	SMB_ARPU DECIMAL(20,2)  ,
	ENT_ARPU DECIMAL(20,2)  ,
	SMB_12mo_Pen DECIMAL(5,3) ,
	SMB_36mo_Pen DECIMAL(5,3) ,
	ENT_12mo_Pen DECIMAL(5,3) ,
	ENT_36mo_Pen DECIMAL(5,3) ,
	IsActive INT ,
	AddedOn DATETIME,
	AddedBy VARCHAR(50) ,
	EditedOn DATETIME ,
	EditedBy VARCHAR(100)
)
INSERT INTO miBuilds.assump_Region (
	Region_Id ,
	Name ,
	SMB_ARPU  ,
	ENT_ARPU  ,
	SMB_12mo_Pen ,
	SMB_36mo_Pen ,
	ENT_12mo_Pen ,
	ENT_36mo_Pen ,
	IsActive ,
	AddedOn ,
	AddedBy
)
VALUES (1,'California', 203.00, 1446.00, 0.256, 0.383, 0.100, 0.200, 1, GETDATE(), 'mbray201')
, (2,'Houston', 197.00, 1101.00, 0.240, 0.323, 0.100, 0.200, 1, GETDATE(), 'mbray201')
, (3,'Mountain West', 189.00, 1093.00, 0.302, 0.418, 0.100, 0.200, 1, GETDATE(), 'mbray201')
, (4,'Portland', 189.00, 899.00, 0.316, 0.450, 0.100, 0.200, 1, GETDATE(), 'mbray201')
, (5,'Seattle', 194.00, 1005.00, 0.263, 0.392, 0.100, 0.200, 1, GETDATE(), 'mbray201')
, (6,'Twin Cities', 187.00, 944.00, 0.324, 0.423, 0.100, 0.200, 1, GETDATE(), 'mbray201')
, (7,'Division', 197.00, 1154.00, NULL, NULL, NULL, NULL, 1, GETDATE(), 'mbray201')

/************************************************************
-------- Segment Assumptions --------
*************************************************************/
IF OBJECT_ID('miBuilds.assump_Segment') IS NOT NULL DROP TABLE miBuilds.assump_Segment_Assump
CREATE TABLE miBuilds.assump_Segment (
	Segment_Assump_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_assump_Segment_Segment_Assump_Id PRIMARY KEY,
	Name varchar(100) ,
	Segment_Type_Id INT NOT NULL CONSTRAINT FK_assump_Segment_lk_Segment_Segment_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Segment_Type(Segment_Type_Id),
	Capex DECIMAL(20,2)  ,
	Capex_Data_and_Install DECIMAL(20,2) ,
	Capex_Voice_and_Install DECIMAL(20,2) ,
	Capex_Video_and_Install DECIMAL(20,2) ,
	Maint_Opex DECIMAL(20,2),
	Opex_Load DECIMAL(5,3) ,
	Churn DECIMAL(5,3) ,
	IsActive INT ,
	AddedOn DATETIME,
	AddedBy VARCHAR(50) ,
	EditedOn DATETIME ,
	EditedBy VARCHAR(100)
)
INSERT INTO miBuilds.assump_Segment (
	Segment_Type_Id ,
	Name ,
	Capex ,
	Capex_Data_and_Install ,
	Capex_Voice_and_Install ,
	Capex_Video_and_Install ,
	Maint_Opex ,
	Opex_Load,
	Churn,
	IsActive ,
	AddedOn ,
	AddedBy
)
VALUES (1,'SMB', NULL, 170.00, 175.00, 95.00, NULL, 0.30, 0.005, 1, GETDATE(), 'mbray201')
, (2, 'ENT', 2242.00, NULL, NULL, NULL, 280.00, 0.20, 0.005, 1, GETDATE(), 'mbray201')
, (3, 'MAJ', 2242.00, NULL, NULL, NULL, 280.00, 0.20, 0.005, 1, GETDATE(), 'mbray201')
, (4, 'NAT', 2242.00, NULL, NULL, NULL, 280.00, 0.20, 0.005, 1, GETDATE(), 'mbray201')
, (5, 'GED', 2242.00, NULL, NULL, NULL, 280.00, 0.20, 0.005, 1, GETDATE(), 'mbray201')
, (6, 'FED', 2242.00, NULL, NULL, NULL, 280.00, 0.20, 0.005, 1, GETDATE(), 'mbray201')

/************************************************************
-------- Data Center Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_Data_Center_Type') IS NOT NULL DROP TABLE miBuilds.lk_Data_Center_Type
CREATE TABLE miBuilds.lk_Data_Center_Type (
	Data_Center_Type_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_Data_Center_Type_Data_Center_Type_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100)
)
INSERT INTO miBuilds.lk_Data_Center_Type (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy 
)
VALUES ('Small', 1, GETDATE(), 'mbray201')
, ('Medium', 1, GETDATE(), 'mbray201')
, ('Large', 1, GETDATE(), 'mbray201')

/************************************************************
-------- Data Center Equipment Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_Data_Center_Equip_Type') IS NOT NULL DROP TABLE miBuilds.lk_Data_Center_Equip_Type
CREATE TABLE miBuilds.lk_Data_Center_Equip_Type (
	Data_Center_Equip_Type_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_Data_Center_Equip_Type_Data_Center_Equip_Type_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , -- may need to be varchar depeding on user Id type
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) -- may need to be varchar depeding on user Id type
)
INSERT INTO miBuilds.lk_Data_Center_Equip_Type (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy 
)
VALUES ('Ciena 3930', 1, GETDATE(), 'mbray201')
, ('Cisco 3600', 1, GETDATE(), 'mbray201')
, ('Juniper MX 240', 1, GETDATE(), 'mbray201')
, ('Juniper MX 480',  1, GETDATE(), 'mbray201')
, ('Juniper MX 960', 1, GETDATE(), 'mbray201')

/************************************************************
-------- Data Center Equipment Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.assump_Data_Center_Equip_Type') IS NOT NULL DROP TABLE miBuilds.assump_Data_Center_Equip_Type
CREATE TABLE miBuilds.assump_Data_Center_Equip_Type (
	Data_Center_Equip_Type_Assump_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_assump_Data_Center_Equip_Type_Data_Center_Equip_Type_Assump_Id PRIMARY KEY,
	Name varchar(100) ,
	Data_Center_Equip_Type_Id INT NOT NULL CONSTRAINT FK_assump_Data_Center_Equip_Type_lk_Data_Center_Equip_Type_Data_Center_Equip_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Data_Center_Equip_Type(Data_Center_Equip_Type_Id),
	Capex DECIMAL(20,2),
	Amp_Per_AC DECIMAL(20,2),
	AMPS INT, 
	Opex DECIMAL(20,2),
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , -- may need to be varchar depeding on user Id type
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) -- may need to be varchar depeding on user Id type
)
INSERT INTO miBuilds.assump_Data_Center_Equip_Type (
	Name ,
	Data_Center_Equip_Type_Id,
	Capex ,
	Amp_Per_AC ,
	AMPS ,
	Opex ,
	IsActive ,
	AddedOn ,
	AddedBy 
)
VALUES ('Ciena 3930', 1, 2000.00, 19.00, 5, 95.00, 1, GETDATE(), 'mbray201')
, ('Cisco 3600', 2, 13287.80, 19.00, 40, 760.00, 1, GETDATE(), 'mbray201')
, ('Juniper MX 240', 3, 75694.50, 19.00, 80, 1520.00, 1, GETDATE(), 'mbray201')
, ('Juniper MX 480',  4, 109168.00, 19.00, 80, 1520.00, 1, GETDATE(), 'mbray201')
, ('Juniper MX 960', 5, 112948.00, 19.00, 160, 3040.00, 1, GETDATE(), 'mbray201')



/************************************************************
-------- Data Center Assumptions --------
*************************************************************/
IF OBJECT_ID('miBuilds.assump_Data_Center_Type') IS NOT NULL DROP TABLE miBuilds.assump_Data_Center_Type
CREATE TABLE miBuilds.assump_Data_Center_Type (
	Data_Center_Type_Assump_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_assump_Data_Center_Data_Center_Assump_Id PRIMARY KEY,
	Name varchar(100) ,
	Data_Center_Type_Id INT NOT NULL CONSTRAINT FK_assump_Data_Center_lk_Data_Center_Type_Data_Center_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Data_Center_Type(Data_Center_Type_Id),
	Data_Center_Equip_Type_Id INT NOT NULL CONSTRAINT FK_assump_Data_Center_lk_Data_Center_Equip_Type_Data_Center_Equip_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Data_Center_Equip_Type(Data_Center_Equip_Type_Id),
	Rack DECIMAL(20,2),
	MRR_Per_Circ_Avg DECIMAL(20,2),
	Colo_Fee DECIMAL(20,2),
	Connect_Cost DECIMAL(20,2),
	Opex_Pct DECIMAL(5,3),
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , -- may need to be varchar depeding on user Id type
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) -- may need to be varchar depeding on user Id type
)
INSERT INTO miBuilds.assump_Data_Center_Type (
	Data_Center_Type_Id ,
	Name ,
	Data_Center_Equip_Type_Id ,
	Rack ,
	MRR_Per_Circ_Avg ,
	Colo_Fee ,
	Connect_Cost ,
	Opex_Pct,
	IsActive ,
	AddedOn  ,
	AddedBy
)
VALUES (1, 'Small', 2, 1000.00, 1055.00, 1500.00, 2000.00, 0.12, 1, GETDATE(), 'mbray201')
, (2, 'Medium', 2, 1000.00, 1108.00, 1500.00, 2000.00, 0.12, 1, GETDATE(), 'mbray201')
, (3, 'Large', 4, 1000.00, 1245.00, 1500.00, 2000.00, 0.12, 1, GETDATE(), 'mbray201')

/************************************************************
-------- Data Center Circuit Assumptions --------
*************************************************************/
IF OBJECT_ID('miBuilds.assump_Data_Center_Circuit_EOY') IS NOT NULL DROP TABLE miBuilds.assump_Data_Center_Circuit_EOY
CREATE TABLE miBuilds.assump_Data_Center_Circuit_EOY (
	Data_Center_Circuit_EOY_Assump_Id INT NOT NULL,
	Name varchar(100) ,
	Data_Center_Type_Id INT NOT NULL CONSTRAINT FK_assump_Data_Center_Circuit_EOY_lk_Data_Center_Type_Data_Center_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Data_Center_Type(Data_Center_Type_Id),
	Yr INT,
	Circuit_Ct INT,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , -- may need to be varchar depeding on user Id type
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) -- may need to be varchar depeding on user Id type
)
INSERT INTO miBuilds.assump_Data_Center_Circuit_EOY (
	Data_Center_Circuit_EOY_Assump_Id,
	Data_Center_Type_Id ,
	Name ,
	Yr ,
	Circuit_Ct ,
	IsActive ,
	AddedOn  ,
	AddedBy
)
VALUES (1, 1, 'Small', 1, 1, 1, GETDATE(), 'mbray201')
, (1, 1, 'Small', 2, 2, 1, GETDATE(), 'mbray201')
, (1, 1, 'Small', 3, 3, 1, GETDATE(), 'mbray201')
, (1, 1, 'Small', 4, 4, 1, GETDATE(), 'mbray201')
, (1, 1, 'Small', 5, 4, 1, GETDATE(), 'mbray201')
, (2, 2, 'Medium', 1, 3, 1, GETDATE(), 'mbray201')
, (2, 2, 'Medium', 2, 5, 1, GETDATE(), 'mbray201')
, (2, 2, 'Medium', 3, 7, 1, GETDATE(), 'mbray201')
, (2, 2, 'Medium', 4, 9, 1, GETDATE(), 'mbray201')
, (2, 2, 'Medium', 5, 11, 1, GETDATE(), 'mbray201')
, (3, 3, 'Large', 1, 3, 1, GETDATE(), 'mbray201')
, (3, 3, 'Large', 2, 5, 1, GETDATE(), 'mbray201')
, (3, 3, 'Large', 3, 10, 1, GETDATE(), 'mbray201')
, (3, 3, 'Large', 4, 15, 1, GETDATE(), 'mbray201')
, (3, 3, 'Large', 5, 19, 1, GETDATE(), 'mbray201')


/************************************************************
-------- MDU Region Assumptions --------
*************************************************************/
IF OBJECT_ID('miBuilds.assump_MDU_Build_Region') IS NOT NULL DROP TABLE miBuilds.assump_MDU_Build_Region
CREATE TABLE miBuilds.assump_MDU_Build_Region (
	MDU_Build_Region_Assump_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_assump_MDU_Build_Region_MDU_Build_Region_Assump_Id PRIMARY KEY,
	Name VARCHAR(255),
	Region_Id INT NOT NULL CONSTRAINT FK_assump_MDU_Build_Region_lk_Region_Region_Id FOREIGN KEY REFERENCES miBuilds.lk_Region(Region_Id),
	Video_Penetration DECIMAL(5,3),
	Data_Penetration DECIMAL(5,3),
	Voice_Penetration DECIMAL(5,3),
	Video_ARPU DECIMAL(20,2),
	Data_ARPU DECIMAL(20,2),
	Voice_ARPU DECIMAL(20,2),
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , -- may need to be varchar depeding on user Id type
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) -- may need to be varchar depeding on user Id type
)
INSERT INTO miBuilds.assump_MDU_Build_Region (
	Name,
	Region_Id ,
	Video_Penetration ,
	Data_Penetration ,
	Voice_Penetration ,
	Video_ARPU ,
	Data_ARPU ,
	Voice_ARPU ,
	IsActive ,
	AddedOn ,
	AddedBy
)
VALUES ('California', 1, 0.42, 0.523, 0.197, 85.25, 50.74, 26.04, 1, GETDATE(), 'mbray201')
, ('Houston', 2, 0.314, 0.376, 0.127, 85.98, 48.98, 25.59, 1, GETDATE(), 'mbray201')
, ('Mountain West', 3, 0.387, 0.479, 0.178, 82.52, 49.34, 24.50, 1, GETDATE(), 'mbray201')
, ('Portland', 4, 0.461, 0.557, 0.202, 80.79, 52.18, 25.48,  1, GETDATE(), 'mbray201')
, ('Seattle', 5, 0.501, 0.583, 0.239, 81.42, 52.21, 25.54, 1, GETDATE(), 'mbray201')
, ('Twin Cities', 6, 0.443, 0.459, 0.199, 80.83, 49.65, 23.96,  1, GETDATE(), 'mbray201')

/************************************************************
-------- MDU Assumptions --------
*************************************************************/
IF OBJECT_ID('miBuilds.assump_MDU_Build') IS NOT NULL DROP TABLE miBuilds.assump_MDU_Build
CREATE TABLE miBuilds.assump_MDU_Build (
	MDU_Build_Assump_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_assump_MDU_Build_MDU_Build_Assump_Id PRIMARY KEY,
	Name VARCHAR(255),
	MDU_Build_Type_Id INT NOT NULL CONSTRAINT FK_assump_MDU_Build_lk_MDU_Build_Type_MDU_Build_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_MDU_Build_Type(MDU_Build_Type_Id),
	Current_Service_Type_Id INT NOT NULL CONSTRAINT FK_assump_MDU_Build_lk_Current_Service_Type_Current_Service_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Current_Service_Type(Current_Service_Type_Id),
	MDU_Build_Region_Assump_Id INT NULL CONSTRAINT FK_assump_MDU_Build_assump_MDU_Build_Region_MDU_Build_Region_Assump_Id FOREIGN KEY REFERENCES miBuilds.assump_MDU_Build_Region(MDU_Build_Region_Assump_Id),
	Video_Penetration DECIMAL(5,3),
	Data_Penetration DECIMAL(5,3),
	Voice_Penetration DECIMAL(5,3),
	Video_ARPU DECIMAL(20,2),
	Data_ARPU DECIMAL(20,2),
	Voice_ARPU DECIMAL(20,2),
	Video_Rev_Share DECIMAL(5,3),
	Data_Rev_Share DECIMAL(5,3),
	Voice_Rev_Share DECIMAL(5,3),
	ISP_Per_Unit DECIMAL(20,2),
	Door_Fees DECIMAL(20,2),
	Min_Passings INT,
	Opex_Load DECIMAL(5,3),
	Converter DECIMAL(20,2),
	Modem DECIMAL(20,2),
	eMTA DECIMAL(20,2),
	Penetration_Ramp INT, 
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , -- may need to be varchar depeding on user Id type
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) -- may need to be varchar depeding on user Id type
)
INSERT INTO miBuilds.assump_MDU_Build (
	Name,
	MDU_Build_Type_Id ,
	Current_Service_Type_Id ,
	Video_Penetration ,
	Data_Penetration ,
	Voice_Penetration ,
	Video_ARPU ,
	Data_ARPU ,
	Voice_ARPU ,
	Video_Rev_Share ,
	Data_Rev_Share ,
	Voice_Rev_Share ,
	ISP_Per_Unit ,
	Door_Fees ,
	Min_Passings ,
	Opex_Load ,
	Converter ,
	Modem ,
	eMTA,
	Penetration_Ramp,
	IsActive ,
	AddedOn ,
	AddedBy
)
VALUES ('Greenfield-Coax' ,1 ,1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.45, 99.00, 32.00, 75.25, 6, 1, GETDATE(), 'mbray201')
,('Greenfield-Fiber',1 ,2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.45, 99.00, 32.00, 75.25, 6, 1, GETDATE(), 'mbray201')
,('Greenfield-In Bulk Contract', 1 ,3, 0.0, 0.0, 0.0, 60.00, 30.00, 30.00, 0.0, 0.0, 0.0, 0.00, 0.00, 0, 0.45, 99.00, 32.00, 75.25, 6, 1, GETDATE(), 'mbray201')
,('Greenfield-None', 1 ,4, 0.40, 0.40, 0.15, 60.00, 30.00, 30.00, 0.05, 0.05, 0.05, 275.00, 200.00, 50, 0.45, 99.00, 32.00, 75.25, 6, 1, GETDATE(), 'mbray201')
,('Brownfield-Coax' ,2 ,1, 0.05, 0.05, 0.0, 60.00, 30.00, 30.00, 0.05, 0.05, 0.05, 0.0, 0.0, 250, 0.45, 99.00, 32.00, 75.25, 6, 1, GETDATE(), 'mbray201')
,('Brownfield-Fiber' ,2 ,2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.45, 99.00, 32.00, 75.25, 6, 1, GETDATE(), 'mbray201')
,('Brownfield-None' ,2 ,3, 0.20, 0.20, 0.075, 60.00, 30.00, 30.00, 0.05, 0.05, 0.05, 90.00, 200.00, 50, 0.45, 99.00, 32.00, 75.25, 6, 1, GETDATE(), 'mbray201')
,('SFU-None' ,3 ,4, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, 0.00, 0.00, 275.00, 0.00, 0.00, 0.45, 99.00, 32.00, 75.25, 6, 1, GETDATE(), 'mbray201')

/************************************************************
-------- File Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_File_Type') IS NOT NULL DROP TABLE miBuilds.lk_File_Type
CREATE TABLE miBuilds.lk_File_Type (
	File_Type_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_File_Type_File_Type_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_File_Type (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy 
)
VALUES ('Spectrum Map/Plan', 1, GETDATE(), 'mbray201')
, ('Google Map', 1, GETDATE(), 'mbray201')
, ('Developer Plan/Map', 1, GETDATE(), 'mbray201')
, ('Construction Plan/Map', 1, GETDATE(), 'mbray201')
, ('Design Plan', 1, GETDATE(), 'mbray201')
, ('Other', 1, GETDATE(), 'mbray201')

/************************************************************
-------- Upload Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_Upload_Type') IS NOT NULL DROP TABLE miBuilds.lk_Upload_Type
CREATE TABLE miBuilds.lk_Upload_Type (
	Upload_Type_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_Upload_Type_Upload_Type_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_Upload_Type (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy 
)
VALUES ('CSV', 1, GETDATE(), 'mbray201')

/************************************************************
-------- User Group Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_User_Group') IS NOT NULL DROP TABLE miBuilds.lk_User_Group
CREATE TABLE miBuilds.lk_User_Group (
	User_Group_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_User_Group_User_Group_Id PRIMARY KEY
	,Name varchar(100) 
	,IsActive INT 
	,AddedOn DATETIME 
	,AddedBy VARCHAR(100)
	,EditedOn DATETIME
	,EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_User_Group (
	Name
	,IsActive 
	,AddedOn 
	,AddedBy 
)
VALUES ('Level 2', 1, GETDATE(), 'mbray201')
, ('Level 3', 1, GETDATE(), 'mbray201')
, ('Level 4', 1, GETDATE(), 'mbray201')
, ('Level 5', 1, GETDATE(), 'mbray201')
, ('Level 6', 1, GETDATE(), 'mbray201')
, ('Level 1', 1, GETDATE(), 'mbray201')

/************************************************************
-------- Note Type --------
*************************************************************/
IF OBJECT_ID('miBuilds.lk_Note_Type') IS NOT NULL DROP TABLE miBuilds.lk_Note_Type
CREATE TABLE miBuilds.lk_Note_Type (
	Note_Type_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_lk_Note_Type_Note_Type_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_Note_Type (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy 
)
VALUES ('General', 1, GETDATE(), 'mbray201')
, ('Important', 1, GETDATE(), 'mbray201')
, ('Review', 1, GETDATE(), 'mbray201')


IF OBJECT_ID('miBuilds.xref_Spectrum_Region_Id') IS NOT NULL DROP TABLE miBuilds.xref_Spectrum_Region_Id
CREATE TABLE miBuilds.xref_Spectrum_Region_Id (
	Region_Id INT
	,miBuilds_Region_Name VARCHAR(100)
	,Spectrum_Region_Code VARCHAR(2)
)
INSERT INTO miBuilds.xref_Spectrum_Region_Id (
	Region_Id
	,miBuilds_Region_Name
	,Spectrum_Region_Code
)
VALUES (1, 'California', 'CA')
, (2, 'Houston', 'TX')
, (3, 'Mountain West', 'CO')
, (4, 'Portland', 'OR')
, (5, 'Seattle', 'WA')
, (6, 'Twin Cities', 'MN')


create table miBuilds.lk_BDR (
	BDR_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_BDR_BDR_Id PRIMARY KEY
	,Region_Id INT
	,BDR_Pernr varchar(50)
	,BDR_NTLogin varchar(50)
	,BDR_FirstName varchar(150)
	,BDR_LastName varchar(150)
	,Manager_Pernr varchar(50)
	,Manager_NTLogin varchar(50)
	,Manager_FirstName varchar(150)
	,Manager_LastName varchar(150)
	,IsActive INT
	,AddedOn DATETIME
	,AddedBy VARCHAR(100) 
	,EditedOn DATETIME
	,EditedBy VARCHAR(100) 
	)
INSERT INTO miBuilds.lk_BDR (
	Region_Id
	,BDR_NTLogin
	,Manager_NTLogin
	,IsActive
	,AddedOn
	,AddedBy
	)
VALUES (1,'mcasti202','tgirdn001',1,GETDATE(),'mbray201')
,(5,'MHerri000','MMorte001',1,GETDATE(),'mbray201')
,(5,'TKamla001','MMorte002',1,GETDATE(),'mbray201')
,(5,'jfried203','kmccal821',1,GETDATE(),'mbray201')
,(5,'TGeibe001','kmccal821',1,GETDATE(),'mbray201')
,(6,'bburke202','tsalmi200',1,GETDATE(),'mbray201')


alter table miBuilds.app_Probuild
add BDR_Id INT CONSTRAINT FK_app_Probuild_lk_BDR_BDR_Id FOREIGN KEY REFERENCES miBuilds.lk_BDR(BDR_Id)


INSERT INTO miBuilds.lk_BDR (
	Region_Id
	,BDR_NTLogin
	,Manager_NTLogin
	,IsActive
	,AddedOn
	,AddedBy
	)
VALUES (5, 'MMorte001', 'MMorte001',1,GETDATE(),'mbray201')
,(5, 'kmccal821', 'kmccal821',1,GETDATE(),'mbray201')
,(3, 'eparto001', 'gamell001',1,GETDATE(),'mbray201')
,(3, 'shail200', 'gamell001',1,GETDATE(),'mbray201')
,(3, 'jnolan001', 'gamell001',1,GETDATE(),'mbray201')
,(3, 'gamell001', 'gamell001',1,GETDATE(),'mbray201')
,(3, 'pburke200', 'keder200',1,GETDATE(),'mbray201')
,(3, 'keder200', 'keder200',1,GETDATE(),'mbray201')
,(3, 'mcottl000', 'ssperr0490',1,GETDATE(),'mbray201')
,(3, 'jpeixo200', 'ssperr0490',1,GETDATE(),'mbray201')
,(3, 'ssperr0490', 'ssperr0490',1,GETDATE(),'mbray201')

INSERT INTO miBuilds.lk_BDR (
	Region_Id
	,BDR_NTLogin
	--,Manager_NTLogin
	,IsActive
	,AddedOn
	,AddedBy
	)
VALUES (2, 'slovin201', 1,GETDATE(),'mbray201')
,(2, 'dtandy200', 1,GETDATE(),'mbray201')
,(2, 'cblack008', 1,GETDATE(),'mbray201')
,(2, 'rbrown272', 1,GETDATE(),'mbray201')
,(2, 'sblank200', 1,GETDATE(),'mbray201')
,(2, 'jfowle203', 1,GETDATE(),'mbray201')


IF OBJECT_ID('miBuilds.lk_ROE_Status') IS NOT NULL DROP TABLE miBuilds.lk_ROE_Status
CREATE TABLE miBuilds.lk_ROE_Status (
	ROE_Status_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_ROE_Status_ROE_Status_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_ROE_Status (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy
)
VALUES ('Acquired', 1, GETDATE(), 'mbray201')
, ('Active', 1, GETDATE(), 'mbray201')
, ('Needed', 1, GETDATE(), 'mbray201')

ALTER TABLE miBuilds.app_Building
ADD ROE_Status INT CONSTRAINT FK_app_Building_lk_ROE_Status_ROE_Status_Id FOREIGN KEY REFERENCES miBuilds.lk_ROE_Status(ROE_Status_Id)


IF OBJECT_ID('miBuilds.lk_Disposition_Type') IS NOT NULL DROP TABLE miBuilds.lk_Disposition_Type
CREATE TABLE miBuilds.lk_Disposition_Type (
	Disposition_Type_Id INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_Disposition_Type_Disposition_Type_Id PRIMARY KEY,
	Name varchar(100) ,
	IsActive INT ,
	AddedOn DATETIME ,
	AddedBy VARCHAR(100) , 
	EditedOn DATETIME ,
	EditedBy VARCHAR(100) 
)
INSERT INTO miBuilds.lk_Disposition_Type (
	Name ,
	IsActive ,
	AddedOn ,
	AddedBy
)
VALUES ('Payback Not Met', 1, GETDATE(), 'mbray201')
--, ('Active', 1, GETDATE(), 'mbray201')
--, ('Needed', 1, GETDATE(), 'mbray201')

ALTER TABLE miBuilds.app_Probuild
ADD Disposition_Type_Id INT CONSTRAINT FK_app_Probuild_lk_Disposition_Type_Disposition_Type_Id FOREIGN KEY REFERENCES miBuilds.lk_Disposition_Type(Disposition_Type_Id)