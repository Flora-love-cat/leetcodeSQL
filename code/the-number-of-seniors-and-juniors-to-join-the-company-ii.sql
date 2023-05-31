-- 2010. The Number of Seniors and Juniors to Join the Company II
WITH cumulative_salary_CTE AS(
    SELECT employee_id, experience,
            SUM(salary) OVER(PARTITION BY experience ORDER BY salary, employee_id) AS cumulative_salary
    FROM Candidates
), Senior_CTE AS(
    SELECT employee_id
    FROM cumulative_salary_CTE
    WHERE cumulative_salary<=70000 AND experience='Senior'
), Junior_CTE AS(
    SELECT employee_id
    FROM cumulative_salary_CTE 
    WHERE experience='Junior' AND 
            cumulative_salary<=(
                SELECT 70000-IFNULL(MAX(cumulative_salary), 0)
                FROM cumulative_salary_CTE
                WHERE cumulative_salary<=70000 
                        AND experience='Senior')
)
SELECT *
    FROM Senior_CTE 
UNION ALL 
SELECT *
    FROM Junior_CTE;