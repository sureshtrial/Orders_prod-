{{ config(
    target_schema='snapshots',
    unique_key='customer_id',
    strategy='check',
    check_cols=['first_name', 'last_name', 'email']
) }}

SELECT
    id AS customer_id,
    first_name,
    last_name,
    email,
    signup_date::date AS signup_date
FROM {{ source('raw', 'customers') }}