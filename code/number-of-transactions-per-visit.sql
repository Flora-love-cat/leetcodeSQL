-- 1336. Number of Transactions per Visit
-- distribution of the number of transactions per user per visit date.

WITH RECURSIVE CTE AS (
    SELECT v.user_id, v.visit_date, 
            COUNT(t.transaction_date) AS transactions_count
    FROM Visits v 
        LEFT JOIN Transactions t ON v.visit_date=t.transaction_date AND v.user_id=t.user_id
    GROUP BY v.user_id, v.visit_date
    ORDER BY v.user_id, v.visit_date
), CTE2(transactions_count) AS (
  SELECT 0
  UNION ALL
  SELECT transactions_count + 1
  FROM CTE2
  WHERE transactions_count < (SELECT MAX(transactions_count) FROM CTE)
)

SELECT transactions_count, COUNT(user_id) AS visits_count
FROM CTE2
    LEFT JOIN CTE USING(transactions_count) 
GROUP BY transactions_count
ORDER BY transactions_count