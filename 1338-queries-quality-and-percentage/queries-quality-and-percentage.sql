# Write your MySQL query statement below
SELECT
    query_name
    , ROUND(AVG(rating/position),2) quality
    , ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) poor_query_percentage
FROM
    Queries q
GROUP BY query_name