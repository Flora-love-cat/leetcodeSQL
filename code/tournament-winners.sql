-- 1194. Tournament Winners

-- solution1: SUM(), IF(), JOIN
WITH CTE AS (
    select players.*, 
            sum(if(player_id = first_player, first_score, second_score)) AS total_score
    from players 
        inner join matches on player_id IN(first_player,   second_player)
    group by player_id 
), CTE2 AS(
    SELECT p.player_id, p.group_id,
            ROW_NUMBER() OVER(PARTITION BY p.group_id ORDER BY c.total_score DESC, p.player_id ASC) AS rk 
    FROM Players p 
        LEFT JOIN CTE c USING(player_id)
)
SELECT group_id, player_id
FROM CTE2 
WHERE rk=1;


-- solution2: UNION ALL
WITH CTE AS(
    SELECT first_player AS player_id, first_score AS score
        FROM Matches
    UNION ALL
    SELECT second_player, second_score
        FROM Matches
), CTE2 AS(
    SELECT player_id, SUM(score) AS total_score
    FROM CTE 
    GROUP BY player_id
), CTE3 AS(
    SELECT p.player_id, p.group_id,
            ROW_NUMBER() OVER(PARTITION BY p.group_id ORDER BY c.total_score DESC, p.player_id ASC) AS rk 
    FROM Players p 
        LEFT JOIN CTE2 c USING(player_id)
)
SELECT group_id, player_id
FROM CTE3 
WHERE rk=1;