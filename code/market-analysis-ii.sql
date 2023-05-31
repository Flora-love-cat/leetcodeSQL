-- 1159. Market Analysis II
WITH CTE AS(
    SELECT seller_id, item_id,
            ROW_NUMBER() OVER(PARTITION BY seller_id ORDER BY order_date ASC) AS rk
    FROM Orders 
    ORDER BY seller_id, order_date
)
SELECT u.user_id AS seller_id, 
       IF(u.favorite_brand=i.item_brand, 'yes', 'no') AS 2nd_item_fav_brand
FROM Users u
    LEFT JOIN CTE c ON u.user_id=c.seller_id AND c.rk=2
    LEFT JOIN Items i USING(item_id)