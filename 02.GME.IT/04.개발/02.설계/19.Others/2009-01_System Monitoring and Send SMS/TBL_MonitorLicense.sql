/*********************************************************************************************
 * 설    명 : License list
 * 작 성 자 : Max
 * 작 성 일 : 2020.09.22
 * 유    형 : TABLE CREATE
 * 내    역 :
 * 수 정 자 :
 * 수 정 일 :
 *********************************************************************************************/

CREATE TABLE dbo.MonitorLicense
(
	rowId		BIGINT 			IDENTITY(1,1) NOT NULL
,	IsCheck		CHAR(1) 		NOT NULL
, 	ProductCode VARCHAR(20) 	NOT NULL
, 	ProductName NVARCHAR(100) 	NOT NULL
, 	ExpiredDate DATETIME 		NOT NULL
, 	CreatedDate DATETIME 		NOT NULL
, 	CreatedBy 	VARCHAR(20) 	NOT NULL
,	ModifiedDate DATETIME 		NULL
,	ModifiedBy 	VARCHAR(20) 	NULL
)

ALTER TABLE dbo.MonitorLicense ADD CONSTRAINT PK_MonitorLicense
PRIMARY KEY (
	rowId
);

INSERT INTO MonitorLicense 
(IsCheck, ProductCode, ProductName, ExpiredDate, CreatedDate, CreatedBy)
SELECT 'Y', 'PRO-101', N'SSL-online.gmeremit.com', '2021-01-06', GETDATE(), 'SYSTEM' 
UNION ALL
SELECT 'Y', 'PRO-102', N'SSL-mobileapi.gmeremit.com', '2021-01-06', GETDATE(), 'SYSTEM' 
UNION ALL
SELECT 'Y', 'PRO-103', N'SSL-kbank.gmeremit.com', '2022-10-25', GETDATE(), 'SYSTEM' 
UNION ALL
SELECT 'Y', 'PRO-104', N'SSL-gmeremitkjapi.gmeremit.com', '2021-10-05', GETDATE(), 'SYSTEM' 
UNION ALL
SELECT 'Y', 'PRO-105', N'SSL-payportal.gmeremit.com', '2021-02-14', GETDATE(), 'SYSTEM' 
UNION ALL
SELECT 'Y', 'PRO-106', N'SSL-inbound.gmeremit.com', '2021-11-22', GETDATE(), 'SYSTEM' 
UNION ALL
SELECT 'Y', 'PRO-107', N'SSL-payapi.gmeremit.com', '2021-05-07', GETDATE(), 'SYSTEM' 