-- Avg transaction value
select
    AVG(transaction_revenue) as average_transaction_quantity
from
    `$1`.`$2`.snowplow_ecommerce_transaction_interactions
