-- 2112. The Airport With the Most Traffic
WITH CTE1 AS(
    SELECT departure_airport AS airport_id, flights_count
        FROM Flights 
    UNION ALL
    SELECT arrival_airport AS airport_id, flights_count
        FROM Flights
), CTE2 AS(
    SELECT airport_id, 
            RANK() OVER(ORDER BY SUM(flights_count) DESC) AS rk 
    FROM CTE1
    GROUP BY airport_id
)
SELECT airport_id
FROM CTE2 
WHERE rk=1;