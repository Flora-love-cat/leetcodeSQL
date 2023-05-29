-- 1699. Number of Calls Between Two Persons
SELECT 
    IF(from_id < to_id, from_id, to_id) AS person1,
    IF(from_id > to_id, from_id, to_id) AS person2,
    COUNT(*) call_count,
    SUM(duration) total_duration
FROM Calls
GROUP BY person1, person2;