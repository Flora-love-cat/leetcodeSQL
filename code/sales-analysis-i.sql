-- 1082. Sales Analysis I
WITH CTE1 AS (
    SELECT seller_id, 
            RANK() OVER(ORDER BY SUM(price) DESC) AS rk
    FROM Sales  
    GROUP BY seller_id
)
SELECT seller_id
FROM CTE1 
WHERE rk=1;