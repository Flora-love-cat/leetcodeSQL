-- 1204. Last Person to Fit in the Bus
-- SUM() OVER(ORDER BY ): calculate cumulative sum of a column
WITH CTE AS (
    SELECT *, SUM(Weight) OVER(ORDER BY Turn ASC) AS Total_weight
    FROM Queue
)
SELECT person_name 
FROM CTE 
WHERE Total_weight <= 1000
ORDER BY Turn DESC
LIMIT 1;