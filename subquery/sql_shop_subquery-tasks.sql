--tek deyer qaytaran subquery
SELECT MAX(price)
FROM products;

SELECT name,price
FROM products
WHERE price = (SELECT MAX(price)
               FROM products);

SELECT name,price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

SELECT name,price,
       ROUND(100 * price/(SELECT MAX(price) FROM products) :: numeric,2)
           as bahali_mehsulun_nece_faizi
FROM products;

SELECT name,price
FROM products
WHERE price < (SELECT MAX(price) FROM products)
ORDER BY price DESC
    LIMIT 1;

SELECT name,price
FROM products
WHERE price = (SELECT price
               FROM products
               WHERE price < (SELECT MAX(price) FROM products)
               ORDER BY price DESC
    LIMIT 1);

--siyahi qaytaran subquery
SELECT DISTINCT customer_id
FROM orders
WHERE status = 'paid';

SELECT full_name
FROM customers
WHERE id IN ((SELECT customer_id
              FROM orders
              WHERE status = 'paid'));

SELECT full_name
FROM customers
WHERE id IN (
    SELECT customer_id
    FROM orders o
             JOIN order_items oi ON oi.order_id =o.id
             JOIN products p ON oi.product_id = p.id
             JOIN categories c ON p.category_id = c.id AND c.name = 'Kitab'
);



SELECT full_name
FROM customers
WHERE id IN (SELECT customer_id
             FROM orders o
             WHERE customer_id NOT IN((SELECT customer_id
                                       FROM orders
                                       WHERE status = 'cancelled')));
-- Alternativ:
SELECT full_name
FROM customers
WHERE id IN (SELECT customer_id FROM orders)
  AND id NOT IN (SELECT customer_id FROM orders WHERE status = 'cancelled');


--EXISTS
SELECT full_name
FROM customers c
WHERE  EXISTS(
    SELECT 1
    FROM orders o WHERE o.customer_id = c.id);

SELECT name
FROM products p
WHERE  NOT EXISTS (SELECT 1 FROM order_items oi WHERE oi.product_id = p.id);


SELECT p.name
FROM products p
WHERE NOT EXISTS(SELECT 1
                 FROM orders o
                          JOIN order_items oi ON o.id = oi.order_id
                 WHERE o.status ='cancelled' AND p.id = oi.product_id)


--FROM-da subquery

SELECT o.id,SUM(oi.unit_price*oi.qty) as order_value
FROM orders o
         LEFT JOIN order_items oi ON oi.order_id = o.id
GROUP BY o.id;


SELECT ROUND(AVG(t.order_value)::numeric,2)
FROM (SELECT o.id,SUM(oi.unit_price*oi.qty) as order_value
      FROM orders o
               LEFT JOIN order_items oi ON oi.order_id = o.id
      GROUP BY id) as t;


SELECT t.id
FROM  (SELECT o.id,SUM(oi.unit_price*oi.qty) as order_value
       FROM orders o
                LEFT JOIN order_items oi ON oi.order_id = o.id
       GROUP BY id) as t
WHERE t.order_value > ( SELECT ROUND(AVG(t.order_value)::numeric,2)
                        FROM (SELECT o.id,SUM(oi.unit_price*oi.qty) as order_value
                              FROM orders o
                                       LEFT JOIN order_items oi ON oi.order_id = o.id
                              GROUP BY id) as t);
--alternativ hell
SELECT o.id,SUM(oi.unit_price*oi.qty) as order_value
FROM orders o
         LEFT JOIN order_items oi ON oi.order_id = o.id
GROUP BY o.id
HAVING SUM(oi.unit_price*oi.qty) >(SELECT ROUND(AVG(t.order_value)::numeric,2)
                                   FROM (SELECT o.id,SUM(oi.unit_price*oi.qty) as order_value
                                         FROM orders o
                                                  LEFT JOIN order_items oi ON oi.order_id = o.id
                                         GROUP BY id) as t);

SELECT c.id,c.full_name  ,SUM(oi.unit_price*oi.qty) as total
FROM customers c
         JOIN orders o ON o.customer_id = c.id AND o.status = 'paid'
         JOIN order_items oi ON oi.order_id = o.id
GROUP BY c.id,c.full_name;

C

SELECT MAX(total)
FROM (
         SELECT c.id,c.full_name,SUM(oi.unit_price*oi.qty) as total
         FROM customers c
                  JOIN orders o ON o.customer_id = c.id AND o.status = 'paid'
                  JOIN order_items oi ON oi.order_id = o.id
         GROUP BY c.id,c.full_name) as cs;

SELECT *
FROM (SELECT c.id,c.full_name  ,SUM(oi.unit_price*oi.qty) as total
      FROM customers c
               JOIN orders o ON o.customer_id = c.id AND o.status = 'paid'
               JOIN order_items oi ON oi.order_id = o.id
      GROUP BY c.id,c.full_name
     ) as gg
WHERE gg.total >= (SELECT MAX(total)
                   FROM (
                            SELECT c.id,c.full_name,SUM(oi.unit_price*oi.qty) as total
                            FROM customers c
                                     JOIN orders o ON o.customer_id = c.id AND o.status = 'paid'
                                     JOIN order_items oi ON oi.order_id = o.id
                            GROUP BY c.id,c.full_name) as cs)
