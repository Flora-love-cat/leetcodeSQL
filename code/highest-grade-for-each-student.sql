-- 1112. Highest Grade For Each Student
WITH CTE AS(
    SELECT *,
            ROW_NUMBER() OVER(PARTITION BY student_id ORDER BY grade DESC, course_id ASC) AS rk 
    FROM Enrollments
)
SELECT student_id, course_id, grade 
FROM CTE 
WHERE rk=1
ORDER BY student_id ASC;