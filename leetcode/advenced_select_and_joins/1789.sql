SELECT employee_id,department_id
FROM employee
WHERE employee_id IN(
    SELECT e.employee_id
    FROM employee e
    GROUP BY e.employee_id
    HAVING COUNT(*) =1
) OR primary_flag = 'Y'
