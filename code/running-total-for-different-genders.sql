-- 1308. Running Total for Different Genders
SELECT gender, day, 
        SUM(score_points) OVER(PARTITION BY gender ORDER BY day ASC) AS total 
FROM Scores 
ORDER BY gender ASC, day ASC;