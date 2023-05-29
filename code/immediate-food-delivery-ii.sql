-- 1174. Immediate Food Delivery II
WITH CTE1 AS(
    SELECT customer_id, order_date, customer_pref_delivery_date
            , RANK() OVER(PARTITION BY customer_id ORDER BY order_date ASC) AS rk
    FROM Delivery
), CTE2 AS (
    SELECT customer_id, order_date, customer_pref_delivery_date
    FROM CTE1 
    WHERE rk=1
)
SELECT ROUND(SUM(order_date=customer_pref_delivery_date)/COUNT(*)*100, 2) AS immediate_percentage
FROM CTE2;