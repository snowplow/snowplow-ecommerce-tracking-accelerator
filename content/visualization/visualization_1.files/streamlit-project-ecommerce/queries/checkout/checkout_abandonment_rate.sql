-- checkout abandonment
with session_checkouts AS (
    select
        COUNT(DISTINCT domain_sessionid) as number_checkouts_attempted,
        COUNT(DISTINCT CASE WHEN checkout_succeeded THEN domain_sessionid END) as number_checkouts_succeeded
    from
        `$1`.`$2`.snowplow_ecommerce_checkout_interactions
)

select
    1 - (number_checkouts_succeeded / number_checkouts_attempted * 1.0) as checkout_abandonment_rate
from
    session_checkouts
