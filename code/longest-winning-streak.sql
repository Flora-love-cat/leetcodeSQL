-- 2173. Longest Winning Streak
-- can calculate Longest Winning/losing/drawing Streak
-- by ROW_NUMBER() OVER(PARTITION BY player_id, result ORDER BY match_day ASC)  PARTITION BY player_id, result
WITH CTE1 AS(
    SELECT player_id, result, 
            ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY match_day ASC)- ROW_NUMBER() OVER(PARTITION BY player_id, result ORDER BY match_day ASC) AS diff
    FROM Matches
), CTE2 AS(
    SELECT player_id, SUM(result='win') AS streak 
    FROM CTE1
    GROUP BY player_id, diff 
), CTE3 AS(
    SELECT DISTINCT player_id
    FROM Matches
)
SELECT CTE3.player_id, IFNULL(MAX(CTE2.streak), 0) AS longest_streak
FROM CTE3 
    LEFT JOIN CTE2 USING(player_id)
GROUP BY CTE3.player_id