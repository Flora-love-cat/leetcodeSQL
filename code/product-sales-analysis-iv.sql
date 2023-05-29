-- 2324. Product Sales Analysis IV
WITH CTE AS(
    SELECT s.user_id, s.product_id, 
            RANK() OVER(PARTITION BY s.user_id ORDER BY SUM(s.quantity*p.price) DESC) AS rk 
    FROM Sales s
        JOIN Product p USING(product_id)
    GROUP BY s.user_id, s.product_id
)
SELECT user_id, product_id
FROM CTE 
WHERE rk=1;