
-- 1070. Product Sales Analysis III
-- RANK() and DENSE_RANK() consider tie 1s, ROW_NUMBER() not 
WITH CTE AS (
    SELECT product_id, 
            RANK() OVER(PARTITION BY product_id ORDER BY year ASC) AS rk, year, 
            quantity, price 
    FROM Sales 
)
SELECT product_id, year AS first_year, quantity, price
FROM CTE 
WHERE rk=1;