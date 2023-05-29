-- 1841. League Statistics



-- solution1: UNION
WITH CTE1 AS(
    SELECT home_team_id AS team_id, 
            home_team_goals AS goal_for, 
            away_team_goals AS goal_against, 
            CASE WHEN home_team_goals>away_team_goals THEN 3
                 WHEN home_team_goals=away_team_goals THEN 1
                 ELSE 0
            END AS point
        FROM Matches
    UNION ALL   
    SELECT away_team_id, away_team_goals, home_team_goals,
            CASE WHEN home_team_goals<away_team_goals THEN 3
                 WHEN home_team_goals=away_team_goals THEN 1
                 ELSE 0
            END AS point
        FROM Matches
), CTE2 AS(
    SELECT team_id, SUM(point) AS points, SUM(goal_for) AS goal_for, SUM(goal_against) AS goal_against 
    FROM CTE1 
    GROUP BY team_id
), CTE3 AS(
    SELECT team_id, COUNT(*) AS matches_played
    FROM CTE1 
    GROUP BY team_id
)
SELECT t.team_name, c2.matches_played, c1.points, c1.goal_for, c1.goal_against, c1.goal_for-c1.goal_against AS goal_diff 
FROM Teams t 
    JOIN CTE2 c1 ON c1.team_id=t.team_id
    JOIN CTE3 c2 ON c2.team_id=t.team_id
ORDER BY c1.points DESC, goal_diff DESC, t.team_name ASC;


-- solution2: JOIN
SELECT team_name, COUNT(*) AS matches_played,
        SUM(
            CASE WHEN (team_id=home_team_id AND home_team_goals>away_team_goals) OR
                        (team_id=away_team_id AND home_team_goals<away_team_goals) THEN 3
                WHEN (team_id=home_team_id AND home_team_goals<away_team_goals) OR 
                        (team_id=away_team_id AND home_team_goals>away_team_goals) THEN 0 
                ELSE 1 
            END) AS points, 

        SUM(IF(team_id=home_team_id,home_team_goals,away_team_goals)) AS goal_for,
        SUM(IF(team_id=home_team_id,away_team_goals,home_team_goals)) AS goal_against,
        SUM(IF(team_id=home_team_id,home_team_goals,away_team_goals)) - SUM(IF(team_id=home_team_id,away_team_goals,home_team_goals)) AS goal_diff

FROM Teams 
    JOIN Matches ON team_id=home_team_id OR team_id=away_team_id
GROUP BY team_id
ORDER BY points DESC, goal_diff DESC, team_name ASC