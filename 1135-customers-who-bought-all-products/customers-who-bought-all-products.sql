# Write your MySQL query statement below
with product_count as(
    select
        count(distinct product_key) as no_product
    from Product
)

select
    customer_id
from Customer
group by customer_id
having count(distinct product_key) = (select no_product from product_count)