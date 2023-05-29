-- 1321. Restaurant Growth

-- window function SUM() OVER() with RANGE
WITH CTE AS (
SELECT visited_on, 
        SUM(amount) OVER(ORDER BY visited_on RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW) AS amount
    FROM Customer
)
SELECT DISTINCT *, ROUND(amount/7, 2) AS average_amount
FROM CTE 
WHERE DATEDIFF(visited_on, (SELECT MIN(visited_on) FROM Customer)) >=6
ORDER BY visited_on ASC;

