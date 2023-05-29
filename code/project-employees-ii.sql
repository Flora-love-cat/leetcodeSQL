-- 1076. Project Employees II
WITH CTE1 AS (
    SELECT project_id, 
            RANK() OVER(ORDER BY COUNT(*) DESC) AS rk
    FROM Project 
    GROUP BY project_id
)
SELECT project_id
FROM CTE1 
WHERE rk=1;