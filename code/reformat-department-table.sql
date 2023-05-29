-- 1179. Reformat Department Table
-- solution 1 CASE WHEN
SELECT id, 
        MIN(CASE WHEN month='Jan' THEN revenue END) AS Jan_Revenue,
        AVG(CASE WHEN month='Feb' THEN revenue  END) AS Feb_Revenue,
        MAX(CASE WHEN month='Mar' THEN revenue  END) AS Mar_Revenue,
        SUM(CASE WHEN month='Apr' THEN revenue  END) AS Apr_Revenue,
        SUM(CASE WHEN month='May' THEN revenue  END) AS May_Revenue,
        SUM(CASE WHEN month='Jun' THEN revenue  END) AS Jun_Revenue,
        SUM(CASE WHEN month='Jul' THEN revenue  END) AS Jul_Revenue,
        SUM(CASE WHEN month='Aug' THEN revenue  END) AS Aug_Revenue,
        SUM(CASE WHEN month='Sep' THEN revenue  END) AS Sep_Revenue,
        SUM(CASE WHEN month='Oct' THEN revenue  END) AS Oct_Revenue,
        SUM(CASE WHEN month='Nov' THEN revenue  END) AS Nov_Revenue,
        SUM(CASE WHEN month='Dec' THEN revenue  END) AS Dec_Revenue
FROM department
GROUP BY id
ORDER BY id;

-- solution 2 IF()
SELECT id,
        MIN(IF(month='Jan', revenue, NULL)) AS Jan_Revenue,
        AVG(IF(month='Feb', revenue, NULL)) AS Feb_Revenue,
        MAX(IF(month='Mar', revenue, NULL)) AS Mar_Revenue,
        SUM(IF(month='Apr', revenue, NULL)) AS Apr_Revenue,
        SUM(IF(month='May', revenue, NULL)) AS May_Revenue,
        SUM(IF(month='Jun', revenue, NULL)) AS Jun_Revenue,
        SUM(IF(month='Jul', revenue, NULL)) AS Jul_Revenue,
        SUM(IF(month='Aug', revenue, NULL)) AS Aug_Revenue,
        SUM(IF(month='Sep', revenue, NULL)) AS Sep_Revenue,
        SUM(IF(month='Oct', revenue, NULL)) AS Oct_Revenue,
        SUM(IF(month='Nov', revenue, NULL)) AS Nov_Revenue,
        SUM(IF(month='Dec', revenue, NULL)) AS Dec_Revenue
FROM department
GROUP BY id
ORDER BY id;
