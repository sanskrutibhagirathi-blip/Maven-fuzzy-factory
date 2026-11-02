--total sessions
SELECT COUNT(*) AS Total_Website_Sessions
FROM Website_Sessions;
--conversion rate
SELECT
COUNT(*) AS Total_Orders,
(SELECT COUNT(*) FROM Website_Sessions) AS Total_Sessions,
ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM Website_Sessions),2) AS Conversion_Rate
FROM Orders;
--repeat visitors
SELECT
COUNT(*) AS Repeat_Sessions,
(SELECT COUNT(*) FROM Website_Sessions) AS Total_Sessions,
ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM Website_Sessions),2) AS Repeat_Visitor_Rate
FROM Website_Sessions
WHERE is_repeat_session=1;
--campaign performance
SELECT
ws.utm_campaign,
COUNT(DISTINCT o.order_id) AS Total_Orders,
ROUND(SUM(cast(oi.price_usd as float)),2) AS Revenue,
ROUND(SUM(cast(oi.price_usd as float)- cast(oi.cogs_usd as float)),2) AS Profit
FROM Website_Sessions ws
JOIN Orders o
ON ws.website_session_id=o.website_session_id
JOIN Order_Items oi
ON o.order_id=oi.order_id
GROUP BY ws.utm_campaign
ORDER BY Revenue DESC;
--user activity in day
SELECT
DATEPART(HOUR,created_at) AS Hour_of_Day,
COUNT(*) AS Sessions
FROM Website_Sessions
GROUP BY DATEPART(HOUR,created_at)
ORDER BY Hour_of_Day;
--utm source performance
SELECT
ws.utm_source,
COUNT(DISTINCT ws.website_session_id) AS Sessions,
COUNT(DISTINCT o.order_id) AS Orders,
ROUND(
COUNT(DISTINCT o.order_id)*100.0/
COUNT(DISTINCT ws.website_session_id),
2) AS Conversion_Rate
FROM Website_Sessions ws
LEFT JOIN Orders o
ON ws.website_session_id=o.website_session_id
GROUP BY ws.utm_source
ORDER BY Sessions DESC;
--device performance
SELECT
ws.device_type,
COUNT(DISTINCT ws.website_session_id) AS Sessions,
COUNT(DISTINCT o.order_id) AS Orders,
ROUND(
COUNT(DISTINCT o.order_id)*100.0/
COUNT(DISTINCT ws.website_session_id),
2) AS Conversion_Rate
FROM Website_Sessions ws
LEFT JOIN Orders o
ON ws.website_session_id=o.website_session_id
GROUP BY ws.device_type;