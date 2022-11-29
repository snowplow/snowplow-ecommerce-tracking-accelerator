-- average transaction quantity purchased
select
    AVG(number_products) as average_transaction_quantity
from
    `$1`.`$2`.snowplow_ecommerce_transaction_interactions
