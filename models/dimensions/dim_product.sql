-- models/dimensions/dim_product.sql
{{ config(materialized='table') }}
SELECT
  id   AS product_id,
  product_name,
  category,
  price
FROM {{ source('raw','products') }}
