-- Top variant in transactions per product
select
    product_id,
    product_variant,
    COUNT(DISTINCT CASE WHEN is_product_transaction THEN event_id END) as number_purchased,
from
    `$1`.`$2`.snowplow_ecommerce_product_interactions
GROUP BY 1,2
ORDER BY 1,2,3 DESC
