-- Customer order count
select
    ecommerce_user_id,
    COUNT(DISTINCT transaction_id) as order_count

from
    `$1`.`$2`.snowplow_ecommerce_transaction_interactions
GROUP BY 1
ORDER BY 2 DESC;
