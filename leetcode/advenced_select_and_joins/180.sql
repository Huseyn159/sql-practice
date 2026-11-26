WITH cte as(
    SELECT  id,num,lag(num,2) OVER (ORDER BY id) as prev_2,
        lag(num) over (ORDER BY id) as prev_1
    FROM logs )
SELECT DISTINCT num as ConsecutiveNums FROM cte WHERE num = prev_2 AND num = prev_1
