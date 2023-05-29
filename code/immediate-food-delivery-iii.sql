-- 2686. Immediate Food Delivery III
SELECT order_date,
        ROUND(SUM(order_date=customer_pref_delivery_date)/COUNT(*)*100, 2) AS immediate_percentage
FROM Delivery
GROUP BY order_date
ORDER BY order_date;