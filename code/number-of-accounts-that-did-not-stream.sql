
-- 2020. Number of Accounts That Did Not Stream
-- NOT IN
SELECT COUNT(account_id) AS accounts_count
FROM Subscriptions
WHERE (2021 BETWEEN YEAR(start_date) AND YEAR(end_date)) 
    AND account_id NOT IN (
        SELECT account_id
        FROM Streams 
        WHERE YEAR(stream_date)=2021
    );

-- correlated subquery with NOT EXISTS
SELECT COUNT(account_id) AS accounts_count
FROM Subscriptions
WHERE 2021 BETWEEN YEAR(start_date) AND YEAR(end_date)
    AND NOT EXISTS (
        SELECT 1
        FROM Streams 
        WHERE YEAR(stream_date)=2021 AND Streams.account_id = Subscriptions.account_id
        );