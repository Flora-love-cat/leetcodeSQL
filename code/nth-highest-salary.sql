/* 
177. Nth Highest Salary
report the nth highest salary from the Employee table. 
If there is no nth highest salary, the query should report null.
*/

-- solution1: DENSE_RANK() + CTE
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
    WITH CTE AS (
        SELECT Salary, 
                DENSE_RANK() OVER(ORDER BY Salary DESC) AS rk 
        FROM Employee
    )
    SELECT DISTINCT Salary 
    FROM CTE 
    WHERE rk=N 
  );
END

-- solution 2: DISTINCT + LIMIT 
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    SET N := N-1;
    RETURN (
        SELECT DISTINCT Salary 
        FROM Employee
        ORDER BY Salary DESC
        LIMIT 1 OFFSET N
    );
END