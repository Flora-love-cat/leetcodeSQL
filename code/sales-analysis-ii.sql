-- 1083. Sales Analysis II
WITH iPhone_CTE AS(
    SELECT s.buyer_id
    FROM Sales s 
        JOIN Product p ON p.product_id = s.product_id
    WHERE p.product_name = 'iPhone'
), S8_CTE AS(
    SELECT s.buyer_id
    FROM Sales s 
        JOIN Product p ON p.product_id = s.product_id
    WHERE p.product_name = 'S8'
)
SELECT DISTINCT buyer_id
FROM Sales 
WHERE buyer_id IN (SELECT * FROM S8_CTE) AND buyer_id NOT IN (SELECT * FROM iPhone_CTE);