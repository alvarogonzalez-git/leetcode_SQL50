# Write your MySQL query statement below
with cte as(
    select
        case
            when income < 20000 then "Low Salary"
            when income >= 20000 and income <= 50000 then "Average Salary"
            when income > 50000 then "High Salary"
        end as category
        , count(*) as accounts_count
    from Accounts
    group by category
)

, categories as (
    select "Low Salary" as category
    union
    select "Average Salary" as category
    union
    select "High Salary" as category
)

select
    cat.category
    , case
        when isnull(accounts_count) then 0
        else accounts_count
    end as accounts_count
from categories cat
left join cte
    on cat.category = cte.category