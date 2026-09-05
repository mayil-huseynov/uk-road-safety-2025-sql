-- 1. Which age groups accounted for the highest number of casualties? 

select
    age_band_of_casualty,
    count(*) as casualty_count
from casualties
group by age_band_of_casualty
order by casualty_count desc;

-- output: age band 6 (25-34) recorded the highest number of casualties, with 24,510 cases.

-- 2. How does casualty severity vary across age groups?

select
    age_band_of_casualty,
    casualty_severity,
    count(*) as casualty_count
from casualties
group by age_band_of_casualty, casualty_severity
order by age_band_of_casualty, casualty_severity;

-- output: slight injuries were the most common severity across the age groups.

-- 3. How does casualty severity differ by sex?

select
    case
        when sex_of_casualty = 1 then 'Male'
        when sex_of_casualty = 2 then 'Female'
        else 'Unknown'
    end as casualty_sex,
    count(*) as total_casualties,
    sum(case when casualty_severity = 1 then 1 else 0 end) as fatal,
    sum(case when casualty_severity = 2 then 1 else 0 end) as serious,
    sum(case when casualty_severity = 3 then 1 else 0 end) as slight
from casualties
group by casualty_sex
order by total_casualties desc;

-- output: male casualties were more frequent than female casualties
-- (77,637 male vs 48,874 female).

-- 4. Are drivers, passengers or pedestrians more likely to sustain serious or fatal injuries?

select
    case
        when casualty_class = 1 then 'Driver or rider'
        when casualty_class = 2 then 'Passenger'
        when casualty_class = 3 then 'Pedestrian'
        else 'Unknown'
    end as casualty_class_name,
    count(*) as total_casualties,
    sum(case when casualty_severity in (1, 2) then 1 else 0 end) as serious_fatal,
    round(
        sum(case when casualty_severity in (1, 2) then 1 else 0 end)
        / count(*) * 100,
        2
    ) as serious_fatal_percentage
from casualties
group by casualty_class_name
order by serious_fatal_percentage desc;

-- output: pedestrians had the highest serious-or-fatal injury rate, at 31.01%.