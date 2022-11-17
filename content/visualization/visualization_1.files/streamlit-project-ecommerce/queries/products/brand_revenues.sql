-- top brand categories
select
    product_brand,
    SUM(product_price) as total_revenue
from
    `$1`.`$2`.snowplow_ecommerce_product_interactions
where
    is_product_transaction
GROUP BY 1
ORDER BY 2 DESC
