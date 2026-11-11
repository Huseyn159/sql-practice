
-- GROUP BY VE COUNT
SELECT c.id,c.name,COUNT(p.category_id) AS total
FROM categories c
         LEFT JOIN products p ON p.category_id = c.id
GROUP BY c.id
ORDER BY c.id;

SELECT c.id,c.full_name,COUNT(o.customer_id) as total
FROM customers c
         LEFT JOIN orders o ON o.customer_id = c.id
GROUP BY c.id,c.full_name
ORDER BY c.id;

SELECT o.id,SUM(oi.qty * oi.unit_price) as total_order_value
FROM orders o
         LEFT JOIN order_items oi ON oi.order_id = o.id
GROUP BY o.id
ORDER BY total_order_value;

-- SUM,HAVING
SELECT c.id,c.full_name,COALESCE(SUM(oi.qty*oi.unit_price),0)as total_value
FROM customers c
         JOIN orders o ON o.customer_id = c.id
         JOIN order_items oi ON oi.order_id = o.id
WHERE o.status = 'paid'
GROUP BY c.id,c.full_name
ORDER BY total_value DESC;

SELECT c.id,c.full_name,COUNT(o.id) as total_orders
FROM customers c
         LEFT JOIN orders o on o.customer_id = c.id
GROUP BY c.id,c.full_name
HAVING COUNT(o.id) > 2;

SELECT c.city,
       COUNT(DISTINCT o.id) as total_orders,SUM(oi.qty*oi.unit_price)
FROM customers c
         JOIN orders o ON o.customer_id = c.id
         JOIN order_items oi ON oi.order_id = o.id
WHERE o.status = 'paid'
GROUP BY c.city

--CASE
SELECT c.id,c.full_name,COUNT(o.id) as all_orders,
       COUNT(CASE WHEN o.status = 'paid' THEN 1 END ) as paid_orders,
       COUNT(CASE WHEN o.status = 'cancelled' THEN 1 END) as cancelled_orders
FROM customers c
         LEFT JOIN orders o ON o.customer_id = c.id
GROUP BY c.full_name,c.id;

SELECT c.id,c.full_name,ROUND(100.0 *  COUNT(CASE WHEN o.status = 'cancelled' THEN 1 END )/NULLIF(COUNT(o.id),0),2) AS cancel_rate
FROM customers c
         LEFT JOIN orders o ON o.customer_id = c.id
GROUP BY c.id,c.full_name;

SELECT
    CASE WHEN p.price >=500 THEN  'bahali' WHEN p.price >= 50 THEN 'orta' ELSE 'ucuz' END AS price_scale,count(*)
FROM products p
GROUP BY price_scale

SELECT o.id,
       CASE WHEN o.status = 'paid' THEN 'odenilib'
            WHEN o.status = 'cancelled' THEN 'legv edilib'
            ELSE 'gozleyir'
           END as status_az
FROM orders o;

SELECT COUNT(CASE WHEN o.status = 'paid' THEN 1 END) AS paid_order_count
FROM orders o;
