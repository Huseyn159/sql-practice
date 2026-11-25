WITH order_cost as (
    SELECT oi.order_id,SUM(oi.qty * oi.unit_price) as cost
    FROM order_items oi
    GROUP BY oi.order_id
)
SELECT MAX(cost)
FROM order_cost;

WITH customer_paid as (
    SELECT c.full_name,c.id,SUM(oi.qty*oi.unit_price) as cost
    FROM order_items oi
             JOIN orders o ON oi.order_id = o.id AND O.status = 'paid'
             JOIN customers c ON o.customer_id = c.id
    GROUP BY c.id,c.full_name
),avg_order_cost as (
    SELECT AVG(cost)
    FROM customer_paid
)
SELECT a.full_name,a.cost
FROM customer_paid a
WHERE a.cost > (SELECT * FROM avg_order_cost);

SELECT c.full_name,o.id,count(*) OVER (PARTITION BY o.customer_id) as sifaris_sayi
FROM orders o
         JOIN customers c ON o.customer_id = c.id


SELECT p.name,p.price,p.category_id,
       MAX(p.price) OVER w as higest_price,
    MAX(p.price) OVER w - p.price as ferq
FROM products p
WINDOW w AS( PARTITION BY p.category_id)

WITH rn as (SELECT customer_id,id,created_at,row_number() over (partition by customer_id order by created_at desc ) as r
            FROM orders)
SELECT *
FROM rn
WHERE rn.r =1;

WITH rn as (SELECT category_id,p.name,p.price,dense_rank() over (PARTITION BY category_id ORDER BY p.price desc ) as r
            FROM products p)
SELECT * FROM rn WHERE rn.r <3;

SELECT o.id,full_name,
       o.created_at::date AS d,
    LAG(o.created_at::date) OVER w AS prev,
    o.created_at::date - LAG(o.created_at::date) OVER w AS gun
FROM orders o
         JOIN customers c ON o.customer_id = c.id
WINDOW w AS (PARTITION BY c.id ORDER BY o.created_at)


SELECT o.id,c.full_name,
       o.created_at::date as d,
       LAG