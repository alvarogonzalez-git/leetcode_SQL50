# Write your MySQL query statement below
with product_sales as(
    select
        product_id
        , sum(unit) as unit
    from (
        select
        *
        from Orders
        where month(order_date) = 2
         and year(order_date) = 2020
    ) as feb_orders
    group by product_id
)

select
    p.product_name as product_name
    , ps.unit
from product_sales as ps
join Products as p
    on ps.product_id = p.product_id
where unit >= 100