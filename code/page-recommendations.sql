-- 1264. Page Recommendations
WITH user1_friend_CTE AS(
    SELECT IF(user1_id = 1, user2_id, user1_id) AS friend_id
    FROM friendship
    WHERE user1_id = 1 OR user2_id = 1
)
SELECT DISTINCT page_id AS recommended_page
FROM Likes
WHERE user_id IN (SELECT * FROM user1_friend_CTE) 
    AND page_id NOT IN (SELECT page_id
                        FROM Likes
                        WHERE user_id=1);