-- 1549. The Most Recent Orders for Each Product
WITH CTE AS(
    SELECT product_id, order_id, order_date,
            RANK() OVER(PARTITION BY product_id ORDER BY order_date DESC) AS rk 
    FROM Orders 
)
SELECT p.product_name, c.product_id, c.order_id,c.order_date 
FROM CTE c
    JOIN Products p ON c.product_id=p.product_id
WHERE rk=1
ORDER BY p.product_name ASC, c.product_id ASC, c.order_id ASC;