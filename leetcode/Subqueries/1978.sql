SELECT t.employee_id
FROM (
         SELECT employee_id,manager_id
         FROM employees
         WHERE salary < 30000
     ) as t
WHERE (t.manager_id) NOT IN (SELECT employee_id FROM employees )
ORDER BY t.employee_id


--daha sade ve exists ile
SELECT b.employee_id
FROM employees b
WHERE salary < 30000 AND NOT EXISTS (SELECT 1 FROM employees e WHERE b.manager_id = e.employee_id
                                                                  OR b.manager_id IS NULL)
ORDER BY b.employee_id