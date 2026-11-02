SELECT * FROM Website_pageviews
-- TYPES OF PAGEVIEW
SELECT distinct pageview_url from Website_pageviews
order by pageview_url asc
--number of pageview
select count(distinct pageview_url) as pageview_count 
from Website_pageviews
--pageview distribution
select distinct pageview_url,
count(website_pageview_id) as total_visits
from Website_pageviews
group by pageview_url
order by count(website_pageview_id) desc

--avg pages view per session
SELECT ROUND(AVG(Page_Count * 1.0),2) AS Avg_Pages_Per_Session
FROM
(SELECT website_session_id,
COUNT(*) AS Page_Count
FROM Website_pageviews
GROUP BY website_session_id) t;

--month on month pageview trend
SELECT
    YEAR(created_at) AS Year,
    DATENAME(MONTH, created_at) AS Month_Name,
    MONTH(created_at) AS Month_Number,
    COUNT(*) AS Total_Pageviews
FROM Website_pageviews
GROUP BY
    YEAR(created_at),
    MONTH(created_at),
    DATENAME(MONTH, created_at)
ORDER BY
    Year,
    Month_Number;

--using CTE analysing the landing page
WITH First_Page AS
(
 SELECT
website_session_id,
MIN(website_pageview_id) AS First_Pageview_ID
FROM dbo.Website_pageviews
GROUP BY website_session_id
)
SELECT
    wp.pageview_url AS Landing_Page,
    COUNT(*) AS Landing_Page_Sessions
FROM First_Page fp
JOIN dbo.Website_pageviews wp
    ON fp.First_Pageview_ID = wp.website_pageview_id
GROUP BY wp.pageview_url
ORDER BY Landing_Page_Sessions DESC;
--using cte to find exiting page
WITH last_Page AS
(
 SELECT
website_session_id,
Max(website_pageview_id) AS last_Pageview_ID
FROM dbo.Website_pageviews
GROUP BY website_session_id
)
SELECT
    wp.pageview_url AS exiting_Page,
    COUNT(*) AS exiting_Page_Sessions
FROM last_Page lp
JOIN dbo.Website_pageviews wp
    ON lp.last_Pageview_ID = wp.website_pageview_id
GROUP BY wp.pageview_url
ORDER BY exiting_Page_Sessions DESC;