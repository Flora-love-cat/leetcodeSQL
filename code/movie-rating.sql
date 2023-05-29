-- 1341. Movie Rating
WITH CTE1 AS(
    SELECT u.name, 
        ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC, u.name ASC) AS rk 
    FROM MovieRating m 
        JOIN Users u ON m.user_id=u.user_id
    GROUP BY m.user_id
), CTE2 AS(
    SELECT m.title, 
            ROW_NUMBER() OVER (ORDER BY AVG(mr.rating) DESC, m.title ASC) AS rk
    FROM MovieRating mr 
        JOIN Movies m ON mr.movie_id = m.movie_id
    WHERE DATE_FORMAT(mr.created_at, '%Y-%m') = '2020-02'
    GROUP BY mr.movie_id
)
SELECT name AS results
    FROM CTE1 
    WHERE rk=1 
UNION ALL
SELECT title
    FROM CTE2 
    WHERE rk=1;