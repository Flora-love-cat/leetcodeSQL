-- 182. Duplicate Emails
SELECT email
FROM Person
GROUP BY email 
HAVING COUNT(*) > 1;