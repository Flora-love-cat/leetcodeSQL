-- 1098. Unpopular Books
-- Note ON and WHERE clauses in the LEFT JOIN
SELECT b.book_id, b.name
FROM Books b  
    LEFT JOIN Orders o ON o.book_id = b.book_id AND o.dispatch_date >= '2019-06-23' - INTERVAL 1 YEAR
WHERE b.available_from < '2019-06-23' - INTERVAL 1 MONTH
GROUP BY b.book_id
HAVING ifnull(sum(o.quantity), 0) < 10;