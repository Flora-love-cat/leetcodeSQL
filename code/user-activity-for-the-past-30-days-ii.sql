-- 1142. User Activity for the Past 30 Days II
WITH CTE AS(
    SELECT user_id, COUNT(DISTINCT session_id) AS ct
    FROM Activity
    WHERE DATEDIFF('2019-07-27', activity_date) < 30
    GROUP BY user_id
)
SELECT ROUND(IFNULL(AVG(ct), 0), 2) AS average_sessions_per_user
FROM CTE;