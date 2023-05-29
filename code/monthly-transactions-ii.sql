-- 1205. Monthly Transactions II
-- UNION
WITH fullData AS (
    SELECT DATE_FORMAT(trans_date,'%Y-%m') AS month, country, state, amount
    FROM Transactions
    UNION ALL
    SELECT DATE_FORMAT(a.trans_date,'%Y-%m') AS month, b.country, 'chargeback' AS state, b.amount
    FROM Chargebacks a 
        JOIN Transactions b ON a.trans_id=b.id
)

SELECT month, country, 
    SUM(state='approved') AS approved_count,
    SUM(IF(state='approved',amount,0)) AS approved_amount,
    SUM(state='chargeback') AS chargeback_count,
    SUM(IF(state='chargeback',amount,0)) AS chargeback_amount
FROM fullData
GROUP BY month,country
HAVING approved_count<>0 OR chargeback_count<>0;