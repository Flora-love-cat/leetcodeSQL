-- 1459. Rectangles Area
WITH CTE AS (
    SELECT p1.id AS 'P1', p2.id AS 'P2', 
   ABS(p1.x_value-p2.x_value)*ABS(p1.y_value-p2.y_value) AS AREA 
    FROM Points p1
        JOIN Points p2 ON p1.id < p2.id
    )
SELECT P1, P2, AREA 
FROM CTE 
WHERE AREA > 0
ORDER BY AREA desc, P1 ASC, P2 ASC;