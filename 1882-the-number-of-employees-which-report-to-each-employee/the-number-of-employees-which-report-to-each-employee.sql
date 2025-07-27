# Write your MySQL query statement below

with managers as(
    select 
        reports_to as manager_id
        , count(employee_id) as reports_count
        , round(avg(age)) as average_age
    from Employees
    where reports_to is not null
    group by reports_to
)

select
    e.employee_id
    , e.name
    , m.reports_count
    , m.average_age
from Employees e
inner join managers m
on e.employee_id = m.manager_id
order by e.employee_id