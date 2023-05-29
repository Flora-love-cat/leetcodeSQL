-- 2377. Sort the Olympic Table
SELECT *
FROM Olympic
ORDER BY gold_medals DESC, silver_medals DESC, bronze_medals DESC, country ASC;