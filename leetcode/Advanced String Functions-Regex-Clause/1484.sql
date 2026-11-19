SELECT sell_date,COUNT (DISTINCT product) as num_sold,
       STRING_AGG(DISTINCT product,',' ORDER BY product) as products
FROM activities
GROUP BY sell_date
ORDER BY sell_date
