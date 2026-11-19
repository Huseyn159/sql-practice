SELECT p.product_name,t.unit
FROM products p
         JOIN (SELECT product_id,SUM(unit) as unit
               FROM orders
               WHERE order_date >='2020-02-01' AND order_date<'2020-03-01'
               GROUP BY product_id) as t ON t.product_id = p.product_id
WHERE t.unit >=100

--bir qatli

SELECT p.product_name,SUM(o.unit) as unit
FROM products p
         JOIN orders o ON o.product_id = p.product_id
WHERE o.order_date >= '2020-02-01' AND o.order_date<'2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100