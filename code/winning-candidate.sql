-- 574. Winning Candidate
SELECT c.name
FROM Vote v 
    JOIN Candidate c ON v.candidateId=c.id 
GROUP BY v.candidateId
ORDER BY COUNT(*) DESC
LIMIT 1;