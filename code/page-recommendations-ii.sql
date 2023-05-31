-- 1892. Page Recommendations II




-- solution1: WHERE NOT EXISTS, efficient for small outer table and large inner table
WITH cte AS(
    SELECT user1_id AS user_id, user2_id AS friend_id
        FROM Friendship
    UNION ALL 
    SELECT user2_id AS user_id, user1_id AS friend_id
        FROM Friendship
)

SELECT c.user_id, l.page_id, COUNT(*) AS friends_likes
FROM cte c 
    JOIN Likes l ON l.user_id=c.friend_id
WHERE NOT EXISTS (
    SELECT *
    FROM Likes
    WHERE user_id=c.user_id AND page_id=l.page_id
)
GROUP BY c.user_id, l.page_id




-- execeed time limit: WHERE NOT IN, inefficient for small outer table and large inner table
WITH cte AS(
    SELECT user1_id AS user_id, user2_id AS friend_id
        FROM Friendship
    UNION ALL 
    SELECT user2_id AS user_id, user1_id AS friend_id
        FROM Friendship
)

SELECT c.user_id, l.page_id, COUNT(*) AS friends_likes
FROM cte c 
    JOIN Likes l ON l.user_id=c.friend_id
WHERE (c.user_id, l.page_id) NOT IN(
                                SELECT user_id, page_id 
                                FROM Likes )
GROUP BY c.user_id, l.page_id


-- solution2: 2 LEFT JOIN
--  Use table t left join table Likes l2 on t.user_id = l2.user_id and l1.page_id = l2.page_id to get the page_ids liked by both user and their friends
--  l2.page_id is null means that the selected page_ids are not already liked by the user, so it can be recommended 

WITH t AS (
    SELECT user1_id AS user_id, user2_id AS friend_id 
    FROM Friendship
    UNION ALL
    SELECT user2_id, user1_id
    FROM Friendship
)
SELECT DISTINCT t.user_id, l1.page_id, COUNT(l1.user_id) AS friends_likes
FROM t 
    LEFT JOIN Likes l1 ON l1.user_id = t.friend_id
    LEFT JOIN Likes l2 ON l2.user_id = t.user_id AND l2.page_id = l1.page_id
WHERE l2.page_id IS NULL
GROUP BY 1, 2;