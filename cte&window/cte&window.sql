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
WINDOW w AS (PARTITION BY c.id ORDER BY o.created_at);

SELECT o.id,c.full_name,
       o.created_at::date as d,
    LAG(o.created_at::date) OVER w AS prev,
    LEAD(o.created_at::date) OVER w AS next,
       o.created_at::date - LAG(o.created_at::date) OVER w AS prev_order,
       LEAD(o.created_at::date)  OVER w - o.created_at::date AS next_order
FROM orders o
    JOIN customers c ON o.customer_id = c.id
    WINDOW w AS(PARTITION BY c.id ORDER BY o.created_at)


--Ödənilmiş sifarişlərin məbləğləri, tarixə görə sıralı.
-- Hər birinin yanında: əvvəlki ödənilmiş sifarişdən çoxdursa 'artım', azdırsa 'azalma', əvvəlki yoxdursa 'ilk'.
-- Bütün mağaza üzrə, müştəridən asılı olmayaraq.

WITH paid_orders AS (
    SELECT o.id,o.created_at,SUM(oi.qty*oi.unit_price) as cost
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.id
    WHERE o.status = 'paid'
    GROUP BY o.id,o.created_at)

SELECT *,
       CASE WHEN lag(cost) over w IS NULL THEN 'ilk'
           WHEN (lag(cost) over w - cost) > 0  THEN 'azalma'
           WHEN (lag(cost) over w - cost) < 0  THEN 'artim'
           ELSE 'stabil' END as deyisiklik
FROM paid_orders
WINDOW w AS (ORDER BY created_at);

WITH paid_totals AS (
    SELECT o.id,o.created_at,SUM(oi.qty*oi.unit_price) as total
    FROM orders o
             JOIN order_items oi ON oi.order_id = o.id
    WHERE o.status = 'paid'
    GROUP BY o.id,o.created_at)

SELECT id, created_at::date, total,
       SUM(total) OVER (ORDER BY created_at) AS cumulative
FROM paid_totals;

WITH paid_totals AS (
    SELECT o.customer_id,o.id,o.created_at,SUM(oi.qty*oi.unit_price) as total
    FROM orders o
             JOIN order_items oi ON oi.order_id = o.id
    WHERE o.status = 'paid'
    GROUP BY o.id,o.created_at)
SELECT c.full_name,p.created_at::date,total,SUM(total) OVER (PARTITION BY c.id ORDER BY created_at::date)
FROM paid_totals p
         JOIN customers c ON p.customer_id = c.id;



WITH paid_totals AS (
    SELECT o.customer_id,o.id,o.created_at,SUM(oi.qty*oi.unit_price) as total
    FROM orders o
             JOIN order_items oi ON oi.order_id = o.id
    WHERE o.status = 'paid'
    GROUP BY o.id,o.created_at)
SELECT id,total,SUM(total) OVER (ORDER BY created_at ROWS BETWEEN 2 PRECEDING AND CURRENT ROW )
FROM paid_totals;


WITH paid_totals AS (
    SELECT o.customer_id,o.id,o.created_at,SUM(oi.qty*oi.unit_price) as total
    FROM orders o
             JOIN order_items oi ON oi.order_id = o.id
    WHERE o.status = 'paid'
    GROUP BY o.id,o.created_at),
     windowed AS (
         SELECT id,
                ROUND(AVG(total) OVER w, 2) AS last_3_avg,
                COUNT(*)              OVER w AS cnt
         FROM paid_totals
                  WINDOW w AS (ORDER BY created_at ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
    )
SELECT id, last_3_avg
FROM windowed
WHERE cnt = 3;



SELECT c.full_name,o.created_at::date,
    o.created_at::date - lag(o.created_at::date)  OVER (PARTITION BY c.id ORDER BY o.created_at::date) ::date as diff
FROM customers c
         JOIN orders o on o.customer_id = c.id
WHERE o.status = 'paid';

WITH cte as(
    SELECT p.name as product,c.name as category,p.price,dense_rank() OVER (PARTITION BY p.category_id ORDER BY p.price DESC) as dr
    FROM products p
             JOIN categories c ON p.category_id = c.id)
SELECT * FROM cte WHERE cte.dr = 1


WITH cte as (
    SELECT o.customer_id,o.id as last_paid_order,row_number() over (PARTITION BY o.customer_id ORDER BY o.created_at DESC) as rn
    FROM orders o
    WHERE o.status = 'paid'
)
SELECT * FROM cte WHERE rn = 1