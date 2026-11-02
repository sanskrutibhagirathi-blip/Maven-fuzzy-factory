select * from Orders;

--total order count
select 
count(order_id) as total_order_counts
from Orders;

--total order value
select 
sum(cast(price_usd as float)) as total_revenue
from Orders;

--total gross profit
select
sum(cast(price_usd as float)) - sum(cast(cogs_usd as float)) as total_profit
from Orders;

--avg order value
select
avg(cast(price_usd as float)) as avg_order_value
from Orders;

-- number of orders per users
select 
count(distinct users) as multi_order_users
from
(select user_id as users,
count(user_id) over(partition by user_id) as Order_per_user
from Orders)t
where Order_per_user > 1

select distinct
count(users) single_order_users
from
(select user_id as users,
count(user_id) over(partition by user_id) as Order_per_user
from Orders)t
where Order_per_user = 1

select distinct 
Order_per_user,
count(Order_per_user) over(partition by Order_per_user) as user_seggregation
from
(select user_id as users,
count(user_id) over(partition by user_id) as Order_per_user
from Orders)t
------
SELECT
    Orders_Per_User,
    COUNT(*) AS Number_Of_Users
FROM
(
    SELECT
        user_id,
        COUNT(*) AS Orders_Per_User
    FROM dbo.Orders
    GROUP BY user_id
) t
GROUP BY Orders_Per_User
ORDER BY Orders_Per_User;
-----
--min and max order
select 
max(cast(price_usd as float)) as max_order_value,
min(cast(price_usd as float)) as min_order_value 
from Orders
--
select
primary_product_id,
count(order_id) as demanded_products
from Orders
group by primary_product_id
order by primary_product_id asc;

--month on month analysis
SELECT
    YEAR(created_at) AS Order_Year,
    DATENAME(MONTH, created_at) AS Month_Name,
    MONTH(created_at) AS Month_Number,
    COUNT(order_id) AS Total_Orders,
    ROUND(SUM(cast(price_usd as float)),2) AS Total_Revenue
FROM dbo.Orders
GROUP BY
    YEAR(created_at),
    MONTH(created_at),
    DATENAME(MONTH, created_at)
ORDER BY
    Order_Year,
    Month_Number;