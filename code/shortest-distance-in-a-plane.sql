-- 612. Shortest Distance in a Plane
-- condition can be a list compare to a list 
SELECT ROUND(MIN(SQRT(POWER(p1.x-p2.x, 2)+POWER(p1.y-p2.y, 2))), 2) AS shortest
FROM Point2D p1, Point2D p2 
WHERE (p1.x, p1.y)<>(p2.x, p2.y);