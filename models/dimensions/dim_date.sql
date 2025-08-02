{{ config(materialized='table') }}

-- 1. pull your date bounds
WITH bounds AS (
  SELECT
    MIN(order_date) AS start_date,
    MAX(order_date) AS end_date
  FROM {{ ref('stg_orders') }}
),

-- 2. build a recursive calendar from start_date → end_date
calendar AS (
  -- anchor: first day
  SELECT
    start_date       AS day,
    end_date
  FROM bounds

  UNION ALL

  -- recursive step: add 1 day until we hit end_date
  SELECT
    DATEADD(day, 1, day) AS day,
    end_date
  FROM calendar
  WHERE day < end_date
)

-- 3. project your dimension
SELECT
  day                       AS date,
  YEAR(day)                 AS year,
  MONTH(day)                AS month,
  DAYOFMONTH(day)           AS day_of_month,
  TO_CHAR(day, 'DY')        AS weekday_abbrev,
  TO_CHAR(day, 'Day')       AS weekday_full
FROM calendar
ORDER BY date