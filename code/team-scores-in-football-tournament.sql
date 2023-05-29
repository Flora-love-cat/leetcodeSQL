-- 1212. Team Scores in Football Tournament
WITH CTE AS(
    SELECT host_team AS team_id,
            CASE WHEN host_goals>guest_goals THEN 3
                WHEN host_goals=guest_goals THEN 1
                ELSE 0
            END AS num_points
        FROM Matches
    UNION ALL 
        SELECT guest_team,
            CASE WHEN host_goals<guest_goals THEN 3
                WHEN host_goals=guest_goals THEN 1
                ELSE 0
            END AS num_points
    FROM Matches
)

SELECT t.team_id, t.team_name, IFNULL(SUM(c.num_points), 0) AS num_points
FROM Teams t 
    LEFT JOIN CTE c ON t.team_id=c.team_id
GROUP BY t.team_id
ORDER BY num_points DESC, t.team_id ASC;