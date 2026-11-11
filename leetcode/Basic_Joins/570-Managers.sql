SELECT m.name
FROM employee m
LEFT JOIN employee e ON e.managerId = m.id
GROUP BY m.id,m.name
HAVING COUNT(e.id) >= 5