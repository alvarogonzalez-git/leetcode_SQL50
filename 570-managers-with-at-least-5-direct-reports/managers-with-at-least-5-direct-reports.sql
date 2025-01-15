# Write your MySQL query statement below
WITH cte AS(
    SELECT
        e1.id
        , e1.name
        , COUNT(e2.managerId) direct_reports
    FROM Employee e1
    JOIN Employee e2
        ON e1.id = e2.managerId
    GROUP BY 1,2
)

SELECT
    name
FROM cte
WHERE direct_reports >= 5