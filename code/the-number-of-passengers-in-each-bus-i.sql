-- 2142. The Number of Passengers in Each Bus I
WITH CTE AS (
    SELECT p.passenger_id, MIN(b.arrival_time) AS arrival_time 
    FROM Passengers p 
        JOIN Buses b ON p.arrival_time <= b.arrival_time
    GROUP BY passenger_id
)
SELECT b.bus_id, COUNT(c.passenger_id) AS passengers_cnt 
FROM Buses b
    LEFT JOIN CTE c USING(arrival_time)
GROUP BY b.bus_id
ORDER BY b.bus_id ASC;