-- solution1: LAST_DAY() function return last day of the month of date argument 
WITH RECURSIVE cte1(dt) AS (
 SELECT '2020-01-31' AS 'dt'
 UNION ALL
 SELECT LAST_DAY(DATE_ADD(dt, INTERVAL 1 MONTH))
 FROM cte1
 WHERE dt < '2020-12-31'
), cte2 AS(
    SELECT MONTH(cte1.dt) AS 'month', 
        COUNT(d.driver_id) AS active_drivers
    FROM cte1
        LEFT JOIN Drivers d ON YEAR(d.join_date)<=2020 AND d.join_date<= cte1.dt  
    GROUP BY 1
), cte3 AS(
    SELECT MONTH(cte1.dt) AS 'month', 
        COUNT(r.ride_id) AS accepted_rides
    FROM cte1
        LEFT JOIN Rides r ON YEAR(r.requested_at)=2020 AND MONTH(r.requested_at)=MONTH(cte1.dt) 
                                AND r.ride_id IN (SELECT ride_id FROM AcceptedRides)
    GROUP BY1
)
SELECT month, active_drivers, accepted_rides
FROM cte2
    JOIN cte3 USING(month)
ORDER BY month ASC


-- solution2: IF(YEAR(join_date)<2020, 1, MONTH(join_date)) find active_drivers
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
          COUNT(*) AS accepted_rides
    FROM Rides r
        JOIN Acceptedrides ar USING(ride_id)
    WHERE YEAR(requested_at)=2020
    GROUP BY 1
)
SELECT DISTINCT n AS month, 
    IFNULL(SUM(active_drivers) OVER (ORDER BY n),0) AS active_drivers,
    IFNULL(accepted_rides,0) AS accepted_rides
FROM t 
    LEFT JOIN CTE2 ON t.n=CTE2.m
    LEFT JOIN CTE3 ON t.n=CTE3.m