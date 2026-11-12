SELECT MAX(e.salary) as secondhighestsalary
FROM employee e
WHERE e.salary < (SELECT MAX(e.salary)
                  FROM employee e)