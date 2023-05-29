-- 2228. Users With Two Purchases Within Seven Days
WITH CTE AS(
    SELECT user_id, DATEDIFF(LEAD(purchase_date, 1) OVER(PARTITION BY user_id ORDER BY purchase_date ASC), purchase_date) AS diff
    FROM Purchases
)
SELECT DISTINCT user_id
FROM CTE 
WHERE diff <= 7
ORDER BY user_id;