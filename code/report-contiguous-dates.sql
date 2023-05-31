-- 1225. Report Contiguous Dates
WITH success_cte AS(
    SELECT success_date,
        SUBDATE(success_date, ROW_NUMBER() OVER(ORDER BY success_date ASC)) AS diff
    FROM Succeeded
    WHERE success_date BETWEEN '2019-01-01' AND '2019-12-31'
), fail_cte AS(
    SELECT fail_date,
        SUBDATE(fail_date, ROW_NUMBER() OVER(ORDER BY fail_date ASC)) AS diff
    FROM Failed
    WHERE fail_date BETWEEN '2019-01-01' AND '2019-12-31'
), success_cte2 AS(
    SELECT MIN(success_date) AS start_date, 
            MAX(success_date) AS end_date
    FROM success_cte
    GROUP BY diff 
), fail_cte2 AS(
    SELECT MIN(fail_date) AS start_date, 
            MAX(fail_date) AS end_date
    FROM fail_cte
    GROUP BY diff 
), CTE AS(
    SELECT *, 'succeeded' AS period_state
        FROM success_cte2
    UNION ALL 
    SELECT *, 'failed' AS period_state
        FROM fail_cte2
)
SELECT period_state, start_date, end_date
FROM CTE 
ORDER BY start_date, end_date