-- 1173. Immediate Food Delivery I
SELECT ROUND(SUM(order_date=customer_pref_delivery_date)/COUNT(*)*100, 2) AS immediate_percentage
FROM Delivery;