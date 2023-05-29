-- 1107. New Users Daily Count
WITH CTE AS(
    SELECT user_id, MIN(activity_date) AS login_date 
    FROM Traffic
    WHERE activity='login'
    GROUP BY user_id
    HAVING datediff('2019-06-30',login_date)<=90
)
SELECT login_date, COUNT(user_id) AS user_count
FROM CTE 
GROUP BY login_date;