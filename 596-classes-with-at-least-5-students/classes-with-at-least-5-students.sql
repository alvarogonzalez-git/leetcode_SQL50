# Write your MySQL query statement below
with student_count as(
    select
        class
        , count(class) no_students
    from Courses
    group by class
    having no_students > 4
)

select
    class
from student_count