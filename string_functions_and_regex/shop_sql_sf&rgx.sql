SELECT split_part(full_name,' ',1) as ad
FROM customers;

SELECT name,upper(LEFT(name,3)) as code
FROM products;

SELECT count(name)
FROM products
WHERE name ILIKE '%a%';

SELECT
    split_part(full_name,' ',1) || ' ' ||
    "left"(split_part(full_name,' ',2),1) || '.' as qisa_soyad
FROM customers;

SELECT c.name,string_agg(p.name,',' ORDER BY p.name)
FROM categories c
         JOIN products p ON p.category_id = c.id
GROUP BY c.id