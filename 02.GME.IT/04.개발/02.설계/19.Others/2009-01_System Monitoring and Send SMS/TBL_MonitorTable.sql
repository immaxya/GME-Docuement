/*********************************************************************************************
 * 설    명 : Table list
 * 작 성 자 : Max
 * 작 성 일 : 2020.09.22
 * 유    형 : TABLE CREATE
 * 내    역 :
 * 수 정 자 :
 * 수 정 일 :
 *********************************************************************************************/

CREATE TABLE dbo.MonitorTable
(
	rowId		 BIGINT 		IDENTITY(1,1) NOT NULL
,	IsCheck		 CHAR(1) 		NOT NULL
, 	TableCode	 VARCHAR(20) 	NOT NULL
, 	DatabaseName VARCHAR(20) 	NOT NULL
,	TableName 	 VARCHAR(100) 	NOT NULL
,  	LimitRows 	 INT 			NOT NULL
, 	CreatedDate  DATETIME 		NOT NULL
, 	CreatedBy 	 VARCHAR(20) 	NOT NULL
,	ModifiedDate DATETIME 		NULL
,	ModifiedBy 	 VARCHAR(20) 	NULL
)

ALTER TABLE dbo.MonitorTable ADD CONSTRAINT PK_MonitorTable
PRIMARY KEY (
	rowId
);

INSERT INTO MonitorTable 
(IsCheck, TableCode, DatabaseName, TableName, LimitRows, CreatedDate, CreatedBy)
SELECT 'Y', 'TBL-101', N'Application_Log', 'dbo.ApplicationLogger', '9500000',  GETDATE(), 'SYSTEM' 
UNION ALL
SELECT 'Y', 'TBL-102', N'Application_Log', 'dbo.tblThirdParty_ApiDetailLog', '9500000',  GETDATE(), 'SYSTEM' 
UNION ALL
SELECT 'Y', 'TBL-103', N'Application_Log', 'dbo.vwTpApilogs', '9500000',  GETDATE(), 'SYSTEM' 
UNION ALL
SELECT 'Y', 'TBL-104', N'FastMoneyPro_Remit', 'dbo.exRateCalcHistory', '9500000',  GETDATE(), 'SYSTEM' 
UNION ALL
SELECT 'Y', 'TBL-105', N'FastMoneyPro_Remit', 'dbo.LoginLogs', '9500000',  GETDATE(), 'SYSTEM' 
UNION ALL
SELECT 'Y', 'TBL-106', N'FastMoneyPro_Remit', 'dbo.Logs', '9500000',  GETDATE(), 'SYSTEM' 