-- 1949. Strong Friendship
WITH t AS (
  SELECT user1_id AS user_id, user2_id AS friend_id
  FROM friendship
  UNION 
  SELECT user2_id, user1_id 
  FROM friendship
)
-- Find all pairs of users that have at least three common friends
SELECT t1.user_id AS user1_id,
       t2.user_id AS user2_id,
       COUNT(DISTINCT t1.friend_id) AS common_friend 
FROM t AS t1
    INNER JOIN t AS t2 ON t1.friend_id = t2.friend_id AND t1.user_id < t2.user_id
-- Filter out pairs of users that are not friends
WHERE (t1.user_id, t2.user_id) IN (SELECT * FROM t)
GROUP BY user1_id, user2_id
HAVING COUNT(DISTINCT t1.friend_id) >= 3;