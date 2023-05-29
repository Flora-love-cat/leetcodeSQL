-- 1677. Product's Worth Over Invoices
WITH CTE AS(
    SELECT product_id, SUM(rest) AS rest, 
            SUM(paid) AS paid, SUM(canceled) AS canceled,
            SUM(refunded) AS refunded
    FROM Invoice
    GROUP BY product_id
)
SELECT Product.name, IFNULL(CTE.rest, 0) AS rest, IFNULL(CTE.paid, 0) AS paid, IFNULL(CTE.canceled, 0) AS canceled, IFNULL(CTE.refunded, 0) AS refunded
FROM Product
    LEFT JOIN CTE ON Product.product_id=CTE.product_id
ORDER BY Product.name ASC;