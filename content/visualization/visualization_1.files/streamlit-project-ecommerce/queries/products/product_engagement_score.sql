with product_stats AS (
    select
        product_id,
        COUNT(DISTINCT CASE WHEN is_product_view THEN event_id END) as number_product_views,
        COUNT(DISTINCT CASE WHEN is_add_to_cart OR is_remove_from_cart THEN event_id END) as number_cart_interactions,
        COUNT(DISTINCT CASE WHEN is_product_transaction THEN event_id END) as number_product_purchases

    from
        `$1`.`$2`.snowplow_ecommerce_product_interactions
    GROUP BY 1
)
SELECT
    product_id,
    100.0 * (number_cart_interactions + number_product_purchases) / number_product_views as product_engagment_score
FROM
    product_stats
ORDER BY 2
