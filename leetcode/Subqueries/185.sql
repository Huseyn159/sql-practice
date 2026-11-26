WITH salaries as(
    SELECT dense_rank() OVER (PARTITION BY d.id ORDER BY e.salary DESC ) as dr,d.name as department,
           e.name as employee,e.salary
    FROM employee e
             JOIN department d ON e.departmentId = d.id
)
SELECT department,employee,salary
FROM salaries
WHERE dr < 4