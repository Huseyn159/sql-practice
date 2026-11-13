SELECT ROUND((COUNT(player_id)*1.0/(SELECT COUNT(DISTINCT player_id)FROM activity))::numeric,2)
           AS fraction
FROM activity
WHERE (player_id,event_date-1) IN (SELECT player_id,MIN(event_date)
                                   FROM activity
                                   GROUP BY player_id);
