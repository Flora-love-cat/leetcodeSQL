-- 2314. The First Day of the Maximum Recorded Degree in Each City
WITH CTE AS(
    SELECT *,
            ROW_NUMBER() OVER(PARTITION BY city_id ORDER BY degree DESC, day ASC) AS rk
    FROM Weather
)
SELECT city_id, day, degree 
FROM CTE 
WHERE rk=1
ORDER BY city_id ASC;