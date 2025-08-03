# Write your MySQL query statement below

-- create table to return id counts in requester_id column
with req_count as(
    select
        requester_id as id
        , count(accepter_id) as num
    from RequestAccepted
    group by requester_id
)

-- create table to return id counts in accepter_id column
, acc_count as(
    select
        accepter_id as id
        , count(requester_id) as num
    from RequestAccepted
    group by accepter_id
)

-- union req_count and acc_count to create table with all ids and counts. To be aggregated in main query
, all_count as(
    select
        *
    from req_count
    union all
    select
        *
    from acc_count
)

-- final query. all_count aggregated to return each id and num of friends. order by num and limit to 1 to get top.
select
    id
    , sum(num) as num
from all_count
group by id
order by num desc
limit 1