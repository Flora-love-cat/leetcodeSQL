
-- 1843. Suspicious Bank Accounts

-- PERIOD_ADD(date, number) for 'YYYY-MM' format date

-- Solution1: index difference
WITH CTE1 AS(
    SELECT account_id, DATE_FORMAT(day, '%Y%m') AS month,
            SUM(amount) AS total_income
    FROM Transactions
    WHERE type='Creditor'
    GROUP BY account_id, month
), CTE2 AS(
    SELECT c.account_id, 
            PERIOD_ADD(c.month, - ROW_NUMBER() OVER(PARTITION BY c.account_id ORDER BY c.month ASC)) AS diff
            
    FROM CTE1 c 
        JOIN Accounts a ON a.account_id=c.account_id
    WHERE c.total_income>a.max_income
)
SELECT DISTINCT account_id
FROM CTE2
GROUP BY account_id, diff
HAVING COUNT(diff) >=2;


-- solution2
WITH cte AS (
		SELECT account_id, DATE_FORMAT(day, '%Y%m') AS yearmonth
		FROM Transactions
			JOIN Accounts USING (account_id)
		WHERE type = 'Creditor'
		GROUP BY account_id, yearmonth
		HAVING SUM(amount) > AVG(max_income)
	)
SELECT DISTINCT account_id
FROM cte 
WHERE (account_id, PERIOD_ADD(yearmonth, 1)) IN (
	SELECT account_id, yearmonth
	FROM cte)





