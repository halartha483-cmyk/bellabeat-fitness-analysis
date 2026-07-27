-- ==========================================
-- Bellabeat Fitness Analysis
-- Business Analysis
-- ==========================================

-- Join activity and sleep data
SELECT
  ROUND(AVG(a.TotalSteps), 0) AS avg_steps,
  ROUND(AVG(s.TotalMinutesAsleep), 0) AS avg_sleep_minutes
FROM
  `my-coursera-project-1-482107.bellabeat_capstone.dailyActivity_merged` a
JOIN
  `my-coursera-project-1-482107.bellabeat_capstone.sleepDay_cleaned` s
ON
  a.Id = s.Id
  AND PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', s.SleepDay)
      BETWEEN DATETIME(a.ActivityDate)
      AND DATETIME(DATE_ADD(a.ActivityDate, INTERVAL 1 DAY));

-- Activity level vs sleep duration
WITH activity_sleep AS (
  SELECT
    a.TotalSteps,
    s.TotalMinutesAsleep
  FROM
    `my-coursera-project-1-482107.bellabeat_capstone.dailyActivity_merged` a
  JOIN
    `my-coursera-project-1-482107.bellabeat_capstone.sleepDay_cleaned` s
  ON
    a.Id = s.Id
    AND PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', s.SleepDay)
        BETWEEN DATETIME(a.ActivityDate)
        AND DATETIME(DATE_ADD(a.ActivityDate, INTERVAL 1 DAY))
)

SELECT
  CASE
    WHEN TotalSteps < 5000 THEN 'Sedentary'
    WHEN TotalSteps BETWEEN 5000 AND 7499 THEN 'Low Active'
    WHEN TotalSteps BETWEEN 7500 AND 9999 THEN 'Somewhat Active'
    ELSE 'Active'
  END AS activity_level,

  COUNT(*) AS records,
  ROUND(AVG(TotalSteps), 0) AS avg_steps,
  ROUND(AVG(TotalMinutesAsleep), 0) AS avg_sleep_minutes

FROM activity_sleep

GROUP BY activity_level

ORDER BY avg_steps;

-- Business Insight:
-- Higher activity levels did not necessarily correspond to longer sleep duration.
-- Bellabeat should promote both activity tracking and sleep monitoring
-- as complementary wellness features.

-- Business Recommendations:
-- 1. Encourage users to increase daily activity through personalized step goals.
-- 2. Improve Sunday engagement with reminders and activity challenges.
-- 3. Promote holistic wellness by combining activity and sleep insights.
