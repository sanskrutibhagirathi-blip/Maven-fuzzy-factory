select * from Order_items;
--order items sold
select 
count(order_item_id) as total_item_sold
from Order_items;
--total revenue
select
round(sum(cast (price_usd as float)),2) total_revenue
from Order_items;
--total cogs
select
round(sum(cast (cogs_usd as float)),2) total_cogs
from Order_items;
--total profit
select
round(sum(cast (price_usd as float)),2) - round(sum(cast (cogs_usd as float)),2) total_profit
from Order_items;
--number of products sold 
select distinct
product_id,
count(order_item_id) over(partition by product_id) as number_of_prod_sold
from Order_items
order by product_id asc;
--revenue generated productwise 
select distinct
product_id,
count(order_item_id) over(partition by product_id) as number_of_prod_sold,
round(sum(cast(price_usd as float)) over(partition by product_id),2) as product_wise_revenue
from Order_items
order by product_id asc;
--profit generated productwise 
select distinct
product_id,
count(order_item_id) over(partition by product_id) as number_of_prod_sold,
round(sum(cast(price_usd as float)) over(partition by product_id) -
sum(cast(cogs_usd as float)) over(partition by product_id),2) as product_wise_profit
from Order_items
order by product_id asc;
--average selling price productwise 
select distinct
product_id,
count(order_item_id) over(partition by product_id) as number_of_prod_sold,
round(avg(cast(price_usd as float)) over(partition by product_id),2) as product_wise_avg_selling_price
from Order_items
order by product_id asc;

--sales analysis : product mix
SELECT
    p.product_name,
    COUNT(*) AS Units_Sold,
    ROUND(
        COUNT(*)*100.0/
        (SELECT COUNT(*) FROM dbo.Order_items),
        2
    ) AS Product_Mix_Percentage
FROM dbo.Order_items oi
JOIN dbo.Products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Product_Mix_Percentage DESC;

--primary product sold
select distinct product_id,
count(is_primary_item) over(partition by product_id) as sold_as_primary
from Order_items
where is_primary_item = 1
order by product_id asc
--sold on demand 
select distinct product_id,
count(order_item_id) over(partition by product_id) as sold_on_demand 
from Order_items
order by product_id asc