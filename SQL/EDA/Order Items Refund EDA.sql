select * from Order_item_refunds
--total refunded items
SELECT COUNT(*) AS Total_Refunded_Items
FROM Order_item_refunds;
--total refunded revenue:
SELECT
ROUND(SUM(cast(refund_amount_usd as float)),2) AS Total_Refund_Amount
FROM Order_item_refunds;
--average refunded revenue
SELECT
ROUND(AVG(cast(refund_amount_usd as float)),2) AS Average_Refund
FROM Order_item_refunds;
--month on month refund trend
SELECT
YEAR(created_at) AS Refund_Year,
DATENAME(MONTH,created_at) AS Month_Name,
MONTH(created_at) AS Month_Number,
COUNT(*) AS Total_Refunds,
ROUND(SUM(cast(refund_amount_usd as float)),2) AS Refund_Amount
FROM dbo.Order_item_refunds
GROUP BY
YEAR(created_at),
MONTH(created_at),
DATENAME(MONTH,created_at)
ORDER BY
Refund_Year,
Month_Number;