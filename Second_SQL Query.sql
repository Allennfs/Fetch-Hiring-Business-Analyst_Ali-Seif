WITH currentMonth(
SELECT COUNT(rec.Receipts_id) AS McCount, brd.name , DATEPART(MONTH, rec.purchaseDate) AS Month
FROM Receipts AS rec
LEFT JOIN Brand AS brd ON brd.bardcode = rec.rewardsReceiptItemList
GROUP BY brd.name
WHERE  DATEPART(MONTH, rec.purchaseDate) = DATEPART(MONTH,GETDATE())
)
, LastMonth(
SELECT COUNT(rec.Receipts_id) AS McCountPrev, brd.name , DATEPART(MONTH, rec.purchaseDate) AS Month
FROM Receipts AS rec
LEFT JOIN Brand AS brd ON brd.bardcode = rec.rewardsReceiptItemList
GROUP BY brd.name
WHERE  DATEPART(MONTH, rec.purchaseDate) = DATEPART(DATEADD(MONTH, -1 ,GETDATE()))
)
SELECT crm.name, crm.McCount AS [This Month Count], lsm.McCountPrev AS [Last Month Count]
FROM currentMonth AS crm
LEFT JOIN LastMonth AS lsm ON lsm.name = crm.name