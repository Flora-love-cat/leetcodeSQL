-- 1651. Hopper Company Queries III
WITH RECURSIVE t(month) AS (
    SELECT 1 
    UNION
    SELECT month+1
        FROM t
        WHERE month<12
),
CTE2 AS (
    SELECT MONTH(requested_at) AS month, 
          SUM(ar.ride_distance) AS ride_distance,
          SUM(ar.ride_duration) AS ride_duration
    FROM Rides r
        JOIN Acceptedrides ar USING(ride_id)
    WHERE YEAR(requested_at)=2020
    GROUP BY 1
), CTE3 AS (
    SELECT t.month, 
        ROUND(AVG(IFNULL(CTE2.ride_distance, 0)) OVER(ORDER BY t.month ASC ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING), 2) AS average_ride_distance, 
        ROUND(AVG(IFNULL(CTE2.ride_duration, 0)) OVER(ORDER BY t.month ASC ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING), 2) AS average_ride_duration
    FROM t 
        LEFT JOIN CTE2 USING(month)
)
SELECT *
FROM CTE3
WHERE month <=10;