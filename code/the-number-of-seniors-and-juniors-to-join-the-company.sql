-- 2004. The Number of Seniors and Juniors to Join the Company
WITH cumulative_salary_cte AS(
    SELECT employee_id, experience,
            SUM(salary) OVER(PARTITION BY experience ORDER BY salary, employee_id) AS cumulative_salary
    FROM Candidates
), senior_cte AS(
    SELECT 'Senior' AS experience, 
        SUM(cumulative_salary<=70000) AS accepted_candidates
    FROM cumulative_salary_cte
    WHERE experience='Senior'
), junior_cte AS(
    SELECT 'Junior' AS experience, 
        SUM(cumulative_salary<=(
                SELECT 70000-IFNULL(MAX(cumulative_salary), 0)
                FROM CTE1
                WHERE cumulative_salary<=70000 AND experience='Senior')
             ) AS accepted_candidates
    FROM cumulative_salary_cte
    WHERE experience='Junior'
)
SELECT *
    FROM senior_cte 
UNION ALL 
SELECT *
    FROM junior_cte;