# Write your MySQL query statement below
with cte as(
    select
        id
        ,num
        , CASE
                WHEN num = LAG(num) OVER(ORDER BY id)
                    AND num = LEAD(num) OVER(ORDER BY id)
                    THEN 1
                    ELSE 0
            END as ConsecNums
    from Logs
    group by id
)

select
    num as ConsecutiveNums
from cte
where ConsecNums >= 1
group by num