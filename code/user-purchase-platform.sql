-- 1127. User Purchase Platform
WITH CTE1(platform, sort_col) AS(
    VALUES ROW('desktop', 1),
            ROW('mobile', 2),
            ROW('both', 3)
), CTE2 AS(
    SELECT DISTINCT spend_date
    FROM Spending
),
CTE3 AS(
    SELECT spend_date, user_id, 
           SUM(amount) AS amount,
           IF(COUNT(platform)=2, 'both', platform) AS platform
    FROM Spending
    GROUP BY spend_date, user_id
)
SELECT c2.spend_date, c1.platform,
        IFNULL(SUM(amount), 0) AS total_amount,
        IFNULL(COUNT(c3.user_id), 0) AS total_users
FROM CTE1 c1
    CROSS JOIN CTE2 c2 
    LEFT JOIN CTE3 c3 ON c2.spend_date=c3.spend_date AND c1.platform=c3.platform
GROUP BY c2.spend_date, c1.platform
ORDER BY c2.spend_date, c1.sort_col