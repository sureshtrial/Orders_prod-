-- models/staging/stg_orders.sql
{{ config(materialized='view') }}
SELECT
  id            AS order_id,
  customer_id   AS customer_id,
  product_id    AS product_id,
  order_date    ::date AS order_date,
  quantity      ::int  AS quantity,
  total_amount  ::decimal AS amount,
  status
FROM {{ source('raw','orders') }}
WHERE status IS NOT NULL
