-- most used payment method
select
    transaction_payment_method,
    COUNT(DISTINCT transaction_id) as number_transactions
from
    `$1`.`$2`.snowplow_ecommerce_transaction_interactions
GROUP BY 1
ORDER BY 2 DESC
