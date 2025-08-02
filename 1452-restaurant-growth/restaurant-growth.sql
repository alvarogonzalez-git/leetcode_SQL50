# Write your MySQL query statement below

-- returns table sum of amount per day. both moving sum and moving average ctes created from this table
with amounts_per_day as(
    select
        visited_on
        , sum(amount) as amount
    from Customer
    group by visited_on
    order by visited_on
)

-- returns dates with total amounts spent by customers
, moving_sum as(
    select
        visited_on
        , sum(amount) over(
            order by visited_on
            rows between 6 preceding and current row
        ) as amount -- moving sum
        , row_number() over(
            order by visited_on asc
        ) as day -- create day index
    from amounts_per_day
    group by visited_on
)


-- returns running averages with date index
, moving_average as(
    select
        visited_on
        , avg(amount) over(
                order by visited_on
                rows between 6 preceding and current row
        ) as average_amount -- moving average
        , row_number() over(
                order by visited_on asc
        ) as day -- create day index
    from amounts_per_day
    group by visited_on
    order by visited_on asc
)

-- -- Join moving_sum and moving_average per day. filter to 7th day so a full 7 values are taken into account for the moving sum and moving average
select
    ms.visited_on
    , ms.amount
    , round(average_amount, 2) as average_amount
from moving_sum as ms
inner join moving_average as ma
    on ms.visited_on = ma.visited_on
where ms.day > 6 -- filter to 7th day onwards