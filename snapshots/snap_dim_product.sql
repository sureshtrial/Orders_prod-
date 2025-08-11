{% snapshot snap_dim_product %}
{{ config(
    target_schema='snapshots',
    unique_key='product_id',
    strategy='check',
    check_cols=['product_name', 'category', 'price']
) }}

SELECT
    id AS product_id,
    product_name,
    category,
    price
FROM {{ source('raw', 'products') }}

{% endsnapshot %}
