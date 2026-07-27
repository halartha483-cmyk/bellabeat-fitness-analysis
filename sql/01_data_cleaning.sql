-- ==========================================
-- Bellabeat Fitness Analysis
-- Data Cleaning
-- ==========================================

-- Preview daily activity data
SELECT *
FROM `my-coursera-project-1-482107.bellabeat_capstone.dailyActivity_merged`
LIMIT 10;

-- Preview sleep data
SELECT *
FROM `my-coursera-project-1-482107.bellabeat_capstone.sleepDay_merged`
LIMIT 10;

-- Check duplicates in dailyActivity
SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT CONCAT(
CAST(Id AS STRING),
CAST(ActivityDate AS STRING)
)) AS unique_rows
FROM `my-coursera-project-1-482107.bellabeat_capstone.dailyActivity_merged`;

-- Check duplicates in sleepDay
SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT CONCAT(
CAST(Id AS STRING),
CAST(SleepDay AS STRING)
)) AS unique_rows
FROM `my-coursera-project-1-482107.bellabeat_capstone.sleepDay_merged`;

-- Identify duplicate sleep records
SELECT
Id,
SleepDay,
COUNT(*) AS duplicate_count
FROM `my-coursera-project-1-482107.bellabeat_capstone.sleepDay_merged`
GROUP BY
Id,
SleepDay
HAVING COUNT(*) > 1;

-- Create cleaned sleep table
CREATE OR REPLACE TABLE
`my-coursera-project-1-482107.bellabeat_capstone.sleepDay_cleaned` AS

SELECT DISTINCT *
FROM `my-coursera-project-1-482107.bellabeat_capstone.sleepDay_merged`;

-- Check NULL values in daily activity
SELECT
COUNTIF(Id IS NULL) AS null_id,
COUNTIF(ActivityDate IS NULL) AS null_activity_date,
COUNTIF(TotalSteps IS NULL) AS null_total_steps,
COUNTIF(Calories IS NULL) AS null_calories
FROM `my-coursera-project-1-482107.bellabeat_capstone.dailyActivity_merged`;

-- Check NULL values in cleaned sleep table
SELECT
COUNTIF(Id IS NULL) AS null_id,
COUNTIF(SleepDay IS NULL) AS null_sleep_day,
COUNTIF(TotalMinutesAsleep IS NULL) AS null_minutes_asleep,
COUNTIF(TotalTimeInBed IS NULL) AS null_time_in_bed
FROM `my-coursera-project-1-482107.bellabeat_capstone.sleepDay_cleaned`;
