SELECT m.employee_id,m.name,COUNT(*) as reports_count,ROUND(AVG(e.age)) as average_age
FROM employees e
         JOIN employees m ON e.reports_to = m.employee_id
GROUP BY m.employee_id,m.name
ORDER BY m.employee_id