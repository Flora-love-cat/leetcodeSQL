-- 569. Median Employee Salary

-- solution1: median is the count/2 or count/2+1 th number
WITH CTE AS(
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY Company ORDER BY Salary) AS rk,  
        COUNT(1) OVER (PARTITION BY Company) AS ct 
    FROM Employee 
)
SELECT id, company, salary
FROM CTE 
WHERE rk BETWEEN ct/2 AND ct/2 + 1;

