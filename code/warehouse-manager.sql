-- 1571. Warehouse Manager
WITH CTE1 AS(
    SELECT product_id, Width*Length*Height AS volume
    FROM Products
), CTE2 AS(
    SELECT Warehouse.name, 
           Warehouse.units * CTE1.volume AS total_volume
    FROM Warehouse 
        JOIN CTE1 ON CTE1.product_id=Warehouse.product_id
)
SELECT name AS warehouse_name, SUM(total_volume) AS volume 
FROM CTE2
GROUP BY name;