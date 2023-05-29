-- 262. Trips and Users
SELECT t.request_at AS Day,
        ROUND(SUM(t.status<>'completed')/COUNT(t.status), 2)AS 'Cancellation Rate'
FROM Trips t 
    JOIN Users u1 ON t.driver_id = u1.users_id
    JOIN Users u2 ON t.client_id = u2.users_id
WHERE (t.request_at BETWEEN '2013-10-01' AND '2013-10-03') 
    AND u1.banned = 'No'
    AND u2.banned = 'No'

GROUP BY t.request_at;