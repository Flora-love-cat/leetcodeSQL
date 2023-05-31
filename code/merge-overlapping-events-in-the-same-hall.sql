-- Initialize temporary variables
WITH init AS (
 SELECT @g:=0, -- group id
        @e:=null, -- max end date
        @h:=null -- hall id
),
-- Select all rows from HallEvents and order by hall_id and start_day
hall AS (
 SELECT * 
 FROM HallEvents 
 ORDER BY hall_id, start_day
),
-- Calculate the group id for each row
t AS (
 SELECT
    hall_id, start_day, end_day,
    -- If the current hall id = previous hall id and the maximum end date >= current start day,
    -- keep the same group id. Otherwise, increment the group id.
    @g:=IF(@h=hall_id AND @e>=start_day, @g, @g+1) AS g,
    -- If the current hall id = previous hall id and the maximum end date >= current end date,
    -- keep the same maximum end date. Otherwise, update the maximum end date to the current end date.
    @e:=IF(@h=hall_id AND @e>=end_day, @e, end_day) AS e,
    -- Update the previous hall id to the current hall id
    @h:=hall_id
 FROM hall, init
)
-- Select the hall id, minimum start day, and maximum end day for each group
SELECT hall_id, MIN(start_day) AS start_day, MAX(end_day) AS end_day
FROM t
GROUP BY g
