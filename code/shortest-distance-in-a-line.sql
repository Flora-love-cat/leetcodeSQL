-- 613. Shortest Distance in a Line
-- solution1: LEAD() OVER(ORDER BY x)
WITH CTE AS (
	SELECT LEAD(x) OVER(ORDER BY x) - x AS distance 
    FROM point
)
SELECT MIN(distance) AS shortest 
FROM t;

-- solution2: INNER JOIN ON p1.x <> p2.x
SELECT MIN(ABS(p1.x-p2.x)) AS shortest
FROM Point p1
    JOIN Point p2 ON p1.x <> p2.x;

-- solution3: CROSS JOIN
SELECT MIN(ABS(p1.x-p2.x)) AS shortest
FROM Point p1, Point p2
WHERE p1.x <> p2.x;