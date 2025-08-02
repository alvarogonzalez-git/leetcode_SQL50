# Write your MySQL query statement below

-- create cte that returns a list of users with most reviews
with cte1 as(
    select
        mr.user_id
        , count(movie_id) as review_count
        , name
        , row_number() over (
            order by count(movie_id) desc, name asc
        ) as rn
    from MovieRating as mr
    inner join Users as u
        on u.user_id = mr.user_id
    group by user_id
    order by name
)

-- create cte that returns a list of movies with highest average rating
, cte2 as(
    select
        mr.movie_id
        , title
        , avg(rating) as avg_rating
        , month(created_at) as month_num
        , row_number() over (
                partition by month(created_at)
                order by avg(rating) desc, title asc
            ) as rn
    from (
        select
            *
        from MovieRating
        where month(created_at) = 2 and year(created_at) = 2020
    ) as mr
    inner join Movies mov
        on mr.movie_id = mov.movie_id
    group by movie_id
    order by title
)

-- union CTEs to create desired output - only unioning top values using rn=1
select
    name as results
from cte1 as c1
where rn = 1

union all

select
    title as results
from cte2 as c2
where month_num = 2 and rn = 1