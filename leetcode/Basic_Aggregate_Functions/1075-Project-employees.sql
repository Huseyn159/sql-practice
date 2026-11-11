SELECT p.project_id,ROUND(AVG(e.experience_years)::numeric,2) as average_years
FROM project p
LEFT JOIN employee e  ON p.employee_id = e.employee_id
GROUP BY p.project_id
ORDER BY p.project_id