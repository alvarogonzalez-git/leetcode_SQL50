# Write your MySQL query statement below
WITH Temp AS(
    SELECT *
    FROM Weather
    ORDER BY recordDate
)

SELECT 
    t1.id
FROM Temp t1
JOIN Temp t2
    ON t1.recordDate = DATE_ADD(t2.recordDate, INTERVAL 1 DAY)
WHERE t1.temperature > t2.temperature