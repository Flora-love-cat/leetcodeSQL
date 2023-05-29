-- 176. Second Highest Salary
-- key point: if second highest salary does not exist, return NULL
-- salary can be duplicate

-- solution 1: DISTINCT+ LIMIT + subquery
SELECT
    (SELECT DISTINCT Salary 
    FROM Employee
    ORDER BY Salary DESC
    LIMIT 1 OFFSET 1) AS SecondHighestSalary
;

-- solution 2: IFNULL() and subquery
SELECT
    IFNULL((SELECT DISTINCT Salary FROM Employee ORDER BY Salary DESC LIMIT 1 OFFSET 1),
            NULL
            ) AS SecondHighestSalary;


-- solution 3: MAX() and subquery
SELECT MAX(Salary) AS SecondHighestSalary 
FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee)