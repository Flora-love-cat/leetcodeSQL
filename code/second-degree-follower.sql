-- 614. Second Degree Follower
SELECT followee AS follower, COUNT(follower) AS num
FROM Follow 
WHERE followee IN (
    SELECT follower
    FROM Follow
    GROUP BY follower
    HAVING COUNT(followee) >= 1
)
GROUP BY followee
HAVING COUNT(follower) >= 1
ORDER BY follower ASC;