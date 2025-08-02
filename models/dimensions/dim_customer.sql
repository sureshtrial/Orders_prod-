-- models/dimensions/dim_customer.sql
{{ config(materialized='table') }}
SELECT
  customer_id,
  CONCAT(first_name, ' ', last_name) AS full_name,
  email,
  signup_date
FROM {{ ref('stg_customers') }}
