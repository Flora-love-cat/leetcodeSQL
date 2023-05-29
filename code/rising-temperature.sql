-- 197. Rising Temperature
WITH CTE AS(
    SELECT id, temperature AS curr_temp, recordDate AS curr_date,
        LAG(recordDate,1) OVER(ORDER BY recordDate ASC) AS last_date,
        LAG(temperature,1) OVER(ORDER BY recordDate ASC) AS last_temp
    FROM Weather
)
SELECT id
FROM CTE 
WHERE curr_temp > last_temp AND DATEDIFF(curr_date, last_date) = 1;