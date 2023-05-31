-- 1479. Sales by Day of the Week
SELECT i.item_category AS category, 
       SUM(IF(DAYNAME(o.order_date)='Monday', quantity, 0)) AS Monday,    
       SUM(IF(DAYNAME(o.order_date)='Tuesday', quantity, 0))  AS Tuesday,
       SUM(IF(DAYNAME(o.order_date)='Wednesday', quantity, 0)) AS Wednesday,
       SUM(IF(DAYNAME(o.order_date)='Thursday', quantity, 0)) AS Thursday,
       SUM(IF(DAYNAME(o.order_date)='Friday', quantity, 0)) AS Friday,
       SUM(IF(DAYNAME(o.order_date)='Saturday', quantity, 0)) AS Saturday,
       SUM(IF(DAYNAME(o.order_date)='Sunday', quantity, 0)) AS Sunday
FROM Items i  
    LEFT JOIN Orders o USING(item_id)
GROUP BY i.item_category
ORDER BY category ASC;