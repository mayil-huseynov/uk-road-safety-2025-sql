DROP DATABASE IF EXISTS uk_road_safety;
CREATE DATABASE uk_road_safety;

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

USE uk_road_safety;

CREATE TABLE collisions (
    collision_index VARCHAR(20),
    collision_year INT,
    collision_ref_no VARCHAR(20),
    location_easting_osgr INT,
    location_northing_osgr INT,
    longitude DECIMAL(10,6),
    latitude DECIMAL(10,6),
    police_force INT,
    collision_severity INT,
    number_of_vehicles INT,
    number_of_casualties INT,
    date VARCHAR(10),
    day_of_week INT,
    time VARCHAR(5),
    local_authority_district INT,
    local_authority_ons_district VARCHAR(20),
    local_authority_highway VARCHAR(20),
    local_authority_highway_current VARCHAR(20),
    first_road_class INT,
    first_road_number INT,
    road_type INT,
    speed_limit INT,
    junction_detail_historic INT,
    junction_detail INT,
    junction_control INT,
    second_road_class INT,
    second_road_number INT,
    pedestrian_crossing_human_control_historic INT,
    pedestrian_crossing_physical_facilities_historic INT,
    pedestrian_crossing INT,
    light_conditions INT,
    weather_conditions INT,
    road_surface_conditions INT,
    special_conditions_at_site INT,
    carriageway_hazards_historic INT,
    carriageway_hazards INT,
    urban_or_rural_area INT,
    did_police_officer_attend_scene_of_accident INT,
    trunk_road_flag INT,
    lsoa_of_accident_location VARCHAR(20),
    enhanced_severity_collision INT,
    collision_injury_based INT,
    collision_adjusted_severity_serious INT,
    collision_adjusted_severity_slight INT
);
SHOW TABLES;

SHOW VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE
'path/to/dft-road-casualty-statistics-collision-2025.csv'
INTO TABLE collisions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
