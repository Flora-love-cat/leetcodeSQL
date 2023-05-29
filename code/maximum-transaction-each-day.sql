-- 1831. Maximum Transaction Each Day
WITH CTE AS(
    SELECT transaction_id,
            RANK() OVER(PARTITION BY DATE_FORMAT(day, '%Y-%m-%d') ORDER BY amount DESC) AS rk
    FROM Transactions
)
SELECT transaction_id
FROM CTE 
WHERE rk=1
ORDER BY transaction_id ASC;