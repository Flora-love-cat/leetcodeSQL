-- 601. Human Traffic of Stadium
/*

Stadium table:
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 1    | 2017-01-01 | 10        |
| 2    | 2017-01-02 | 109       |
| 3    | 2017-01-03 | 150       |
| 4    | 2017-01-04 | 99        |
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+

*/

WITH t1 AS(
    SELECT *, id - row_number() OVER(ORDER BY id) AS rk
    FROM stadium
    WHERE people >= 100
), t2 AS(
    SELECT rk  
    FROM t1
    GROUP BY rk
    HAVING count(rk) >= 3
)

SELECT id, visit_date, people
FROM t1 
WHERE rk IN (SELECT * FROM t2);