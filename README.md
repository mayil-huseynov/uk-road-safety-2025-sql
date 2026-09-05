# UK Road Safety Analysis 2025

## Project Overview

This project explores UK road collision data from 2025 using MySQL.

The analysis focuses on collision patterns, road and environmental conditions, vehicles, drivers, casualties, and factors associated with serious or fatal outcomes.

## Data Source

The project uses official 2025 road safety open data published by the UK Department for Transport (DfT).

Three datasets were used:
- Collisions
- Vehicles
- Casualties

Numeric categorical values, such as road type, weather conditions, light conditions, and casualty classifications, were interpreted using the official DfT STATS20 specification.

## Tools & Technologies

- MySQL
- MySQL Workbench
- SQL
- Git
- GitHub

## SQL Concepts Used

- Joins
- Group By
- Case Statements
- Aggregate Functions
- Conditional Aggregation
- Filtering and Sorting
- Having Clause
- Percentage Calculations

## Analysis Structure

- `collision overview.sql` — examines overall collision volume, severity, day-of-week patterns, time periods, and speed limits.
- `road and environment_analysis.sql` — analyzes road types, weather, lighting, and road surface conditions.
- `vehicle analysis.sql` — explores vehicle types, driver age groups, sex, and collision severity.
- `casualty analysis.sql` — examines casualty age groups, severity, sex, and casualty classes.
- `advanced risk analysis.sql` — investigates combinations and characteristics associated with higher serious or fatal collision rates.

## Key Findings

- A total of 101,525 road collisions were recorded in the 2025 dataset.
- Friday recorded the highest number of collisions, with 16,811 cases.
- Roads with a 30 mph speed limit recorded the highest overall collision volume, with 49,673 collisions.
- Single carriageways accounted for the largest number of collisions, with 74,150 cases.
- Although most collisions occurred during daylight, serious or fatal outcomes were proportionally higher in darkness with no street lighting (36.3%) than in daylight (25.3%).
- Pedestrians had the highest serious-or-fatal casualty rate at 31.01%.
- Among vehicle types with at least 100 observations, motorcycles over 500cc had the highest serious-or-fatal collision rate at 53.84%.
- The highest-risk road/environment combination identified was 60 mph single carriageways in fine weather without high winds, with a serious-or-fatal rate of 38.93%.

## Database Setup & Data Import

The database was set up in MySQL Workbench, with separate tables for collisions, vehicles, and casualties.

The SQL used to create the database structure and import the CSV files is included in `database. csv import.sql`.

Data was imported using MySQL's `LOAD DATA LOCAL INFILE` command. Local file paths were replaced with placeholder paths so the script can be adapted to other systems.

## Codebook Reference

Several fields in the datasets use numeric codes rather than text labels. These values were interpreted using the official DfT STATS20 specification.

The reference document used in this project is available here:

[DfT STATS20 Specification](reference/STATS20_2024_specification.pdf)

## Limitations

- The analysis is based on recorded road collision data, so it does not represent every road incident that may have occurred.
- Higher collision counts do not necessarily mean that a road type, weather condition, or driver group is more dangerous, since exposure levels are not included in the dataset.
- The results show patterns and associations in the data, but they should not be interpreted as proof of causation.

## AI Usage

I used AI for guidance on how to structure the analysis and for support while importing the datasets into MySQL.

## How to Run

1. Create the database and tables using `database. csv import.sql`.
2. Update the local CSV file paths in the import statements.
3. Run the analysis files in MySQL Workbench.