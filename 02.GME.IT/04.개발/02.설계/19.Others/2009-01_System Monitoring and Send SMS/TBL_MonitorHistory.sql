/*********************************************************************************************
 * 설    명 : History list
 * 작 성 자 : Max
 * 작 성 일 : 2020.09.22
 * 유    형 : TABLE CREATE
 * 내    역 :
 * 수 정 자 :
 * 수 정 일 :
 *********************************************************************************************/

CREATE TABLE dbo.MonitorHistory
(
	rowId		 BIGINT 		IDENTITY(1,1) NOT NULL
,	MonitorGrp	 TINYINT		NOT NULL
, 	MonitorId	 BIGINT		 	NOT NULL
, 	MonitorCode	 VARCHAR(20)	NOT NULL
,	CheckValue	 INT 			NOT NULL
, 	SendMsg		 NVARCHAR(200)  NULL
,   SendedDate   DATETIME 		NULL
)

ALTER TABLE dbo.MonitorHistory ADD CONSTRAINT PK_MonitorHistory
PRIMARY KEY (
	rowId
);

