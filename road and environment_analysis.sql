-- 1. Which road types recorded the highest number of collisions?

select * from collisions;

select
    case
        when road_type = 1 then 'Roundabout'
        when road_type = 2 then 'One way street'
        when road_type = 3 then 'Dual carriageway'
        when road_type = 6 then 'Single carriageway'
        when road_type = 7 then 'Slip road'
        when road_type = 9 then 'Unknown'
        else 'Other'
    end as road_type_name,
    count(*) as collision_count
from collisions
group by road_type
order by collision_count desc;

-- road_type is stored as a numeric code in the original dft dataset. 
-- the values below were decoded using the official dft data guide.

-- output: single carriageways recorded the highest number of collisions, with 74,150 cases.

-- 2. How do weather conditions relate to collision frequency and severity?

select
    case
        when weather_conditions = 1 then 'Fine without high winds'
        when weather_conditions = 2 then 'Raining without high winds'
        when weather_conditions = 3 then 'Snowing without high winds'
        when weather_conditions = 4 then 'Fine with high winds'
        when weather_conditions = 5 then 'Raining with high winds'
        when weather_conditions = 6 then 'Snowing with high winds'
        when weather_conditions = 7 then 'Fog or mist'
        when weather_conditions = 8 then 'Other'
        when weather_conditions = 9 then 'Unknown'
        else 'No data'
    end as weather_condition,
    count(*) as collision_count,
    sum(case when collision_severity = 1 then 1 else 0 end) as fatal,
    sum(case when collision_severity = 2 then 1 else 0 end) as serious,
    sum(case when collision_severity = 3 then 1 else 0 end) as slight
from collisions
group by weather_conditions
order by collision_count desc;

-- output: fine weather without high winds recorded the highest number of collisions (83405 records).


-- 3. How do light conditions affect collision frequency and severity?

select
    case
        when light_conditions = 1 then 'Daylight'
        when light_conditions = 4 then 'Darkness: street lights present and lit'
        when light_conditions = 5 then 'Darkness: street lights present but unlit'
        when light_conditions = 6 then 'Darkness: no street lighting'
        when light_conditions = 7 then 'Darkness: street lighting unknown'
        else 'No data'
    end as light_condition,
    count(*) as collision_count,
    sum(case when collision_severity = 1 then 1 else 0 end) as fatal,
    sum(case when collision_severity = 2 then 1 else 0 end) as serious,
    sum(case when collision_severity = 3 then 1 else 0 end) as slight
from collisions
group by light_conditions
order by collision_count desc;

-- output: most collisions occurred during daylight, with 72,814 cases.
-- however, collisions in darkness with no street lighting had a noticeably
-- higher proportion of serious or fatal (36.3%) outcomes than daylight collisions.

-- 4. Which combinations of road surface, weather and light conditions are associated with 
-- the highest proportion of serious or fatal collisions?

select
    case
        when road_surface_conditions = 1 then 'Dry'
        when road_surface_conditions = 2 then 'Wet/Damp'
        when road_surface_conditions = 3 then 'Snow'
        when road_surface_conditions = 4 then 'Frost/Ice'
        when road_surface_conditions = 5 then 'Flood'
        when road_surface_conditions = 9 then 'Unknown'
        else 'No data'
    end as road_surface,

    case
        when weather_conditions = 1 then 'Fine without high winds'
        when weather_conditions = 2 then 'Raining without high winds'
        when weather_conditions = 3 then 'Snowing without high winds'
        when weather_conditions = 4 then 'Fine with high winds'
        when weather_conditions = 5 then 'Raining with high winds'
        when weather_conditions = 6 then 'Snowing with high winds'
        when weather_conditions = 7 then 'Fog or mist'
        when weather_conditions = 8 then 'Other'
        when weather_conditions = 9 then 'Unknown'
        else 'No data'
    end as weather_condition,

    case
        when light_conditions = 1 then 'Daylight'
        when light_conditions = 4 then 'Darkness: street lights present and lit'
        when light_conditions = 5 then 'Darkness: street lights present but unlit'
        when light_conditions = 6 then 'Darkness: no street lighting'
        when light_conditions = 7 then 'Darkness: street lighting unknown'
        else 'No data'
    end as light_condition,

    count(*) as total_collisions,
    sum(
        case
            when collision_severity in (1, 2) then 1
            else 0
        end
    ) as serious_fatal,

    round(
        sum(case when collision_severity in (1, 2) then 1 else 0 end)
        / count(*) * 100,
        2
    ) as serious_fatal_percentage
from collisions
group by
    road_surface_conditions,
    weather_conditions,
    light_conditions
having count(*) >= 100
order by serious_fatal_percentage desc;

-- output: the highest serious-or-fatal collision proportion was recorded on wet/damp roads,
-- during fine weather without high winds, and in darkness with no street lighting.
-- this combination had 1,183 collisions, of which 475 were serious or fatal,
-- giving a serious-or-fatal rate of 40.15%.