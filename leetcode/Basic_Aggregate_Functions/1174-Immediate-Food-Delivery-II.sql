SELECT ROUND(100.0* AVG(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END)::numeric,2)
        AS immediate_percentage
FROM (SELECT delivery_id,customer_id,order_date,customer_pref_delivery_date
      FROM delivery
      WHERE (customer_id,order_date) IN (SELECT customer_id,MIN(order_date)FROM delivery GROUP BY customer_id))