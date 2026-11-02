--revenue by product
select 
p.product_name as product,
round(sum(cast(o.price_usd as float)),2) as revenue
from Order_items as o
left join Products as p
on o.product_id = p.product_id
group by p.product_name
order by round(sum(cast(o.price_usd as float)),2)  desc

--most profitable product
select 
p.product_name as product,
round(sum(cast(o.price_usd as float)),2) - round(sum(cast(o.cogs_usd as float)),2) as profit
from Order_items as o
left join Products as p
on o.product_id = p.product_id
group by p.product_name
order by round(sum(cast(o.price_usd as float)),2) - round(sum(cast(o.cogs_usd as float)),2)  desc

--units sold per product
select 
count(o.order_item_id) as Units_sold_per_product,
p.product_name
from Order_items as o
inner join Products as p
on o.product_id = p.product_id
group by p.product_name
order by count(o.order_item_id) desc

--revenue contribution by product
select distinct product,
round((revenue/total_revenue)*100,2) as contribution_to_revenue
from
(select
p.product_name as product,
round(sum(cast(o.price_usd as float)) over(partition by p.product_name),2) as revenue,
round(sum(cast(o.price_usd as float)) over(),2) as total_revenue
from Order_items as o
left join Products as p
on o.product_id = p.product_id
) t
order by round((revenue/total_revenue)*100,2) desc

--month on month revenue trend
SELECT
    YEAR(o.created_at) AS Order_Year,
    DATENAME(MONTH,o.created_at) AS Month_Name,
    MONTH(o.created_at) AS Month_Number,
    ROUND(SUM(cast(oi.price_usd as float) ),2) AS Total_Revenue
FROM Orders o
INNER JOIN Order_Items oi
    ON o.order_id = oi.order_id
GROUP BY
    YEAR(o.created_at),
    MONTH(o.created_at),
    DATENAME(MONTH,o.created_at)
ORDER BY
    Order_Year,
    Month_Number;
--monthly orders trend
    SELECT
    YEAR(created_at) AS Order_Year,
    DATENAME(MONTH,created_at) AS Month_Name,
    MONTH(created_at) AS Month_Number,
    COUNT(order_id) AS Total_Orders
FROM Orders
GROUP BY
    YEAR(created_at),
    MONTH(created_at),
    DATENAME(MONTH,created_at)
ORDER BY
    Order_Year,
    Month_Number;