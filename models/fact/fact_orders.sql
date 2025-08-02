-- models/facts/fact_orders.sql
{{ 
  config(
    materialized='incremental',
    unique_key='order_id'
  ) 
}}
WITH base AS (
  SELECT
    o.order_id,
    o.order_date,
    c.customer_id,
    p.product_id,
    o.quantity,
    o.amount
  FROM {{ ref('stg_orders') }} o
  JOIN {{ ref('dim_customer') }} c USING (customer_id)
  JOIN {{ ref('dim_product') }} p USING (product_id)
)
SELECT
  order_id,
  order_date,
  customer_id,
  product_id,
  quantity,
  amount
FROM base

{% if is_incremental() %}
  WHERE order_id NOT IN (SELECT order_id FROM {{ this }})
{% endif %}
