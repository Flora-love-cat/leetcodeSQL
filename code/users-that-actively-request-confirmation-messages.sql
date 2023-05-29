-- 1939. Users That Actively Request Confirmation Messages
WITH CTE AS(
    SELECT user_id,
            COUNT(*) OVER(PARTITION BY user_id ORDER BY time_stamp ASC RANGE BETWEEN CURRENT ROW AND INTERVAL 24 HOUR FOLLOWING) AS ct
    FROM Confirmations
)
SELECT DISTINCT user_id
FROM CTE 
WHERE ct=2;