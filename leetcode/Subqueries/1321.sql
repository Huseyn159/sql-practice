WITH daily_amount as(
    SELECT visited_on,SUM(amount) as amount
    FROM customer
    GROUP BY visited_on
),
     cte as(
         SELECT visited_on,
                SUM(amount) over w AS amount,
             ROUND(AVG(amount) over w ::numeric,2)as average_amount,
                COUNT(*) OVER w AS cnt
         FROM daily_amount
                  WINDOW w AS (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW )
    )
SELECT  visited_on,amount,average_amount FROM cte
WHERE cnt = 7