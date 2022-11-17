-- top revenue categories
select
    product_category,
    SUM(product_price) as total_revenue
from
    `$1`.`$2`.snowplow_ecommerce_product_interactions
where
    is_product_transaction
GROUP BY 1
ORDER BY 2 DESC
