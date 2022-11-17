-- Product views in out-of-stock products
with temp as (
    SELECT dates FROM (
        SELECT
            MAX(date_trunc(CAST(derived_tstamp AS DATE), DAY)) max_date
        FROM
            `$1`.`$2`.snowplow_ecommerce_product_interactions
    ), UNNEST(GENERATE_DATE_ARRAY(max_date - 30, max_date)) dates
),

out_of_stock_views as (
    SELECT
        DATE_TRUNC(CAST(derived_tstamp AS DATE), DAY) AS Dates,
        COUNT(DISTINCT event_id) AS number_views
    FROM
        `$1`.`$2`.snowplow_ecommerce_product_interactions
    WHERE
        is_product_view
        AND product_inventory_status = 'out_of_stock'
    group by 1
)

SELECT
    temp.dates AS Date,
    coalesce(number_views, 0) AS out_of_stock_views
FROM
    TEMP
    LEFT JOIN out_of_stock_views b
        ON temp.dates = b.dates
