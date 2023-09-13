/*********************************************************************************************
 * 설    명 : Resource list
 * 작 성 자 : 
 * 작 성 일 :
 * 유    형 : TABLE CREATE
 * 내    역 :
 * 수 정 자 :
 * 수 정 일 :
 *********************************************************************************************/

CREATE TABLE dbo.MonitorResource
(
	rowId		BIGINT 			IDENTITY(1,1) NOT NULL
,	IsCheck		CHAR(1) 		NOT NULL
, 	ResourceCode VARCHAR(20) 	NOT NULL
, 	ResourceName NVARCHAR(100) 	NULL
, 	ResourceType TINYINT 		NOT NULL
, 	VMName		VARCHAR(20) 	NOT NULL
, 	ChkObject 	VARCHAR(100) 	NOT NULL
, 	CreatedDate DATETIME 		NOT NULL
, 	CreatedBy 	VARCHAR(20) 	NOT NULL
,	ModifiedDate DATETIME 		NULL
,	ModifiedBy 	VARCHAR(20) 	NULL
)

ALTER TABLE dbo.MonitorResource ADD CONSTRAINT PK_MonitorResource
PRIMARY KEY (
	rowId
);

INSERT INTO MonitorResource 
(IsCheck, ResourceCode, ResourceName, ResourceType, VMName, ChkObject, CreatedDate, CreatedBy)
SELECT 'Y', 'RSC-101', N'UAT-CPU', '1', 'UAT-WEB-02', 'CPU', GETDATE(), 'SYSTEM' 
UNION ALL
SELECT 'Y', 'RSC-201', N'UAT-DISK-C', '2', 'UAT-WEB-02', 'C', GETDATE(), 'SYSTEM'
UNION ALL
SELECT 'Y', 'RSC-202', N'UAT-DISK_D', '2', 'UAT-WEB-02', 'D', GETDATE(), 'SYSTEM'