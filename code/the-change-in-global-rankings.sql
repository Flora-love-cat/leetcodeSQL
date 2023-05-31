-- 2175. The Change in Global Rankings
-- BIGINT UNSIGNED data type can't represent negative integer, so use CAST() to convert datatype to SIGNED.
SELECT t.team_id, t.name, 
        CAST(ROW_NUMBER() OVER(ORDER BY t.points DESC, t.name ASC) AS SIGNED) - CAST(ROW_NUMBER() OVER(ORDER BY t.points+p.points_change DESC, t.name ASC) AS SIGNED) AS rank_diff
FROM TeamPoints t 
    LEFT JOIN PointsChange p USING(team_id);