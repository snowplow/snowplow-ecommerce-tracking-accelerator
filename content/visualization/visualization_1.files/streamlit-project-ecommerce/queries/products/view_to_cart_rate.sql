-- `AddedToCart / ProductViews`
with product_stats AS (
    select
        product_id,
        COUNT(DISTINCT CASE WHEN is_add_to_cart THEN event_id END) as number_add_to_cart,
        COUNT(DISTINCT CASE WHEN is_product_view THEN event_id END) as number_product_views
    from
        `$1`.`$2`.snowplow_ecommerce_product_interactions
    GROUP BY 1
)
select
    product_id,
    CASE WHEN number_product_views > 0 THEN number_add_to_cart / number_product_views * 1.0 END as view_to_cart_rate
from
    product_stats
ORDER BY 2 DESC
