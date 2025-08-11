# Write your MySQL query statement below
delete t1
from Person t1
join Person t2
  on t1.email = t2.email
  and t1.id > t2.id;