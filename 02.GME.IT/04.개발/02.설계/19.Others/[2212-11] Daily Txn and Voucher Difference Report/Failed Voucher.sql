-- Daily Txn and Voucher Difference Report
DECLARE 
	@START DATETIME = DATEADD(DAY, -1, CONVERT(DATE, GETDATE())),
	@ENDED DATETIME = CONVERT(DATE, GETDATE())
------------------------------------------------------------
-- Galaxia Coupon purchase Success
SELECT OrderId
INTO #temp1
FROM FastMoneyPro_Remit.dbo.TBL_COUPON_ISSUE(NOLOCK)
WHERE ModifyDate BETWEEN @START AND @ENDED
	AND ResCode = '0000';

IF NOT EXISTS(SELECT 'X' FROM #temp1)
BEGIN
	SELECT @START AS [Galaxia Coupon purchase Success TXN],
		0 AS [Success CNT], 0 AS [Success AMT]
	SELECT @START AS [Galaxia Coupon purchase Success VOU],
		0 AS [Success CNT], 0 AS [Success AMT]
END
ELSE
BEGIN
	SELECT @START AS [Galaxia Coupon purchase Success TXN],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(Res_FaceValue), 0) AS [Success AMT]
	FROM FastMoneyPro_Remit.dbo.TBL_COUPON_ISSUE(NOLOCK)
	WHERE OrderId IN (SELECT OrderId FROM #temp1) 

	SELECT @START AS [Galaxia Coupon purchase Success VOU],
		COUNT(ref_num) AS [Success CNT],
		ISNULL(SUM(tran_amt), 0) AS [Success AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE tran_date = @START
		AND part_tran_type = 'CR'
		AND field1 IN (SELECT OrderId FROM #temp1)
		AND field2 = 'Galaxia Moneytree for Giftcon'
END
IF OBJECT_ID(N'tempdb..#temp1') IS NOT NULL
BEGIN
	DROP TABLE #temp1
END
------------------------------------------------------------
-- Galaxia Coupon purchase Cancel
SELECT a.OrderNumber, b.OrderId
INTO #temp2
FROM FastMoneyPro_Remit.dbo.TBL_COUPON_CANCEL(NOLOCK) a
INNER JOIN FastMoneyPro_Remit.dbo.TBL_COUPON_ISSUE(NOLOCK) b
	ON a.TransactionIdOrOrderNumber = b.OrderNumber
WHERE a.ModifyDate BETWEEN @START AND @ENDED
	AND a.ResCode = '0000';

IF NOT EXISTS(SELECT 'X' FROM #temp2)
BEGIN
	SELECT @START AS [Galaxia Coupon purchase Cancel TXN],
		0 AS [Cancel CNT], 0 AS [Cancel AMT]
	SELECT @START AS [Galaxia Coupon purchase Cancel VOU],
		0 AS [Cancel CNT], 0 AS [Cancel AMT]
END
ELSE
BEGIN
	SELECT @START AS [Galaxia Coupon purchase Cancel TXN],
		COUNT(*) AS [Cancel CNT],
		ISNULL(SUM(FaceValue), 0) AS [Cancel AMT]
	FROM FastMoneyPro_Remit.dbo.TBL_COUPON_CANCEL (NOLOCK)
	WHERE OrderNumber IN (SELECT OrderNumber FROM #temp2) 

	SELECT @START AS [Galaxia Coupon purchase Cancel VOU],
		COUNT(ref_num) AS [Cancel CNT],
		ISNULL(SUM(tran_amt), 0) AS [Cancel AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE tran_date = @START
		AND part_tran_type = 'DR'
		AND field1 IN (SELECT OrderId FROM #temp2)
		AND field2 = 'Galaxia Moneytree for Giftcon'
END
IF OBJECT_ID(N'tempdb..#temp2') IS NOT NULL
BEGIN
	DROP TABLE #temp2
END
------------------------------------------------------------
-- Reward point earned Success
-- 리워드 포인트 충전 시, 개별 전표 생성 안 함.
-- 회계팀에서 집계 후 총괄 생성.
SELECT @START AS [Reward point earned Success TXN],
	COUNT(*) AS [Success CNT],
	ISNULL(SUM(tranPoint), 0) AS [Success AMT]
FROM FastMoneyPro_Remit.dbo.RewardPointHistory
WHERE createdDate BETWEEN @START AND @ENDED
	AND trantype LIKE 'Reward %'
------------------------------------------------------------
-- Reward point earned Cancel
SELECT @START AS [Reward point earned Cancel TXN],
	COUNT(*) AS [Cancel CNT],
	ISNULL(SUM(tranPoint), 0) AS [Cancel AMT]
FROM FastMoneyPro_Remit.dbo.RewardPointHistory
WHERE createdDate BETWEEN @START AND @ENDED
	AND trantype LIKE 'Cancel Per %'
------------------------------------------------------------
-- Coupon redeemed Success
SELECT controlNo
INTO #temp3
FROM FastMoneyPro_Remit.dbo.TBL_GMEPAY_INVENTORY(NOLOCK)
WHERE createdDate BETWEEN @START AND @ENDED
	AND productCode LIKE 'CPN-%'
	AND productStatus IN ('USED', 'RECEIVED');

IF NOT EXISTS(SELECT 'X' FROM #temp3)
BEGIN
	SELECT @START AS [Coupon redeemed Success TXN],
		0 AS [Success CNT], 0 AS [Success AMT]
	SELECT @START AS [Coupon redeemed Success VOU],
		0 AS [Success CNT], 0 AS [Success AMT]
END
ELSE
BEGIN
	SELECT @START AS [Coupon redeemed Success TXN],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(faceValue), 0) AS [Success AMT]
	FROM FastMoneyPro_Remit.dbo.TBL_GMEPAY_INVENTORY(NOLOCK)
	WHERE controlNo IN (SELECT controlNo FROM #temp3)

	SELECT @START AS [Coupon redeemed Success VOU],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(tran_amt), 0) AS [Success AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE tran_date = @START
		AND field1 IN (SELECT controlNo FROM #temp3)
		AND acc_num = '41080125' -- Coupon Liability
		AND part_tran_type = 'CR'
END
IF OBJECT_ID(N'tempdb..#temp3') IS NOT NULL
BEGIN
	DROP TABLE #temp3
END
------------------------------------------------------------
-- Coupon redeemed Cancel
SELECT controlNo
INTO #temp4
FROM FastMoneyPro_Remit.dbo.TBL_GMEPAY_INVENTORY(NOLOCK)
WHERE createdDate BETWEEN @START AND @ENDED
	AND productCode LIKE 'CPN-%'
	AND productStatus = 'CANCELED';

IF NOT EXISTS(SELECT 'X' FROM #temp4)
BEGIN
	SELECT @START AS [Coupon redeemed Cancel TXN],
		0 AS [Cancel CNT], 0 AS [Cancel AMT]
	SELECT @START AS [Coupon redeemed Cancel VOU],
		0 AS [Cancel CNT], 0 AS [Cancel AMT]
END
ELSE
BEGIN
	SELECT @START AS [Coupon redeemed Cancel TXN],
		COUNT(*) AS [Cancel CNT],
		ISNULL(SUM(faceValue), 0) AS [Cancel AMT]
	FROM FastMoneyPro_Remit.dbo.TBL_GMEPAY_INVENTORY(NOLOCK)
	WHERE controlNo IN (SELECT controlNo FROM #temp4)

	SELECT @START AS [Coupon redeemed Cancel VOU],
		COUNT(*) AS [Cancel CNT],
		ISNULL(SUM(tran_amt), 0) AS [Cancel AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE field1 IN (SELECT controlNo FROM #temp4)
		AND acc_num = '41080125' -- Coupon Liability
		AND part_tran_type = 'DR'
END
IF OBJECT_ID(N'tempdb..#temp4') IS NOT NULL
BEGIN
	DROP TABLE #temp4
END
------------------------------------------------------------
-- Local Topup Success
SELECT rowId, customerId
INTO #temp5
FROM FastMoneyPro_Remit.dbo.powercallHistory(NOLOCK)
WHERE requestTime BETWEEN @START AND @ENDED
	AND errorCode = '0';

IF NOT EXISTS(SELECT 'X' FROM #temp5)
BEGIN
	SELECT @START AS [Local Topup Success TXN],
		0 AS [Success CNT], 0 AS [Success AMT]
	SELECT @START AS [Local Topup Success VOU],
		0 AS [Success CNT], 0 AS [Success AMT]
END
ELSE
BEGIN
	SELECT @START AS [Local Topup Success TXN],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(productPrice), 0) AS [Success AMT]
	FROM FastMoneyPro_Remit.dbo.powercallHistory(NOLOCK)
	WHERE rowId IN (SELECT rowId FROM #temp5)

	SELECT @START AS [Local Topup Success VOU],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(a.tran_amt), 0) AS [Success AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK) a
	INNER JOIN FastMoneyPro_Remit.dbo.customerMaster(NOLOCK) b
		ON a.acc_num = b.walletAccountNo
	WHERE a.tran_date = @START
		AND a.field2 IN ('TopUp', 'KTSimCard')
		AND b.customerId IN (SELECT customerId FROM #temp5)
END
IF OBJECT_ID(N'tempdb..#temp5') IS NOT NULL
BEGIN
	DROP TABLE #temp5
END
------------------------------------------------------------
-- Local Topup Reverse
SELECT rowId, customerId
INTO #temp6
FROM FastMoneyPro_Remit.dbo.powercallHistory(NOLOCK)
WHERE requestTime BETWEEN @START AND @ENDED
	AND errorCode <> '0';

IF NOT EXISTS(SELECT 'X' FROM #temp6)
BEGIN
	SELECT @START AS [Local Topup Reverse TXN],
		0 AS [Reverse CNT], 0 AS [Reverse AMT]
END
ELSE
BEGIN
	SELECT @START AS [Local Topup Reverse TXN],
		COUNT(*) AS [Reverse CNT],
		ISNULL(SUM(productPrice), 0) AS [Reverse AMT]
	FROM FastMoneyPro_Remit.dbo.powercallHistory(NOLOCK)
	WHERE rowId IN (SELECT rowId FROM #temp6)
END
	-- 파워콜은 취소전표 없음
	-- Wallet: 실패의 경우에 차감하지 않음.
	-- AutoDebit: 충전 요청 전 월렛으로 출금이체 후 대기.
IF OBJECT_ID(N'tempdb..#temp6') IS NOT NULL
BEGIN
	DROP TABLE #temp6
END
------------------------------------------------------------
-- International Mobile Topup Success
SELECT processId,
	CONVERT(VARCHAR(30), processId) AS processId1 
INTO #temp7
FROM FastMoneyPro_Remit.dbo.TopUpManager(NOLOCK)
WHERE processStatus = 'SUCCESS'
AND modifiedDate BETWEEN @START AND @ENDED;

IF NOT EXISTS(SELECT 'X' FROM #temp7)
BEGIN
	SELECT @START AS [International Mobile Topup Success TXN],
		0 AS [Success CNT], 0 AS [Success AMT]
	SELECT @START AS [International Mobile Topup Success VOU],
		0 AS [Success CNT], 0 AS [Success AMT]
END
ELSE
BEGIN
	SELECT @START AS [International Mobile Topup Success TXN],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(productPrice + serviceFee), 0) AS [Success AMT]
	FROM FastMoneyPro_Remit.dbo.TopUpDetail(NOLOCK)
	WHERE processId IN (SELECT processId FROM #temp7)

	SELECT @START AS [International Mobile Topup Success VOU],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(tran_amt), 0) AS [Success AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE tran_date = @START
		AND field1 IN (SELECT processId1 FROM #temp7)
		AND gl_sub_head_code = '79' AND part_tran_type = 'DR'
END
IF OBJECT_ID(N'tempdb..#temp7') IS NOT NULL
BEGIN
	DROP TABLE #temp7
END
------------------------------------------------------------
-- International Mobile Topup Reverse
SELECT processId,
	CONVERT(VARCHAR(30), processId) AS processId1 
INTO #temp8
FROM FastMoneyPro_Remit.dbo.TopUpManager(NOLOCK)
WHERE processStatus IN ('FAILED', 'REVERSED')
AND modifiedDate BETWEEN @START AND @ENDED;

IF NOT EXISTS(SELECT 'X' FROM #temp8)
BEGIN
	SELECT @START AS [International Mobile Topup Reverse TXN],
		0 AS [Reverse CNT], 0 AS [Reverse AMT]
	SELECT @START AS [International Mobile Topup Reverse VOU],
		0 AS [Reverse CNT], 0 AS [Reverse AMT]
END
ELSE
BEGIN
	SELECT @START AS [International Mobile Topup Reverse TXN],
		COUNT(*) AS [Reverse CNT],
		ISNULL(SUM(productPrice + serviceFee), 0) AS [Reverse AMT]
	FROM FastMoneyPro_Remit.dbo.TopUpDetail(NOLOCK)
	WHERE processId IN (SELECT processId FROM #temp8)

	SELECT @START AS [International Mobile Topup Reverse VOU],
		COUNT(*) AS [Reverse CNT],
		ISNULL(SUM(tran_amt), 0) AS [Reverse AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE tran_date = @START
	AND field1 IN (SELECT processId1 FROM #temp8)
	AND gl_sub_head_code = '79' AND part_tran_type = 'CR'
END
IF OBJECT_ID(N'tempdb..#temp8') IS NOT NULL
BEGIN
	DROP TABLE #temp8
END
------------------------------------------------------------
-- Lotte ATM Withdraw Success
SELECT rowId, virtualAccountNo, billno
INTO #temp9
FROM FastMoneyPro_Remit.dbo.KSWithdrawHistory(NOLOCK)
WHERE isProcessing = 'S' AND billno IS NOT NULL
AND applyDate BETWEEN @START AND @ENDED;

IF NOT EXISTS(SELECT 'X' FROM #temp9)
BEGIN
	SELECT @START AS [Lotte ATM Withdraw Success TXN],
		0 AS [Success CNT], 0 AS [Success AMT]
	SELECT @START AS [Lotte ATM Withdraw Success VOU],
		0 AS [Success CNT], 0 AS [Success AMT]
END
ELSE
BEGIN
	SELECT @START AS [Lotte ATM Withdraw Success TXN],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(withdrawAmount), 0) AS [Success AMT]
	FROM FastMoneyPro_Remit.dbo.KSWithdrawHistory(NOLOCK)
	WHERE rowId IN (SELECT rowId FROM #temp9)

	SELECT @START AS [Lotte ATM Withdraw Success VOU],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(tran_amt), 0) AS [Success AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE acc_num = '162177499' AND	tran_date = @START
		AND field1 IN (SELECT virtualAccountNo FROM #temp9)
		AND billno IN (SELECT billno FROM #temp9)
END
IF OBJECT_ID(N'tempdb..#temp9') IS NOT NULL
BEGIN
	DROP TABLE #temp9
END
------------------------------------------------------------
-- Lotte ATM Withdraw Reverse
SELECT rowId, virtualAccountNo, canceledNo
INTO #temp10
FROM FastMoneyPro_Remit.dbo.KSWithdrawHistory(NOLOCK)
WHERE isProcessing <> 'S' AND billno IS NOT NULL
AND applyDate BETWEEN @START AND @ENDED;

IF NOT EXISTS(SELECT 'X' FROM #temp10)
BEGIN
	SELECT @START AS [Lotte ATM Withdraw Reverse TXN],
		0 AS [Reverse CNT], 0 AS [Reverse AMT]
	SELECT @START AS [Lotte ATM Withdraw Reverse VOU],
		0 AS [Reverse CNT], 0 AS [Reverse AMT]
END
ELSE
BEGIN
	SELECT @START AS [Lotte ATM Withdraw Reverse TXN],
		COUNT(*) AS [Reverse CNT],
		ISNULL(SUM(withdrawAmount), 0) AS [Reverse AMT]
	FROM FastMoneyPro_Remit.dbo.KSWithdrawHistory(NOLOCK)
	WHERE rowId IN (SELECT rowId FROM #temp10)

	SELECT @START AS [Lotte ATM Withdraw Reverse VOU],
		COUNT(*) AS [Reverse CNT],
		ISNULL(SUM(tran_amt), 0) AS [Reverse AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE acc_num = '162177499' AND	tran_date = @START
		AND field1 IN (SELECT virtualAccountNo FROM #temp10)
		AND billno IN (SELECT canceledNo FROM #temp10)
END
IF OBJECT_ID(N'tempdb..#temp10') IS NOT NULL
BEGIN
	DROP TABLE #temp10
END
------------------------------------------------------------
-- Coocon ATM Withdraw Success
SELECT b.rowId, CONVERT(VARCHAR(20), b.rowId) AS rowId1
INTO #temp11
FROM FastMoneyPro_Remit.dbo.KSWithdrawHistory(NOLOCK) a
INNER JOIN FastMoneyPro_Remit.dbo.CooconHistory(NOLOCK) b
	ON a.rowId = b.withdrawId
WHERE a.isProcessing = 'S' AND a.billno IS NULL
AND a.applyDate BETWEEN @START AND @ENDED
OPTION (USE HINT('FORCE_LEGACY_CARDINALITY_ESTIMATION'));

IF NOT EXISTS(SELECT 'X' FROM #temp11)
BEGIN
	SELECT @START AS [Coocon ATM Withdraw Success TXN],
		0 AS [Success CNT], 0 AS [Success AMT]
	SELECT @START AS [Coocon ATM Withdraw Success VOU],
		0 AS [Success CNT], 0 AS [Success AMT]
END
ELSE
BEGIN
	SELECT @START AS [Coocon ATM Withdraw Success TXN],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(withdrawAmount), 0) AS [Success AMT]
	FROM FastMoneyPro_Remit.dbo.CooconHistory(NOLOCK)
	WHERE rowId IN (SELECT rowId FROM #temp11)

	SELECT @START AS [Coocon ATM Withdraw Success VOU],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(tran_amt), 0) AS [Success AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE acc_num = '182769895' AND	tran_date = @START
		AND field1 IN (SELECT rowId1 FROM #temp11)
		AND field2 = 'Coocon-ATM-Withdraw'
END
IF OBJECT_ID(N'tempdb..#temp11') IS NOT NULL
BEGIN
	DROP TABLE #temp11
END
------------------------------------------------------------
-- Coocon ATM Withdraw Reverse
SELECT b.rowId, CONVERT(VARCHAR(20), b.rowId) AS rowId1
INTO #temp12
FROM FastMoneyPro_Remit.dbo.KSWithdrawHistory(NOLOCK) a
INNER JOIN FastMoneyPro_Remit.dbo.CooconHistory(NOLOCK) b
	ON a.rowId = b.withdrawId
WHERE a.isProcessing <> 'S'
AND a.billno IS NULL AND a.canceledNo IS NOT NULL
AND a.applyDate BETWEEN @START AND @ENDED
OPTION (USE HINT('FORCE_LEGACY_CARDINALITY_ESTIMATION'));

IF NOT EXISTS(SELECT 'X' FROM #temp12)
BEGIN
	SELECT @START AS [Coocon ATM Withdraw Reverse TXN],
		0 AS [Reverse CNT], 0 AS [Reverse AMT]
	SELECT @START AS [Coocon ATM Withdraw Reverse VOU],
		0 AS [Reverse CNT], 0 AS [Reverse AMT]
END
ELSE
BEGIN
	SELECT @START AS [Coocon ATM Withdraw Reverse TXN],
		COUNT(*) AS [Reverse CNT],
		ISNULL(SUM(withdrawAmount), 0) AS [Reverse AMT]
	FROM FastMoneyPro_Remit.dbo.CooconHistory(NOLOCK)
	WHERE rowId IN (SELECT rowId FROM #temp12)

	SELECT @START AS [Coocon ATM Withdraw Reverse VOU],
		COUNT(*) AS [Reverse CNT],
		ISNULL(SUM(tran_amt), 0) AS [Reverse AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE acc_num = '182769895' AND	tran_date = @START
		AND field1 IN (SELECT rowId1 FROM #temp12)
		AND field2 = 'Coocon-ATM-Withdraw'
END
IF OBJECT_ID(N'tempdb..#temp12') IS NOT NULL
BEGIN
	DROP TABLE #temp12
END
------------------------------------------------------------
-- GME Pay Refund
SELECT tranId
INTO #temp13
FROM FastMoneyPro_Remit.dbo.TBL_GMEPAY_HISTORY(NOLOCK)
WHERE tranType = 'Refund'
	AND createdDate BETWEEN @START AND @ENDED
GROUP BY tranId;

IF NOT EXISTS(SELECT 'X' FROM #temp13)
BEGIN
	SELECT @START AS [GME Pay Refund Success TXN],
		0 AS [Success CNT], 0 AS [Success AMT]
	SELECT @START AS [GME Pay Refund Success VOU],
		0 AS [Success CNT], 0 AS [Success AMT]
END
ELSE
BEGIN
	SELECT @START AS [GME Pay Refund Success TXN],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(tranGmepay), 0) AS [Success AMT]
	FROM (
		SELECT COUNT(*) AS CNT, SUM(tranGmepay) AS tranGmepay
		FROM FastMoneyPro_Remit.dbo.TBL_GMEPAY_HISTORY(NOLOCK)
		WHERE tranId IN (SELECT tranId FROM #temp13)
		GROUP BY tranId
	) x

	SELECT @START AS [GME Pay Refund Success VOU],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(tran_amt), 0) AS [Success AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE tran_date = @START
		AND field1 IN (SELECT tranId FROM #temp13) AND gl_sub_head_code = '79'
		AND field2 IN ('GME PAY Recharge Cancel Wallet', 'GmePay Wallet Withdraw', 'EasyPay Wallet Withdraw')
END
IF OBJECT_ID(N'tempdb..#temp13') IS NOT NULL
BEGIN
	DROP TABLE #temp13
END
------------------------------------------------------------
-- Cashbee Transportation Card [DEVELOPING]
------------------------------------------------------------
-- Zero Pay [DEVELOPING]
------------------------------------------------------------
-- Lotte ATM Deposit
SELECT rowId, virtualAccountNo, billno
INTO #temp14
FROM FastMoneyPro_Remit.dbo.KSDepositHistory(NOLOCK)
WHERE isSuccess = 'Y' AND applyDate BETWEEN @START AND @ENDED;

IF NOT EXISTS(SELECT 'X' FROM #temp14)
BEGIN
	SELECT @START AS [Lotte ATM Deposit Success TXN],
		0 AS [Success CNT], 0 AS [Success AMT]
	SELECT @START AS [GME Pay Refund Success VOU],
		0 AS [Success CNT], 0 AS [Success AMT]
END
ELSE
BEGIN
	SELECT @START AS [Lotte ATM Deposit TXN],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(depositAmount), 0) AS [Success AMT]
	FROM FastMoneyPro_Remit.dbo.KSDepositHistory(NOLOCK)
	WHERE rowId IN (SELECT rowId FROM #temp14)

	SELECT @START AS [Lotte ATM Deposit VOU],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(tran_amt), 0) AS [Success AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE acc_num IN (SELECT virtualAccountNo FROM #temp14)
		AND tran_date = @START
		AND billno IN (SELECT billno FROM #temp14)
END
IF OBJECT_ID(N'tempdb..#temp14') IS NOT NULL
BEGIN
	DROP TABLE #temp14
END
------------------------------------------------------------
-- Easy Wallet(KICC) Deposit
-- Recharge-EasyWallet
SELECT rowId, CONVERT(VARCHAR(20), rowId) AS rowId1
INTO #temp15
FROM FastMoneyPro_Remit.dbo.TBL_KICC_DEPOSIT_DETAILS(NOLOCK)
WHERE status = 'S' AND depositedDate BETWEEN @START AND @ENDED
OPTION (USE HINT('FORCE_LEGACY_CARDINALITY_ESTIMATION'));

IF NOT EXISTS(SELECT 'X' FROM #temp15)
BEGIN
	SELECT @START AS [Easy Wallet(KICC) Deposit Success TXN],
		0 AS [Success CNT], 0 AS [Success AMT]
	SELECT @START AS [Easy Wallet(KICC) Deposit Success VOU],
		0 AS [Success CNT], 0 AS [Success AMT]
END
ELSE
BEGIN
	SELECT @START AS [Easy Wallet(KICC) Deposit Success TXN],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(amount), 0) AS [Success AMT]
	FROM FastMoneyPro_Remit.dbo.TBL_KICC_DEPOSIT_DETAILS(NOLOCK)
	WHERE rowId IN (SELECT rowId FROM #temp15)

	SELECT @START AS [Easy Wallet(KICC) Deposit Success VOU],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(tran_amt), 0) AS [Success AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE tran_date = @START AND gl_sub_head_code = '181'
		AND field1 IN (SELECT rowId1 FROM #temp15)
		AND field2 = 'KICC Deposit'
END
IF OBJECT_ID(N'tempdb..#temp15') IS NOT NULL
BEGIN
	DROP TABLE #temp15
END
------------------------------------------------------------
-- Convenience Store Deposit
SELECT ProcessId, CONVERT(VARCHAR(20), ProcessId) AS ProcessId1
INTO #temp16
FROM FastMoneyPro_Remit.dbo.TBL_GALAXIA_CONV_HISTORY(NOLOCK)
WHERE Result = '5' AND ChangedDate = @START AND DepositType = 'CS'
OPTION (USE HINT('FORCE_LEGACY_CARDINALITY_ESTIMATION'));

IF NOT EXISTS(SELECT 'X' FROM #temp16)
BEGIN
	SELECT @START AS [Convenience Store Deposit Success TXN],
		0 AS [Success CNT], 0 AS [Success AMT]
	SELECT @START AS [Convenience Store Deposit Success VOU],
		0 AS [Success CNT], 0 AS [Success AMT]
END
ELSE
BEGIN
	SELECT @START AS [Convenience Store Deposit Success TXN],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(Amt), 0) AS [Success AMT]
	FROM FastMoneyPro_Remit.dbo.TBL_GALAXIA_CONV_HISTORY(NOLOCK)
	WHERE ProcessId IN (SELECT ProcessId FROM #temp16)

	SELECT @START AS [Convenience Store Deposit Success VOU],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(tran_amt), 0) AS [Success AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE tran_date = @START AND gl_sub_head_code = '79'
		AND field1 IN (SELECT ProcessId1 FROM #temp16)
		AND field2 = 'Convenience Store Deposit'
END
IF OBJECT_ID(N'tempdb..#temp16') IS NOT NULL
BEGIN
	DROP TABLE #temp16
END
------------------------------------------------------------
-- Galaxia ATM Deposit
SELECT ProcessId, CONVERT(VARCHAR(20), ProcessId) AS ProcessId1
INTO #temp17
FROM FastMoneyPro_Remit.dbo.TBL_GALAXIA_CONV_HISTORY(NOLOCK)
WHERE Result = '5' AND ChangedDate = @START AND DepositType = 'ATM'
OPTION (USE HINT('FORCE_LEGACY_CARDINALITY_ESTIMATION'));

IF NOT EXISTS(SELECT 'X' FROM #temp17)
BEGIN
	SELECT @START AS [Galaxia ATM Deposit Success TXN],
		0 AS [Success CNT], 0 AS [Success AMT]
	SELECT @START AS [Galaxia ATM Deposit Success VOU],
		0 AS [Success CNT], 0 AS [Success AMT]
END
ELSE
BEGIN
	SELECT @START AS [Galaxia ATM Deposit Success TXN],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(Amt), 0) AS [Success AMT]
	FROM FastMoneyPro_Remit.dbo.TBL_GALAXIA_CONV_HISTORY(NOLOCK)
	WHERE ProcessId IN (SELECT ProcessId FROM #temp17)

	SELECT @START AS [Galaxia ATM Deposit Success VOU],
		COUNT(*)/2 AS [Success CNT],
		ISNULL(SUM(tran_amt), 0) AS [Success AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE acc_num IN ('172901649', '910341026858')
		AND tran_date = @START
		AND field1 IN (SELECT ProcessId1 FROM #temp17)
		AND field2 = 'Galaxia ATM Deposit'
END
IF OBJECT_ID(N'tempdb..#temp17') IS NOT NULL
BEGIN
	DROP TABLE #temp17
END
------------------------------------------------------------
-- GME Pay Recharge
SELECT rowId, tranId
INTO #temp18
FROM FastMoneyPro_Remit.dbo.TBL_GMEPAY_HISTORY(NOLOCK)
WHERE tranType = 'Recharge'
	AND createdDate BETWEEN @START AND @ENDED;

IF NOT EXISTS(SELECT 'X' FROM #temp18)
BEGIN
	SELECT @START AS [GME Pay Recharge Success TXN],
		0 AS [Success CNT], 0 AS [Success AMT]
	SELECT @START AS [GME Pay Recharge Success VOU],
		0 AS [Success CNT], 0 AS [Success AMT]
END
ELSE
BEGIN
	SELECT @START AS [GME Pay Recharge Success TXN],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(tranGmepay), 0) AS [Success AMT]
	FROM FastMoneyPro_Remit.dbo.TBL_GMEPAY_HISTORY(NOLOCK)
	WHERE rowId IN (SELECT rowId FROM #temp18)

	SELECT @START AS [GME Pay Recharge Success VOU],
		COUNT(*) AS [Success CNT],
		ISNULL(SUM(tran_amt), 0) AS [Success AMT]
	FROM FastMoneyPro_Account.dbo.tran_master(NOLOCK)
	WHERE tran_date = @START AND gl_sub_head_code = '79'
		AND field1 IN (SELECT tranId FROM #temp18) AND part_tran_type = 'DR'
		AND field2 IN ('GMEPAY Recharge wallet', 'GMEPAY Recharge audtdebit')
END
IF OBJECT_ID(N'tempdb..#temp18') IS NOT NULL
BEGIN
	DROP TABLE #temp18
END