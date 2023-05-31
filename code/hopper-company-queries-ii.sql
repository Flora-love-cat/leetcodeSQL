-- 1645. Hopper Company Queries II

WITH RECURSIVE t(n) AS (
    SELECT 1 
    UNION
    SELECT n+1
        FROM t
        WHERE n<12
),
CTE2 AS (
    SELECT IF(YEAR(join_date)<2020, 1, MONTH(join_date)) AS m, 
            COUNT(*) AS active_drivers
    FROM Drivers
    WHERE YEAR(join_date)<=2020
    GROUP BY 1
),
CTE3 AS (
    SELECT MONTH(requested_at) AS m, 
          COUNT(DISTINCT ar.driver_id) AS accepted_drivers
    FROM Rides r
        JOIN Acceptedrides ar USING(ride_id)
    WHERE YEAR(requested_at)=2020
    GROUP BY 1
)
SELECT DISTINCT n AS month, 
    ROUND(IFNULL(accepted_drivers/(SUM(active_drivers) OVER (ORDER BY n))*100, 0), 2) AS working_percentage
    
FROM t 
    LEFT JOIN CTE2 ON t.n=CTE2.m
    LEFT JOIN CTE3 ON t.n=CTE3.m