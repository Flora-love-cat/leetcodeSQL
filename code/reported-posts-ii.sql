-- 1132. Reported Posts II

-- use DISTINCT in CTE bc Actions table doesn't have PK, it may have duplicate rows.
WITH CTE AS(
    SELECT DISTINCT action_date, post_id
    FROM Actions 
    WHERE extra='spam'
), CTE2 AS(
    SELECT c.action_date, IFNULL(COUNT(r.post_id)/COUNT(c.post_id)*100, 0) AS daily_percent
    FROM CTE c 
        LEFT JOIN Removals r ON r.post_id=c.post_id
    GROUP BY c.action_date
)
SELECT ROUND(AVG(daily_percent), 2) AS average_daily_percent
FROM CTE2;