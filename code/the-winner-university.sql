-- 2072. The Winner University
WITH NY_CTE AS(
    SELECT COUNT(student_id) AS ct 
    FROM NewYork
    WHERE score >= 90
), CA_CTE AS(
    SELECT COUNT(student_id) AS ct 
    FROM California 
    WHERE score >= 90
)
SELECT CASE WHEN (SELECT ct FROM NY_CTE) > (SELECT ct FROM CA_CTE) THEN 'New York University'
            WHEN (SELECT ct FROM NY_CTE) < (SELECT ct FROM CA_CTE) THEN 'California University'
            ELSE 'No Winner'
        END AS winner;