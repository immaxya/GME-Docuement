/*********************************************************************************************
 * 설    명 : Partner list
 * 작 성 자 : Max
 * 작 성 일 : 2020.09.22
 * 유    형 : TABLE CREATE
 * 내    역 :
 * 수 정 자 :
 * 수 정 일 :
 *********************************************************************************************/

CREATE TABLE dbo.MonitorPartner
(
	rowId		 BIGINT 		IDENTITY(1,1) NOT NULL
,	IsCheck		 CHAR(1) 		NOT NULL
, 	agentId		 INT		 	NOT NULL
, 	CheckDay	 SMALLINT 		NOT NULL
,	CheckNight 	 SMALLINT 		NOT NULL
, 	CreatedDate  DATETIME 		NOT NULL
, 	CreatedBy 	 VARCHAR(20) 	NOT NULL
,	ModifiedDate DATETIME 		NULL
,	ModifiedBy 	 VARCHAR(20) 	NULL
)

ALTER TABLE dbo.MonitorPartner ADD CONSTRAINT PK_MonitorPartner
PRIMARY KEY (
	rowId
);

