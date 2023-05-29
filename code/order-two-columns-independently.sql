-- 2159. Order Two Columns Independently
WITH CTE1 AS(
    SELECT first_col, ROW_NUMBER() OVER(ORDER BY first_col ASC) AS row_id 
    FROM Data
), CTE2 AS(
    SELECT second_col, ROW_NUMBER() OVER(ORDER BY second_col DESC) AS row_id 
    FROM Data
)
SELECT c1.first_col, c2.second_col
FROM CTE1 c1 
    JOIN CTE2 c2 USING(row_id)