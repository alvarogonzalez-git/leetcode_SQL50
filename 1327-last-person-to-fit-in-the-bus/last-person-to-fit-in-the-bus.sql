# Write your MySQL query statement below
with cte as(
    select
        person_name
        , weight
        , turn
        , sum(weight) OVER (ORDER BY turn) AS running_total
    from Queue
)

select
    person_name
from cte
where running_total <= 1000
order by turn desc
limit 1
