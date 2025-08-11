# Write your MySQL query statement below
-- create cte with indexed product prices on or before "2019-08-16"
with cte as(
    select 
        product_id
        , new_price as price
        , row_number() over (
            partition by product_id 
            order by change_date desc
        ) as rn
    from (
        select
            *
        from Products
        where change_date <= "2019-08-16"
    ) as prices
)

-- create table with defaul price ids
, default_price as(
    select
        p.product_id
        , 10 as price
    from products as p 
    where p.product_id not in (
        select
            product_id
        from cte
    )
    group by product_id
)

-- create table with latest price before "2019-08-16" and union defaul price products
, cte2 as(
    select
        cte.product_id
        , price
    from cte
    where rn = 1
    union
    select
        *
    from default_price
)

-- return the highest price per product
select
    product_id
    , price
from cte2
group by product_id