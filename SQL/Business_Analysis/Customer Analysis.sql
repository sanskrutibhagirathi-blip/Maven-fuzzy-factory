--new vs repeating customer
WITH Customer_Orders AS
(
    SELECT
        user_id,
        COUNT(order_id) AS Total_Orders
    FROM Orders
    GROUP BY user_id
)

SELECT
    CASE
        WHEN Total_Orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS Customer_Type,
    COUNT(*) AS Total_Customers
FROM Customer_Orders
GROUP BY
    CASE
        WHEN Total_Orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END;

--customer repeat rate
WITH Customer_Orders AS
(
    SELECT
        user_id,
        COUNT(order_id) AS Total_Orders
    FROM Orders
    GROUP BY user_id
)

SELECT
    ROUND(
        COUNT(CASE WHEN Total_Orders > 1 THEN 1 END) * 100.0
        / COUNT(*),
        2
    ) AS Repeat_Customer_Rate
FROM Customer_Orders;

--avg order value
select round(avg(cast(price_usd as float)),2) as avg_order_value from Orders

--avg order per customer
SELECT
    ROUND(
        COUNT(order_id) * 1.0 /
        COUNT(DISTINCT user_id),
        2
    ) AS Avg_Orders_Per_Customer
FROM Orders;

--order frequency distribution
SELECT
    Total_Orders,
    COUNT(*) AS Total_Customers
FROM
(
    SELECT
        user_id,
        COUNT(order_id) AS Total_Orders
    FROM Orders
    GROUP BY user_id
) AS Customer_Order_Count
GROUP BY Total_Orders
ORDER BY Total_Orders;

--monhtly new customers
select
year(first_order_date) as year,
datename(month, first_order_date) as month,
count(*) as new_customers
from
(select user_id,
min(created_at) as first_order_date
from Orders
group by user_id)t
group by year(first_order_date) ,
datename(month, first_order_date) 
order by year(first_order_date) ,
datename(month, first_order_date) 

select * from Orders