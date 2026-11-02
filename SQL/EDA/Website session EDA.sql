select * from Website_sessions ;
--total website sessions
select count(*) as total_website_sessions from Website_sessions;
--number of unique users
select 
count(distinct user_id) as unique_users 
from Website_sessions;
--new vs repeating users
select 
case when is_repeat_session = 0 then 'New User'
else 'Repeating user' end  as User_Type,
count(website_session_id) as Number_of_User
from Website_sessions
group by is_repeat_session
order by is_repeat_session asc

--fixing the string null into sql null and then replacing into string unknown
UPDATE dbo.Website_sessions
SET
    utm_source = CASE
                    WHEN utm_source = 'NULL' THEN 'Unknown'
                    ELSE utm_source
                 END,
    utm_campaign = CASE
                    WHEN utm_campaign = 'NULL' THEN 'Unknown'
                    ELSE utm_campaign
                   END,
    utm_content = CASE
                    WHEN utm_content = 'NULL' THEN 'Unknown'
                    ELSE utm_content
                  END,
    http_referer = CASE
                    WHEN http_referer = 'NULL' THEN 'Unknown'
                    ELSE http_referer
                   END;
UPDATE dbo.Website_sessions
SET
    utm_source = 'Unknown'
WHERE utm_source IS NULL;

--source traffic
select 
case when is_repeat_session = 0 then 'New User'
else 'Repeating user' end  as User_Type,
utm_source as Source_traffic,
count(website_session_id) as Number_of_User
from Website_sessions
group by is_repeat_session,utm_source
order by is_repeat_session, utm_source asc

--Ad content analysis
select distinct utm_content,
 count(user_id)  
over(partition by utm_content) as total_ad
from Website_sessions
order by utm_content asc

select 
case when is_repeat_session = 0 then 'New User'
else 'Repeating user' end  as User_Type,
utm_content as Source_content,
count(website_session_id) as Number_of_User
from Website_sessions
group by is_repeat_session,utm_content
order by is_repeat_session, utm_content asc
--device type
select 
case when is_repeat_session = 0 then 'New User'
else 'Repeating user' end as user_type,
device_type,
count(website_session_id) as users
from Website_sessions
group by is_repeat_session, device_type
order by is_repeat_session, device_type asc
--https
select 
case when is_repeat_session = 0 then 'New User'
else 'Repeating user' end as user_type,
device_type,
http_referer,
count(website_session_id) as users
from Website_sessions
group by is_repeat_session, device_type, http_referer
order by is_repeat_session, device_type,http_referer asc

--utm campaign
select 
case when is_repeat_session = 0 then 'New User'
else 'Repeating user' end as user_type,
device_type,
utm_campaign,
count(website_session_id) as users
from Website_sessions
group by is_repeat_session, device_type, utm_campaign
order by is_repeat_session, device_type,utm_campaign asc

--month on month analysis
SELECT
    YEAR(created_at) AS Session_Year,
    DATENAME(MONTH, created_at) AS Month_Name,
    MONTH(created_at) AS Month_Number,
    ISNULL(utm_campaign, 'Unknown') AS Campaign,
    COUNT(*) AS Total_Sessions
FROM Website_sessions
GROUP BY
    YEAR(created_at),
    MONTH(created_at),
    DATENAME(MONTH, created_at),
    ISNULL(utm_campaign, 'Unknown')
ORDER BY
    Session_Year,
    Month_Number,
    Campaign;