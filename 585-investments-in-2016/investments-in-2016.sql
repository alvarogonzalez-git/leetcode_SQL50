# Write your MySQL query statement below

-- create table with unique lat/lon combinations and count of appearance
with all_location as(
    select
        lat
        , lon
        , count(*) as count
    from Insurance
    group by lat, lon
)

-- create table with unique tiv_2015 investments and count of appearance
, tiv_2015_count as(
    select
        tiv_2015
        , count(*) as count
    from Insurance
    group by tiv_2015
    order by tiv_2015
)

-- returns sum of tiv_2016 investments when lat/lon combinations are unique and tiv_2015 invesment amounts are not.
select
    round(sum(tiv_2016), 2) as tiv_2016
from Insurance as i
inner join tiv_2015_count as t15
    on i.tiv_2015 = t15.tiv_2015
inner join all_location as loc
    on i.lat = loc.lat and i.lon = loc.lon
where t15.count > 1
    and loc.count = 1