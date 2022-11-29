-- Top variant added to cart per product
select
    product_id,
    product_variant,
    COUNT(DISTINCT CASE WHEN is_add_to_cart THEN event_id END) as number_add_to_cart,
from
    `$1`.`$2`.snowplow_ecommerce_product_interactions
GROUP BY 1,2
ORDER BY 1,2,3 DESC
