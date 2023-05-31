-- 1917. Leetcodify Friends Recommendations
WITH cte AS(
    SELECT user1_id AS user_id, user2_id AS friend_id
        FROM Friendship
    UNION ALL 
    SELECT user2_id AS user_id, user1_id AS friend_id
        FROM Friendship
)
SELECT DISTINCT l1.user_id AS user_id, l2.user_id AS recommended_id
FROM Listens l1 
    JOIN Listens l2 ON l1.song_id=l2.song_id AND l1.day=l2.day AND l1.user_id <> l2.user_id
WHERE NOT EXISTS (
    SELECT *
    FROM cte 
    WHERE user_id=l1.user_id AND friend_id=l2.user_id
)
GROUP BY l1.user_id, l1.day, l2.user_id
HAVING COUNT(DISTINCT l2.song_id) >=3
ORDER BY 1, 2