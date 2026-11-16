BEGIN;
SELECT p.name,p.price
FROM products p
         JOIN categories c ON p.category_id = c.id
WHERE c.name = 'Elektronika';


UPDATE products p
SET price = price * 0.95
    FROM categories c
WHERE p.category_id = c.id
  AND c.name = 'Elektronika'
    RETURNING p.name,p.price;
COMMIT;


BEGIN;
SELECT c.full_name,c.city
FROM customers c
WHERE c.full_name = 'Kamran Rzayev';

UPDATE customers c
SET city = 'Bakı'
WHERE c.full_name = 'Kamran Rzayev'
    RETURNING c.full_name,c.city;
COMMIT ;

BEGIN;
SELECT id,created_at
FROM orders
WHERE created_at < '2026-11-01' and status = 'pending';

UPDATE orders
SET status = 'cancelled'
WHERE created_at < '2026-11-01'  and status = 'pending'
    RETURNING id,created_at;
ROLLBACK;


BEGIN;
DELETE FROM orders o
WHERE o.customer_id IN (
    SELECT c.id
    FROM customers c
    WHERE c.city = 'Gəncə') AND o.status = 'cancelled';
COMMIT;


BEGIN;
SELECT p.id,p.name
FROM products p
WHERE p.id NOT IN (SELECT oi.product_id FROM order_items oi);

DELETE FROM products p
WHERE p.id NOT IN(SELECT oi.product_id FROM order_items oi);
COMMIT;



BEGIN;
SELECT c.id,c.full_name
FROM customers c
WHERE c.id NOT IN (
    SELECT o.customer_id
    FROM orders o
    WHERE o.status = 'paid');

DELETE
FROM customers c
WHERE c.id NOT IN (
    SELECT o.customer_id
    FROM orders o
    WHERE o.status = 'paid');
ROLLBACK ;
SELECT id, full_name FROM customers WHERE id IN (5, 7);

BEGIN;
SELECT c.id,c.full_name
FROM customers c
WHERE c.id NOT IN (SELECT o.customer_id
                   FROM orders o
                   WHERE o.status = 'paid');

DELETE
FROM orders o
WHERE o.customer_id NOT IN (SELECT o.customer_id
                            FROM orders o
                            WHERE o.status = 'paid');

DELETE
FROM customers c
WHERE c.id NOT IN (SELECT o.customer_id
                   FROM orders o
                   WHERE o.status = 'paid');
COMMIT;


BEGIN;
SELECT p.id
FROM products p
WHERE p.name = 'Simsiz siçan';

UPDATE products
SET price = -100
WHERE name = 'Simsiz siçan';
ROLLBACK ;


