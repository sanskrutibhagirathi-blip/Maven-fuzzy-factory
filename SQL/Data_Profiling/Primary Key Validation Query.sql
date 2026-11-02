SELECT 
count(order_id),
count(distinct order_id)
FROM Orders;

select count(order_item_id),
count(distinct order_item_id)
from Order_items;

select count(product_id),
count(distinct product_id)
from Products;

Select count(order_item_refund_id),
count(distinct order_item_refund_id)
from Order_item_refunds;

Select count(website_pageview_id),
count(distinct website_pageview_id)
from Website_pageviews;

Select count(website_session_id),
count(distinct website_session_id)
from Website_sessions;

--THUS PROVING THAT PRIMARY KEY HAS NO DUPLICATES AND IS UNIQUE