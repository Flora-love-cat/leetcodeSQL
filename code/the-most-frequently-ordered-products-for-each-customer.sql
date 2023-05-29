-- 1596. The Most Frequently Ordered Products for Each Customer
WITH CTE AS(
    SELECT customer_id, product_id, 
            RANK() OVER(PARTITION BY customer_id ORDER BY COUNT(product_id) DESC) AS rk 
    FROM Orders
    GROUP BY customer_id, product_id
)
SELECT c.customer_id, c.product_id, p.product_name
FROM CTE c
    JOIN Products p ON p.product_id=c.product_id
WHERE rk=1;