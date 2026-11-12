SELECT query_name,ROUND(AVG(rating*1.0/position)::numeric,2) as quality,
ROUND(100* AVG(CASE WHEN rating < 3 THEN 1.0 ELSE 0 END)::numeric,2) as poor_query_percentage
FROM queries
GROUP BY query_name