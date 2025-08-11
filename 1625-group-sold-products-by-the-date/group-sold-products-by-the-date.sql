# Write your MySQL query statement below
select
    sell_date
    , count(distinct product) as num_sold -- counts number of distinct products per sell_date
    , group_concat(distinct product order by product separator ",") as products -- list the distinct products sold in lex. order
from Activities
group by sell_date
order by sell_date asc