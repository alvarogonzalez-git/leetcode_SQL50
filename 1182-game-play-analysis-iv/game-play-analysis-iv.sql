# Write your MySQL query statement below
-- create table with player_id and first login date + 1 day
with login as(
select
    player_id
    , date_add(min(event_date), interval 1 day) as login
from Activity
group by player_id
order by player_id
)

-- create table to return player_id who have a consec day login after first log in
, consec_count as(
    select
        l.player_id
        , l.login
        , a.event_date
    from login as l
    inner join Activity a
        on l.player_id = a.player_id
        and l.login = a.event_date
    group by l.player_id
)

-- create table with rows of total number of players
, total_count as(
    select
        player_id
    from Activity
    group by player_id
)

-- divide consecutive players to total player count
select 
    round(
        (select count(*) from consec_count) 
        / (select count(*) from total_count)
    , 2) as fraction