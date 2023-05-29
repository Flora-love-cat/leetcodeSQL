-- 1241. Number of Comments per Post
WITH post_cte AS (
    SELECT DISTINCT sub_id
    FROM Submissions
    WHERE parent_id IS NULL
), comment_cte AS (
    SELECT parent_id, COUNT(DISTINCT sub_id) AS ct 
    FROM Submissions
    WHERE parent_id IS NOT NULL
    GROUP BY parent_id
)
SELECT p.sub_id AS post_id, IFNULL(c.ct, 0) AS number_of_comments
FROM post_cte p 
    LEFT JOIN comment_cte c ON p.sub_id=c.parent_id
ORDER BY post_id ASC;