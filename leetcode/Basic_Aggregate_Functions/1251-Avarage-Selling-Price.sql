SELECT p.product_id,
COALESCE (ROUND(SUM(p.price * u.units)/NULLIF(SUM(u.units),0)::numeric,2),0) AS average_price
FROM prices p
    LEFT JOIN unitssold u ON u.product_id = p.product_id
    AND u.purchase_date >= p.start_date
    AND u.purchase_date <= p.end_date
GROUP BY p.product_id

