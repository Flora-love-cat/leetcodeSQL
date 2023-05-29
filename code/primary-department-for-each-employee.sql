-- 1789. Primary Department for Each Employee
WITH CTE AS (
    SELECT employee_id,
            COUNT(*) AS ct 
    FROM Employee 
    GROUP BY employee_id
)
SELECT e.employee_id, e.department_id
FROM Employee e 
    JOIN CTE c ON e.employee_id = c.employee_id
WHERE (c.ct > 1 AND e.primary_flag='Y') OR c.ct = 1;