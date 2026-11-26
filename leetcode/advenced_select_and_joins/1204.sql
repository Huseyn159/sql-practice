WITH cte as (
    SELECT turn,person_name,
           SUM(weight) OVER (ORDER BY turn) as current_weight,
        LEAD(weight,1) OVER (ORDER BY turn) as next_weight
    FROM queue
)
SELECT person_name
FROM cte
WHERE (current_weight <= 1000 AND current_weight + next_weight > 1000) OR
      current_weight <= 1000 and next_weight IS NULL