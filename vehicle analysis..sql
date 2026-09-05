-- 1. Which vehicle types were most frequently involved in road collisions?

select vehicle_type,
    count(*) as vehicle_count
from vehicles
group by vehicle_type
order by vehicle_count desc;

-- output: cars (vehicle_type = 9) were the most frequently involved vehicle type,
-- with 123,212 vehicles recorded in collisions.

-- 2. Which vehicle types were most frequently involved in serious or fatal collisions?
select
    v.vehicle_type,
    count(*) as vehicle_count
from vehicles v
join collisions c
    on v.collision_index = c.collision_index
where c.collision_severity in (1, 2)  -- 1 (fatal), 2 (serious)
group by vehicle_type
order by vehicle_count desc;

-- output: Vehicle type 9 was the most frequently involved, with 28,470 vehicles, 
-- followed by type 1 with 4,705 and type 19 with 3,029.

-- 3. How are drivers involved in collisions distributed across age groups?

select
    case
        when age_of_driver between 17 and 24 then '17-24'
        when age_of_driver between 25 and 34 then '25-34'
        when age_of_driver between 35 and 44 then '35-44'
        when age_of_driver between 45 and 54 then '45-54'
        when age_of_driver between 55 and 64 then '55-64'
        when age_of_driver >= 65 then '65+'
        else 'Unknown'
    end as age_group,
    count(*) as driver_count
from vehicles
group by age_group
order by driver_count desc;

-- output: drivers aged 25-34 were the largest group, with 34,399 drivers involved in collisions.	

-- 4. Does collision severity differ across driver age groups and sex?

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

    case
        when v.sex_of_driver = 1 then 'Male'
        when v.sex_of_driver = 2 then 'Female'
        else 'Unknown'
    end as driver_sex,

    count(*) as total_collisions,
    sum(case when c.collision_severity = 1 then 1 else 0 end) as fatal,
    sum(case when c.collision_severity = 2 then 1 else 0 end) as serious,
    sum(case when c.collision_severity = 3 then 1 else 0 end) as slight

from vehicles v
join collisions c
    on v.collision_index = c.collision_index

group by age_group, driver_sex
order by age_group, driver_sex;

-- output: male drivers had more collisions than female drivers across the age groups
-- (e.g. 25-34: 23,422 male vs 10,038 female).