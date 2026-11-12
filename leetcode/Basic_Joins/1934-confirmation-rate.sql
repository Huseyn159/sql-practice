SELECT s.user_id,
ROUND(AVG(CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0 END)::numeric,2) as confirmation_rate
FROM signups s
LEFT JOIN confirmations c ON c.user_id = s.user_id
GROUP BY s.user_id
