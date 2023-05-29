-- 1158. Market Analysis I
SELECT u.user_id AS buyer_id, u.join_date, 
       COUNT(o.order_id) AS orders_in_2019
FROM Users u 
    LEFT JOIN Orders o ON u.user_id=o.buyer_id AND YEAR(o.order_date)='2019'
-- WHERE YEAR(o.order_date)='2019' -- this line is incorrect, SELECT will only return those users who have orders in 2019
-- but the question asks for all users so we need to use LEFT JOIN ON YEAR(o.order_date)='2019'
GROUP BY u.user_id;
