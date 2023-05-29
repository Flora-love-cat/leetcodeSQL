-- 1077. Project Employees III
WITH CTE AS(
    SELECT p.project_id, p.employee_id,
            RANK() OVER(PARTITION BY p.project_id ORDER BY e.experience_years DESC) AS rk
    FROM Project p 
        JOIN Employee e ON p.employee_id=e.employee_id
)
SELECT project_id, employee_id
FROM CTE 
WHERE rk=1;