SELECT activity_date as day,COUNT(DISTINCT user_id) as active_users
FROM activity
WHERE activity_date >'2019-06-27' AND activity_date <'2019-07-28'
GROUP BY activity_date