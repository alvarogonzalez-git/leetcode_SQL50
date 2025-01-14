# Write your MySQL query statement below
WITH Start AS(
    SELECT *
    FROM Activity
    WHERE activity_type = 'start'
)

, End AS(
    SELECT *
    FROM Activity
    WHERE activity_type = 'end'
)

SELECT 
    s.machine_id
    , ROUND(AVG(e.timestamp-s.timestamp),3) AS processing_time
FROM Start s
JOIN End e
    ON s.machine_id = e.machine_id
        AND s.process_id = e.process_id
GROUP BY machine_id