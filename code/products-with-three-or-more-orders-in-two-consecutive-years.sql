-- 2292. Products With Three or More Orders in Two Consecutive Years
WITH CTE AS(
    SELECT product_id, YEAR(purchase_date) AS yr 
    FROM Orders
    GROUP BY product_id, YEAR(purchase_date)
    HAVING COUNT(*) >=3
), CTE2 AS (
    SELECT product_id, 
            yr-ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY yr ASC) AS diff
    FROM CTE
)
SELECT DISTINCT product_id
FROM CTE2 
GROUP BY product_id, diff 
HAVING COUNT(diff)>=2;