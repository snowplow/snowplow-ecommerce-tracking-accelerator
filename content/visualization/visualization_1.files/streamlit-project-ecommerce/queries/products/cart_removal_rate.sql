-- Products removal from cart (`RemovedFromCart/AddedToCart`)
with product_stats AS (
    select
        product_id,
        COUNT(DISTINCT CASE WHEN is_add_to_cart THEN event_id END) as number_add_to_cart,
        COUNT(DISTINCT CASE WHEN is_remove_from_cart THEN event_id END) as number_remove_from_cart
    from
        `$1`.`$2`.snowplow_ecommerce_product_interactions
    GROUP BY 1
)
select
    product_id,
    CASE WHEN number_add_to_cart > 0 THEN number_remove_from_cart / number_add_to_cart * 1.0 END as cart_removal_rate
from
    product_stats
