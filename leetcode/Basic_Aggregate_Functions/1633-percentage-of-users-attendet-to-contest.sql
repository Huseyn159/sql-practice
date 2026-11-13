SELECT contest_id,ROUND(100 * COUNT(user_id)*1.0/(SELECT COUNT(user_id) FROM users)::numeric,2)
    AS percentage
FROM register
GROUP BY contest_id
ORDER BY percentage DESC,contest_id ASC

