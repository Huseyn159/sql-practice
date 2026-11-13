SELECT t.customer_id
FROM (SELECT customer_id,COUNT(DISTINCT product_key) AS product_cnt
      FROM customer
      GROUP BY customer_id) as t
WHERE t.product_cnt = (SELECT COUNT(product_key) FROM product)


-- having-li
SELECT customer_id
FROM customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product)
