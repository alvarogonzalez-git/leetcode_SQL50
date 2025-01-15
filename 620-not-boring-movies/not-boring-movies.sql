# Write your MySQL query statement below
SELECT
    id
    , movie
    , description
    , rating
FROM Cinema c
WHERE (id % 2) <> 0
    AND c.description NOT LIKE '%boring%'
ORDER BY c.rating desc