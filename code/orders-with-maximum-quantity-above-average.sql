-- 1867. Orders With Maximum Quantity Above Average
WITH CTE1 AS(
    SELECT order_id, SUM(quantity)/COUNT(DISTINCT product_id) AS avg_quantity, MAX(quantity) AS max_quantity
    FROM OrdersDetails
    GROUP BY order_id
)
SELECT order_id
FROM CTE1 
WHERE max_quantity > ALL(SELECT avg_quantity FROM CTE1);