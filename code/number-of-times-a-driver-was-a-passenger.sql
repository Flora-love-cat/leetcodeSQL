-- 2238. Number of Times a Driver Was a Passenger
WITH CTE AS (
    SELECT DISTINCT driver_id 
    FROM Rides
    )
SELECT c.driver_id, COUNT(r.passenger_id) AS cnt 
FROM CTE c
    LEFT JOIN Rides r ON c.driver_id=r.passenger_id
GROUP BY c.driver_id;