-- 1364. Number of Trusted Contacts of a Customer
SELECT i.invoice_id, c.customer_name, i.price, 
        COUNT(c2.user_id) AS contacts_cnt, 
        IFNULL(SUM(c2.contact_name IN (SELECT customer_name FROM Customers)), 0) AS trusted_contacts_cnt
FROM Invoices i 
    LEFT JOIN Customers c ON c.customer_id=i.user_id
    LEFT JOIN Contacts c2 ON c2.user_id=i.user_id 
GROUP BY i.invoice_id
ORDER BY i.invoice_id ASC;