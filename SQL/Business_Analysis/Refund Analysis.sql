--Total refund:
select round(sum(cast(refund_amount_usd as float)),2) as total_refund from Order_item_refunds
--total refund items:
select count(*) from Order_item_refunds
--refund pct %
SELECT
    Refunded_Items,
    Total_Items,
    ROUND((Refunded_Items * 100.0) / Total_Items, 2) AS Refund_Rate_Percentage
FROM
(
    SELECT
        (SELECT COUNT(*) FROM Order_Item_Refunds) AS Refunded_Items,
        (SELECT COUNT(*) FROM Order_Items) AS Total_Items
) AS t;

--refund amount by product
select p.product_name as Product_name, 
round(sum(cast(oi.refund_amount_usd as float)),2) as Refund_revenue
from Order_item_refunds as oi
inner join Order_items as o
on o.order_id = oi.order_id
inner join Products as p
on o.product_id = p.product_id
group by p.product_name
order by round(sum(cast(oi.refund_amount_usd as float)),2) desc
--monthly refund rate:
SELECT
    YEAR(created_at) AS refund_year,
    MONTH(created_at) AS month_number,
    DATENAME(MONTH, created_at) AS month_name,
    ROUND(SUM(cast(refund_amount_usd as float)),2) AS total_refund_amount
FROM Order_Item_Refunds
GROUP BY YEAR(created_at),MONTH(created_at),DATENAME(MONTH, created_at)
ORDER BY refund_year, month_number;

--monthly refund rate by product
SELECT
    s.yr,
    s.mn,
    s.total_items,
    r.refunded_items,
    ROUND(r.refunded_items * 100.0 / s.total_items, 2) AS refund_rate
FROM
(
    SELECT
        YEAR(created_at) AS yr,
        MONTH(created_at) AS mn,
        COUNT(*) AS total_items
    FROM Order_Items
    GROUP BY YEAR(created_at), MONTH(created_at)
) s
INNER JOIN
(
    SELECT
        YEAR(created_at) AS yr,
        MONTH(created_at) AS mn,
        COUNT(*) AS refunded_items
    FROM Order_Item_Refunds
    GROUP BY YEAR(created_at), MONTH(created_at)
) r
ON s.yr = r.yr
AND s.mn = r.mn
ORDER BY s.yr, s.mn;