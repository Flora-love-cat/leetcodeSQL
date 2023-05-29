-- 2298. Tasks Count in the Weekend
SELECT SUM(weekday(submit_date) IN (5, 6)) AS weekend_cnt,
        SUM(weekday(submit_date) BETWEEN 0 AND 4) AS working_cnt
FROM Tasks;