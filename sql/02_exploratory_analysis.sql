-- ==========================================
-- Bellabeat Fitness Analysis
-- Exploratory Data Analysis (EDA)
-- ==========================================

-- Overall user activity summary
SELECT
  COUNT(DISTINCT Id) AS total_users,
  ROUND(AVG(TotalSteps), 0) AS avg_daily_steps,
  ROUND(AVG(Calories), 0) AS avg_daily_calories
FROM `my-coursera-project-1-482107.bellabeat_capstone.dailyActivity_merged`;

-- Activity level distribution
SELECT
  CASE
    WHEN TotalSteps < 5000 THEN 'Sedentary'
    WHEN TotalSteps BETWEEN 5000 AND 7499 THEN 'Low Active'
    WHEN TotalSteps BETWEEN 7500 AND 9999 THEN 'Somewhat Active'
    ELSE 'Active'
  END AS activity_level,

  COUNT(*) AS total_days,
  ROUND(AVG(TotalSteps), 0) AS avg_steps,
  ROUND(AVG(Calories), 0) AS avg_calories

FROM `my-coursera-project-1-482107.bellabeat_capstone.dailyActivity_merged`

GROUP BY activity_level

ORDER BY avg_steps;

-- Average sleep duration
SELECT
  ROUND(AVG(TotalMinutesAsleep), 0) AS avg_minutes_asleep,
  ROUND(AVG(TotalTimeInBed), 0) AS avg_minutes_in_bed
FROM `my-coursera-project-1-482107.bellabeat_capstone.sleepDay_cleaned`;

-- Average activity by day of week
SELECT
  FORMAT_DATE('%A', ActivityDate) AS day_of_week,
  ROUND(AVG(TotalSteps), 0) AS avg_steps,
  ROUND(AVG(Calories), 0) AS avg_calories
FROM `my-coursera-project-1-482107.bellabeat_capstone.dailyActivity_merged`

GROUP BY day_of_week

ORDER BY avg_steps DESC;
