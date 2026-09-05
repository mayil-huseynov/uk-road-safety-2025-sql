-- 1. Which vehicle types have the highest proportion of serious or fatal collisions?

select
    v.vehicle_type,
    count(*) as total_vehicles,
    sum(case when c.collision_severity in (1, 2) then 1 else 0 end) as serious_fatal,
    round(
        sum(case when c.collision_severity in (1, 2) then 1 else 0 end)
        / count(*) * 100,
        2
    ) as serious_fatal_percentage
from vehicles v
join collisions c
    on v.collision_index = c.collision_index
group by v.vehicle_type
having count(*) >= 100
order by serious_fatal_percentage desc;

-- output: vehicle type 5 (motorcycle over 500cc) had the highest serious-or-fatal collision rate,
-- at 53.84% (2,679 out of 4,976 vehicles).


-- 2. Which combinations of speed limit, 
-- road type and weather conditions show the highest serious/fatal collision rate?

select
    speed_limit,
    road_type,
    weather_conditions,
    count(*) as total_collisions,
    sum(case when collision_severity in (1, 2) then 1 else 0 end) as serious_fatal,
    round(
        sum(case when collision_severity in (1, 2) then 1 else 0 end)
        / count(*) * 100,
        2
    ) as serious_fatal_percentage
from collisions
group by speed_limit, road_type, weather_conditions
having count(*) >= 100
order by serious_fatal_percentage desc;

-- output: 60 mph single carriageways in fine weather without high winds had the highest serious-or-fatal collision rate,
-- at 38.93% (3,666 out of 9,417 collisions).


-- 3. Which driver age groups appear most frequently in serious or fatal collisions, 
-- and how do they rank against each other?

select
    case
        when v.age_of_driver between 17 and 24 then '17-24'
        when v.age_of_driver between 25 and 34 then '25-34'
        when v.age_of_driver between 35 and 44 then '35-44'
        when v.age_of_driver between 45 and 54 then '45-54'
        when v.age_of_driver between 55 and 64 then '55-64'
        when v.age_of_driver >= 65 then '65+'
        else 'Unknown'
    end as age_group,
    count(*) as serious_fatal_count
from vehicles v
join collisions c
    on v.collision_index = c.collision_index
where c.collision_severity in (1, 2)
group by age_group
order by serious_fatal_count desc;


-- output: drivers aged 25-34 appeared most frequently in serious or fatal collisions,
-- with 8,396 cases.


-- 4. What characteristics are most common among serious or fatal road collisions 2025?
	-- 4.1 Speed limit:
    
    select speed_limit, count(*) as collisions_count 
    from collisions 
    where collision_severity in (1, 2) 
    group by speed_limit
    order by collisions_count desc;
    
    -- speed limit output: 30 mph roads recorded the highest number of serious or fatal collisions, 
    -- with 12,323 cases.
    
    -- 4.2 Road type:
    
    select road_type, count(*) as collision_count
	from collisions
	where collision_severity in (1, 2)
	group by road_type
	order by collision_count desc;
    
    -- output: single carriageways (code 6) recorded the highest number
	-- of serious or fatal collisions, with 20,707 cases.
    
    -- 4.3 Weather Condition:
    
    select weather_conditions, count(*) as collision_count
	from collisions
	where collision_severity in (1, 2)
	group by weather_conditions
	order by collision_count desc;
    
    -- output: fine weather without high winds (code 1) recorded the highest number
	-- of serious or fatal collisions, with 22,336 cases.