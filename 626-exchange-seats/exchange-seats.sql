# Write your MySQL query statement below
-- create table filtered to only return even number of rows to be exchanged
with exchange_list as(
    select
        *
    from Seat
    where case 
        when (select max(id) from Seat) % 2 = 0 then id <= (select count(*) from Seat)
        when (select max(id) from Seat) % 2 != 0 then id <= (select count(*) - 1 from Seat)
        end
    group by id
)

-- create table with even ids and subtract 1 from their ids. This changes their seat.
, even_to_odd as(
    select
        id - 1 as id
        , student
    from exchange_list
    where id % 2 = 0
)

-- create a table with odd ids and add 1 to their ids. This changes their seat.
, odd_to_even as(
    select
        id + 1 as id
        , student
    from exchange_list
    where id % 2 != 0
)

-- create a table with any spare rows from first table. students who were not exchanged
, spare as(
    select
        *
    from Seat
    where case 
        when (select max(id) from Seat) % 2 = 0 then id > (select count(*) from Seat)
        when (select max(id) from Seat) % 2 != 0 then id > (select count(*) - 1 from Seat)
        end
    group by id
)

-- union exchanged seats and non-exchanges seats
, combined as(
    select * from even_to_odd
    union
    select * from odd_to_even
    union
    select * from spare
)

-- return final table ordered by id
select
    *
from combined
order by id asc