-- 1164. Product Price at a Given Date
WITH CTE1 AS (
    SELECT DISTINCT product_id
    FROM Products
), CTE2 AS (
    SELECT product_id, new_price, 
            RANK() OVER(PARTITION BY product_id ORDER BY change_date DESC) AS rk
    FROM Products 
    WHERE change_date <= '2019-08-16'
)
SELECT CTE1.product_id, 
       IFNULL(CTE2.new_price, 10) AS price 
FROM CTE1
    LEFT JOIN CTE2 ON CTE1.product_id = CTE2.product_id AND CTE2.rk=1;