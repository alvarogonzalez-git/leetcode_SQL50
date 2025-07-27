# Write your MySQL query statement below
select
    employee_id
    , department_id
from Employee
where (employee_id, primary_flag) in (
    select employee_id,
           MAX(primary_flag)
    from Employee
    group by employee_id
);