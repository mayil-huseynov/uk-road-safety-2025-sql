select 'collisions' as table_name, count(*) as row_count
from collisions

union all

select 'vehicles', count(*) from vehicles

union all

select 'casualties', count(*) from casualties;

-- 1. How many road collisions were recorded in 2025, and how are they distributed by severity?

select count(*) as total_collisions from collisions;

-- output: 101525

-- 2. Which days of the week recorded the highest number of collisions?

-- before completing the task, I converted the numeric day-of-week codes into weekday names 
-- for readability.

select
    case
        when day_of_week = 1 then 'Sunday'
        when day_of_week = 2 then 'Monday'
        when day_of_week = 3 then 'Tuesday'
        when day_of_week = 4 then 'Wednesday'
        when day_of_week = 5 then 'Thursday'
        when day_of_week = 6 then 'Friday'
        when day_of_week = 7 then 'Saturday'
    end as weekday,
    count(*) as collision_count
from collisions
group by day_of_week
order by collision_count desc;

-- output: friday (16811 collisions recorded)

-- 3. At what times of day did most collisions occur?

select time
from collisions
limit 10;

-- as the time column is stored in hh:mm format, i used a case statement
-- to categorize collisions into night, morning, afternoon, and evening periods.

select
    case
        when time between '00:00' and '05:59' then 'Night'
        when time between '06:00' and '11:59' then 'Morning'
        when time between '12:00' and '17:59' then 'Afternoon'
        when time between '18:00' and '23:59' then 'Evening'
    end as time_of_day,
    count(*) as collision_count
from collisions
group by time_of_day
order by collision_count desc;

-- output: afternoon (44365 collisions recorded)

-- 4. How does collision severity vary across different speed limits?

-- i used case statements to compare fatal, serious, and slight collisions
-- across different speed limits in separate columns.

select
    speed_limit,
    sum(case when collision_severity = 1 then 1 else 0 end) as fatal,
    sum(case when collision_severity = 2 then 1 else 0 end) as serious,
    sum(case when collision_severity = 3 then 1 else 0 end) as slight,
    count(*) as total_collisions
from collisions
group by speed_limit
order by speed_limit;

-- output: collisions were most common on 30 mph roads, with 49,673 recorded cases.
-- this speed limit also had the highest number of fatal (428), serious (11,895),
-- and slight (37,350) collisions.

