# Write your MySQL query statement below

-- create a table with two null rows
with salaries as(
    select 
    distinct salary as salary
    from Employee
    union
    select 
        null as salary
    union all
    select 
        null as salary
)

-- create table with salaries rankes and indexed - table also has two null rows unioned
, ranked as(
    select 
    distinct salary as salary
    , row_number() over(
        order by salary desc
    ) as rn
    from salaries
)

-- create table with single value for SecondHighestSalary
select
    salary as SecondHighestSalary
from ranked
where rn = 2