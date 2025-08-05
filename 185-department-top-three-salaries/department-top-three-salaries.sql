# Write your MySQL query statement below
-- Need to create a table with salaries and department ids desc with row numbers
with dep_salaries as(
    select
        distinct salary as salary
        , departmentId
        , row_number() over(
            partition by departmentId
            order by departmentId asc, salary desc
        ) as rn
    from Employee
    group by salary, departmentId
    order by departmentId asc, salary desc
)

-- Then create a table to filter to top 3 per department
, top_three as(
    select
        salary
        , departmentId
    from dep_salaries
    where rn < 4
)

-- Then join to employee table on both department id and salary.
select
    d.name as Department
    , e.name as Employee
    , e.salary as Salary
from Employee e
inner join top_three as tt
    on e.salary = tt.salary
    and e.departmentId = tt.departmentId
inner join Department as d
    on e.departmentId = d.id