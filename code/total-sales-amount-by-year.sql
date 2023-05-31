-- 1384. Total Sales Amount by Year
-- solution1: yearly recursive CTE 
-- This recursive CTE generates a sequence of years from min year to max year in the Sales table, e.g., 2018, 2019, 2020
WITH RECURSIVE t1 AS (
    SELECT product_id, MIN(YEAR(period_start)) AS yr 
        FROM Sales 
        GROUP BY product_id
    UNION ALL
    SELECT product_id, yr + 1 
        FROM t1 
        WHERE yr < (SELECT MAX(YEAR(period_end)) FROM Sales)
),
-- This CTE generates first and last day of each year in CTE t1, e.g., 2018-01-01, 2018-12-31, 2019-01-01, 2019-12-31, ...
t2 AS (
    SELECT product_id, CONCAT(yr, '-01-01') AS dt 
        FROM t1
    UNION ALL
    SELECT product_id, CONCAT(yr, '-12-31') AS dt 
        FROM t1
    UNION ALL 
    SELECT product_id, period_start AS dt 
        FROM Sales
    UNION ALL 
    SELECT product_id, period_end AS dt 
        FROM Sales
),
-- join corresponding first and last day of each year to Sales table
t3 AS (
    SELECT
        s1.product_id,
        s1.average_daily_sales AS sale,
        t2.dt
    FROM Sales s1   
    JOIN t2 ON s1.product_id = t2.product_id 
            AND t2.dt BETWEEN s1.period_start AND s1.period_end
)
-- calculate yearly sales amount using formula (last_day - first_day + 1) * average_daily_sales
SELECT
    t3.product_id,
    p1.product_name,
    DATE_FORMAT(dt, "%Y") AS report_year,
    (DATEDIFF(MAX(dt), MIN(dt)) + 1) * sale AS total_amount
FROM t3
    JOIN Product p1 USING(product_id)
GROUP BY t3.product_id, p1.product_name, report_year
ORDER BY t3.product_id, report_year;






-- solution2: daily recursive CTE

-- This recursive CTE generates a sequence of numbers from 0 to the maximum period days in the Sales table
WITH RECURSIVE day_diff(day_period) AS (
    SELECT 0 AS day_period
    UNION ALL
    SELECT day_period + 1
        FROM day_diff
    WHERE day_period < (SELECT MAX(DATEDIFF(period_end, period_start)) FROM Sales)
)

-- This SELECT statement calculates the total sales amount for each item for each year
SELECT
    t1.product_id,
    t3.product_name,
    DATE_FORMAT(ADDDATE(t1.period_start, t2.day_period), '%Y') AS report_year,
    SUM(t1.average_daily_sales) AS total_amount
FROM Sales AS t1
    INNER JOIN day_diff AS t2 ON DATEDIFF(t1.period_end, t1.period_start) >= t2.day_period -- Join the Sales table with the day_diff CTE to generate all possible dates between period_start and period_end for each row in the Sales table
    INNER JOIN Product AS t3 ON t1.product_id = t3.product_id 
GROUP BY t1.product_id, t3.product_name, report_year
ORDER BY t1.product_id, report_year; 