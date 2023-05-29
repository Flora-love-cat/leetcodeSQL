-- 1532. The Most Recent Three Orders
WITH CTE AS(
    SELECT customer_id, order_id, order_date,
            ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date DESC) AS rk 
    FROM Orders
)
SELECT c2.name AS customer_name, c1.customer_id, c1.order_id, c1.order_date
FROM CTE c1
    JOIN Customers c2 ON c2.customer_id=c1.customer_id
WHERE rk <=3
ORDER BY customer_name ASC, c1.customer_id ASC, c1.order_date DESC;