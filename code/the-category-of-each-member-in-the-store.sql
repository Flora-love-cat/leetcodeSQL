-- 2051. The Category of Each Member in the Store
WITH CTE AS(
    SELECT v.member_id,
            IFNULL(COUNT(p.charged_amount)/COUNT(v.visit_date)*100, 0) AS conv_rate
    FROM Visits v 
        LEFT JOIN Purchases p USING(visit_id)
    GROUP BY v.member_id
)
SELECT m.member_id, m.name,
        CASE WHEN c.conv_rate IS NULL THEN 'Bronze'
             WHEN c.conv_rate < 50 THEN 'Silver'
             WHEN c.conv_rate < 80 THEN 'Gold'
             ELSE 'Diamond'
        END AS category
FROM Members m
    LEFT JOIN CTE c USING(member_id);