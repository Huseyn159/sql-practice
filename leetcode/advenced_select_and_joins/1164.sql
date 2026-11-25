SELECT product_id,new_price as price
FROM products
WHERE (product_id,change_date) IN
      (SELECT product_id,MAX(change_date)
       FROM (
                SELECT product_id,change_date
                FROM products
                WHERE change_date <= '2019-08-16')
       GROUP BY product_id
      )
UNION
(SELECT product_id,10 as price
 FROM products
 EXCEPT
 SELECT product_id,10 as price
 FROM (
          SELECT product_id,new_price
          FROM products
          WHERE (product_id,change_date) IN
                (SELECT product_id,MAX(change_date)
                 FROM (
                          SELECT product_id,change_date
                          FROM products
                          WHERE change_date <= '2019-08-16')
                 GROUP BY product_id
                )))

--- CTE ile
WITH last_dates AS (
    SELECT product_id,MAX(change_date)
    FROM products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
),
last_prices AS (
    SELECT product_id,new_price
    FROM products
    WHERE (product_id,change_date) IN (SELECT * FROM last_dates)
)

SELECT product_id,new_price as price
FROM  last_prices
UNION ALL
SELECT DISTINCT product_id,10 as price
FROM products
WHERE (product_id) NOT IN (SELECT product_id FROM last_prices)