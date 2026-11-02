SELECT
COUNT(CASE WHEN order_id IS NULL THEN 1 END) AS order_id_nulls,
COUNT(CASE WHEN created_at IS NULL THEN 1 END) AS created_at_nulls,
COUNT(CASE WHEN website_session_id IS NULL THEN 1 END) AS website_session_id_nulls,
COUNT(CASE WHEN user_id IS NULL THEN 1 END) AS user_id_nulls,
COUNT(CASE WHEN primary_product_id IS NULL THEN 1 END) AS primary_product_id_nulls,
COUNT(CASE WHEN items_purchased IS NULL THEN 1 END) AS items_purchased_nulls,
COUNT(CASE WHEN price_usd IS NULL THEN 1 END) AS price_usd_nulls,
COUNT(CASE WHEN cogs_usd IS NULL THEN 1 END) AS cogs_usd_nulls
FROM Orders;

SELECT
COUNT(CASE WHEN order_item_id IS NULL THEN 1 END) AS order_item_id_nulls,
COUNT(CASE WHEN created_at IS NULL THEN 1 END) AS created_at_nulls,
COUNT(CASE WHEN order_id IS NULL THEN 1 END) AS order_id_nulls,
COUNT(CASE WHEN product_id IS NULL THEN 1 END) AS product_id_nulls,
COUNT(CASE WHEN is_primary_item IS NULL THEN 1 END) AS is_primary_item_nulls,
COUNT(CASE WHEN price_usd IS NULL THEN 1 END) AS price_usd_nulls,
COUNT(CASE WHEN cogs_usd IS NULL THEN 1 END) AS cogs_usd_nulls
FROM Order_items;

SELECT
COUNT(CASE WHEN order_item_id IS NULL THEN 1 END) AS order_item_id_nulls,
COUNT(CASE WHEN order_id IS NULL THEN 1 END) AS order_id_nulls,
COUNT(CASE WHEN refund_amount_usd IS NULL THEN 1 END) AS refund_amount_nulls,
COUNT(CASE WHEN created_at IS NULL THEN 1 END) AS created_at_nulls
FROM Order_item_refunds;

SELECT
COUNT(CASE WHEN product_id IS NULL THEN 1 END) AS product_id_nulls,
COUNT(CASE WHEN product_name IS NULL THEN 1 END) AS product_name_nulls,
COUNT(CASE WHEN created_at IS NULL THEN 1 END) AS created_at_nulls
FROM Products;

SELECT
COUNT(CASE WHEN website_session_id IS NULL THEN 1 END) AS website_session_id_nulls,
COUNT(CASE WHEN created_at IS NULL THEN 1 END) AS created_at_nulls,
COUNT(CASE WHEN user_id IS NULL THEN 1 END) AS user_id_nulls,
COUNT(CASE WHEN is_repeat_session IS NULL THEN 1 END) AS is_repeat_session_nulls,
COUNT(CASE WHEN utm_source IS NULL THEN 1 END) AS utm_source_nulls,
COUNT(CASE WHEN utm_campaign IS NULL THEN 1 END) AS utm_campaign_nulls,
COUNT(CASE WHEN utm_content IS NULL THEN 1 END) AS utm_content_nulls,
COUNT(CASE WHEN device_type IS NULL THEN 1 END) AS device_type_nulls,
COUNT(CASE WHEN http_referer IS NULL THEN 1 END) AS http_referer_nulls
FROM Website_sessions;

SELECT
COUNT(CASE WHEN website_pageview_id IS NULL THEN 1 END) AS website_pageview_id_nulls,
COUNT(CASE WHEN created_at IS NULL THEN 1 END) AS created_at_nulls,
COUNT(CASE WHEN website_session_id IS NULL THEN 1 END) AS website_session_id_nulls,
COUNT(CASE WHEN pageview_url IS NULL THEN 1 END) AS pageview_url_nulls
FROM Website_pageviews;