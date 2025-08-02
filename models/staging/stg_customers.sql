-- models/staging/stg_customers.sql
{{ config(materialized='view') }}
SELECT
  id            AS customer_id,
  first_name,
  last_name,
  email,
  signup_date  ::date AS signup_date
FROM {{ source('raw','customers') }}
